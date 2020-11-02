using Eatery.Business.Interface;
using Eatery.Common;
using Eatery.DAL.Interface;
using Eatery.DAL.Repository.Interface;
using Eatery.DataContracts;
using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business
{
    public class MenuItemBL : IMenuItemBL
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMenuItemRepository _MenuItemRepository;
        private readonly IRawSQLDbContext _rawSQLDbContext;

        public MenuItemBL(
            IUnitOfWork unitOfWork,
            IMenuItemRepository MenuItemRepository,
            IRawSQLDbContext rawSQLDbContext)
        {
            this._unitOfWork = unitOfWork;
            this._MenuItemRepository = MenuItemRepository;
            this._rawSQLDbContext = rawSQLDbContext;
        }

        public int Count()
        {
            int MenuItemsCount = default(int);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                MenuItemsCount = this._MenuItemRepository.GetAllQuery(context).Count();
            }
            return MenuItemsCount;
        }

        public bool Add(MenuItemDTO MenuItemDTO, int userID)
        {
            if (MenuItemDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    MenuItem MenuItem = ObjectTypeConverter.Convert<MenuItemDTO, MenuItem>(MenuItemDTO);
                    MenuItem.CreatedBy = userID;
                    MenuItem.CreatedDate = DateTime.Now;

                    this._MenuItemRepository.Add(context, MenuItem);
                    _unitOfWork.Commit(context);

                    return true;
                }
            }
            return false;
        }

        public MenuItemDTO Update(MenuItemDTO menuItemDTO, int? userID)
        {
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                MenuItem menuItem = ObjectTypeConverter.Convert<MenuItemDTO, MenuItem>(menuItemDTO);
                menuItem.UpdatedDate = DateTime.Now;
                menuItem.UpdatedBy = userID;

                menuItem = this._MenuItemRepository.Update(context, menuItem);
                _unitOfWork.Commit(context);
                if (menuItem != null)
                {
                    return ObjectTypeConverter.Convert<MenuItem, MenuItemDTO>(menuItem);
                }
            }
            return default(MenuItemDTO);
        }

        public MenuItemPublishDTO PublishMenuItem(MenuItemPublishDTO menuItempublishDTO, int? userID)
        {
            if (menuItempublishDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    using (var dbContextTransaction = ((IDbContext)context).GetDataBase().BeginTransaction())
                    {
                        try
                        {
                            if (userID > 0 && menuItempublishDTO.RestaurantID > 0)
                            {
                                foreach (var MenuItemDTO in menuItempublishDTO.MenuItemList)
                                {
                                    this.Update(MenuItemDTO, userID);
                                }
                                dbContextTransaction.Commit();
                            }
                            else
                            {
                                dbContextTransaction.Rollback();
                            }
                        }
                        catch (Exception)
                        {
                            dbContextTransaction.Rollback();
                        }
                    }
                }
            }
            return menuItempublishDTO;
        }

        public MenuItemDTO GetMenuItemById(int MenuItemID)
        {
            MenuItemDTO MenuItemDto = default(MenuItemDTO);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {
                    MenuItem MenuItem = this._MenuItemRepository.GetAllQuery(context).FirstOrDefault(x => x.ID == MenuItemID);
                    if (MenuItem != null)
                    {
                        MenuItemDto = ObjectTypeConverter.Convert<MenuItem, MenuItemDTO>(MenuItem);
                        return MenuItemDto;
                    }
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return MenuItemDto;
        }

        public List<MenuItemSearchDTO> GetNearMenuItems(SearchCriteriaDTO criteria)
        {
            List<MenuItemSearchDTO> MenuItemSearchDTOList = new List<MenuItemSearchDTO>();
            try
            {
                MenuItemSearchDTOList = this._rawSQLDbContext.GetNearMenuItems(criteria);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return MenuItemSearchDTOList;
        }

        public List<MenuItemSearchDTO> SearchMenuItems(SearchCriteriaDTO criteria)
        {
            List<MenuItemSearchDTO> MenuItemSearchDTOList = new List<MenuItemSearchDTO>();
            try
            {
                MenuItemSearchDTOList = this._rawSQLDbContext.SearchMenuItems(criteria);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return MenuItemSearchDTOList;
        }

        public List<MenuItemSearchDTO> GetAllNearByMenuItems(SearchCriteriaDTO criteria)
        {
            List<MenuItemSearchDTO> MenuItemSearchDTOList = new List<MenuItemSearchDTO>();
            try
            {
                MenuItemSearchDTOList = this._rawSQLDbContext.GetAllNearByMenuItems(criteria);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return MenuItemSearchDTOList;
        }

        public MenuItemSearchDTO GetMenuItemDetail(int MenuItemID, decimal latitude, decimal longitude)
        {
            MenuItemSearchDTO MenuItemSearchDTO = default(MenuItemSearchDTO);
            try
            {
                MenuItemSearchDTO = this._rawSQLDbContext.GetMenuItemDetail(MenuItemID, latitude, longitude);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return MenuItemSearchDTO;
        }

        public List<MenuItemDTO> GetMenuItemsByRestaurantID(int RestaurantID, int? page, int pageSize)
        {
            List<MenuItemDTO> MenuItems = default(List<MenuItemDTO>);
            try
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {

                    var MenuItemList = this._MenuItemRepository.GetAllQuery(context)
                                            .OrderByDescending(x => x.ID)
                                            .Where(x => x.RestaurantID == RestaurantID)
                                            .Skip((page ?? 0) * pageSize)
                                            .Take(pageSize)
                                            .ToList();
                    if (MenuItemList != null && MenuItemList.Any())
                    {
                        MenuItems = ObjectTypeConverter.ConvertList<MenuItem, MenuItemDTO>(MenuItemList).ToList();
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return MenuItems;
        }
    }


}
