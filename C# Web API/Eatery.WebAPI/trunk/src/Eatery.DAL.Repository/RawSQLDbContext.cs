using Eatery.DAL.Interface;
using Eatery.DAL.Repository.Interface;
using Eatery.DataContracts;
using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Eatery.Common;
using System.Data.Common;
using System.Data.Entity.Infrastructure;
using System.Configuration;

namespace Eatery.DAL.Repository
{
    public class RawSQLDbContext : IRawSQLDbContext
    {
        #region MenuItem

        #region Get Near MenuItems

        public List<MenuItemSearchDTO> GetNearMenuItems(SearchCriteriaDTO criteria)
        {
            List<MenuItemSearchDTO> MenuItemSearchList = new List<MenuItemSearchDTO>();
            using (var context = new EateryDbContext())
            {
                MenuItemSearchList = context.Database.SqlQuery<MenuItemSearchDTO>("dbo.spGetNearServices " +
                    "@latitude, @longtitude, @distance, @userType, @pageNumber, @pageSize, @orderBy",
                    new SqlParameter("@latitude", criteria.Latitude),
                    new SqlParameter("@longtitude", criteria.Longitude),
                    new SqlParameter("@distance", criteria.Distance),
                    new SqlParameter("@userType", (int)UserTypeEnum.Restaurant),
                    new SqlParameter("@pageNumber", criteria.PageNumber),
                    new SqlParameter("@pageSize", criteria.PageSize),
                    new SqlParameter("@orderBy", criteria.OrderBy)
                    ).ToList();
            }
            return MenuItemSearchList;
        }

        public List<MenuItemSearchDTO> SearchMenuItems(SearchCriteriaDTO criteria)
        {
            List<MenuItemSearchDTO> MenuItemSearchList = new List<MenuItemSearchDTO>();
            using (var context = new EateryDbContext())
            {
                MenuItemSearchList = context.Database.SqlQuery<MenuItemSearchDTO>("dbo.spSearchMenuItems " +
                    "@keyword, @location, @latitude, @longitude, @distance, @minRating, " +
                    "@userType, @pageNumber, @pageSize, @orderBy",
                    new SqlParameter("@keyword", string.IsNullOrWhiteSpace(criteria.Keyword) ? (object)DBNull.Value : criteria.Keyword),
                    new SqlParameter("@location", string.IsNullOrWhiteSpace(criteria.Location) ? (object)DBNull.Value : criteria.Location),
                    new SqlParameter("@latitude", criteria.Latitude),
                    new SqlParameter("@longitude", criteria.Longitude),
                    new SqlParameter("@distance", criteria.Distance == null || criteria.Distance == default(double) ? (object)DBNull.Value : criteria.Distance),
                    new SqlParameter("@minRating", criteria.MinRating == null || criteria.MinRating == default(double) ? (object)DBNull.Value : criteria.MinRating),
                    new SqlParameter("@userType", (int)UserTypeEnum.Restaurant),
                    new SqlParameter("@pageNumber", criteria.PageNumber == null || criteria.PageNumber == default(int) ? (object)DBNull.Value : criteria.PageNumber),
                    new SqlParameter("@pageSize", criteria.PageSize == null || criteria.PageSize == default(int) ? (object)DBNull.Value : criteria.PageSize),
                    new SqlParameter("@orderBy", string.IsNullOrWhiteSpace(criteria.OrderBy) ? (object)DBNull.Value : criteria.OrderBy)
                    ).ToList();
            }
            return MenuItemSearchList;
        }

        public List<MenuItemSearchDTO> GetAllNearByMenuItems(SearchCriteriaDTO criteria)
        {
            List<MenuItemSearchDTO> MenuItemSearchList = new List<MenuItemSearchDTO>();
            using (var context = new EateryDbContext())
            {
                MenuItemSearchList = context.Database.SqlQuery<MenuItemSearchDTO>("dbo.spGetAllNearByMenuItems " +
                    "@latitude, @longtitude, @distance, @userType, @orderBy",
                    new SqlParameter("@latitude", criteria.Latitude),
                    new SqlParameter("@longtitude", criteria.Longitude),
                    new SqlParameter("@distance", criteria.Distance),
                    new SqlParameter("@userType", (int)UserTypeEnum.Restaurant),
                    new SqlParameter("@orderBy", criteria.OrderBy)
                    ).ToList();
            }
            return MenuItemSearchList;
        }

        public MenuItemSearchDTO GetMenuItemDetail(int MenuItemID, decimal latitude, decimal longitude)
        {
            MenuItemSearchDTO MenuItemSearch = new MenuItemSearchDTO();
            using (var context = new EateryDbContext())
            {
                MenuItemSearch = context.Database.SqlQuery<MenuItemSearchDTO>("dbo.spGetServiceDetail " +
                    "@latitude, @longtitude, @MenuItemID, @userType",
                    new SqlParameter("@latitude", latitude),
                    new SqlParameter("@longtitude", longitude),
                    new SqlParameter("@MenuItemID", MenuItemID),
                    new SqlParameter("@userType", (int)UserTypeEnum.Restaurant)
                    ).FirstOrDefault();
            }
            return MenuItemSearch;
        }

        #endregion

        #endregion

        #region Service Provider

        #region Get Near Restaurants

        public List<RestaurantSearchDTO> GetNearRestaurants(SearchCriteriaDTO criteria)
        {
            List<RestaurantSearchDTO> RestaurantSearchList = new List<RestaurantSearchDTO>();
            using (var context = new EateryDbContext())
            {

                RestaurantSearchList = context.Database.SqlQuery<RestaurantSearchDTO>("dbo.spGetNearRestaurants @latitude, @longtitude, @distance, @userType",
                    new SqlParameter("@latitude", criteria.Latitude),
                    new SqlParameter("@longtitude", criteria.Longitude),
                    new SqlParameter("@distance", criteria.Distance),
                    new SqlParameter("@userType", (int)UserTypeEnum.Restaurant)).ToList();
            }

            return RestaurantSearchList;
        }

        #endregion

        #region Get Service Providers By Any Criteria

        public List<RestaurantSearchDTO> GetRestaurantsByAnyCriteria(SearchCriteriaDTO criteria, string searchText)
        {
            List<RestaurantSearchDTO> RestaurantSearchList = new List<RestaurantSearchDTO>();

            List<Restaurant> Restaurants = new List<Restaurant>();
            List<User> users = new List<User>();
            List<MenuItem> MenuItems = new List<MenuItem>();

            SearchStringInTables(criteria, ref Restaurants, ref users, ref MenuItems);
            RestaurantSearchList = GetNearRestaurantsFreeText(criteria, Restaurants, users, MenuItems);

            return RestaurantSearchList;
        }

        #endregion
        public RestaurantProfileDTO GetRestaurantProfileInfo(int userID)
        {
            RestaurantProfileDTO RestaurantProfileDTO = default(RestaurantProfileDTO);

            using (var context = new EateryDbContext())
            {
                // 2. Retrieve the OAConnection instance.
                using (IDbConnection oaConnection = context.Database.Connection)
                {
                    // 3. Create a new instance of the OACommand class.
                    using (IDbCommand oaCommand = oaConnection.CreateCommand())
                    {
                        // 4. Set the CommandType property.
                        oaCommand.CommandType = CommandType.StoredProcedure;

                        // 5. Set the CommandText property.
                        oaCommand.CommandText = "spGetRestaurantProfileInfo";

                        SqlParameter paramUserID = new SqlParameter("@UserID", userID);
                        oaCommand.Parameters.Add(paramUserID);

                        oaConnection.Open();
                        // 6. Execute the command and materialize the car entities
                        using (IDataReader dataReader = oaCommand.ExecuteReader())
                        {
                            // Drop down to the wrapped `ObjectContext` to get access to
                            // the `Translate` method
                            var objectContext = ((IObjectContextAdapter)context).ObjectContext;
                            RestaurantProfileDTO = new RestaurantProfileDTO();
                            while (dataReader.Read())
                            {
                                if (dataReader.GetString(0) == "[dbo].[Users]")
                                {
                                    dataReader.NextResult();
                                    var user = objectContext.Translate<User>(dataReader as DbDataReader).FirstOrDefault();
                                    RestaurantProfileDTO.UserDTO = ObjectTypeConverter.Convert<User, UserDTO>(user);
                                    dataReader.NextResult();
                                }
                                else if (dataReader.GetString(0) == "[dbo].[Restaurants]")
                                {
                                    dataReader.NextResult();
                                    var Restaurant = objectContext.Translate<Restaurant>(dataReader as DbDataReader).FirstOrDefault();
                                    RestaurantProfileDTO.RestaurantDTO = ObjectTypeConverter.Convert<Restaurant, RestaurantDTO>(Restaurant);
                                    dataReader.NextResult();
                                }
                            }
                        }
                    }
                }
            }

            return RestaurantProfileDTO;
        }

        #endregion

        #region private methods

        private void SearchStringInTables(SearchCriteriaDTO criteria, ref List<Restaurant> Restaurants, ref List<User> users, ref List<MenuItem> MenuItems)
        {
            using (var context = new EateryDbContext())
            {
                // 2. Retrieve the OAConnection instance.
                using (IDbConnection oaConnection = context.Database.Connection)
                {
                    // 3. Create a new instance of the OACommand class.
                    using (IDbCommand oaCommand = oaConnection.CreateCommand())
                    {
                        // 4. Set the CommandType property.
                        oaCommand.CommandType = CommandType.StoredProcedure;

                        // 5. Set the CommandText property.
                        oaCommand.CommandText = "spSearchStringInTables";

                        SqlParameter tablenames = new SqlParameter("@Tablenames", "Restaurants,Services,Users");
                        SqlParameter searchStr = new SqlParameter("@SearchStr", criteria.Keyword);

                        oaCommand.Parameters.Add(tablenames);
                        oaCommand.Parameters.Add(searchStr);

                        oaConnection.Open();
                        // 6. Execute the command and materialize the car entities
                        using (IDataReader dataReader = oaCommand.ExecuteReader())
                        {
                            // Drop down to the wrapped `ObjectContext` to get access to
                            // the `Translate` method
                            var objectContext = ((IObjectContextAdapter)context).ObjectContext;
                            while (dataReader.Read())
                            {
                                if (dataReader.GetString(0) == "[dbo].[Restaurants]")
                                {
                                    dataReader.NextResult();
                                    Restaurants = objectContext.Translate<Restaurant>(dataReader as DbDataReader).ToList();
                                    dataReader.NextResult();
                                }
                                else if (dataReader.GetString(0) == "[dbo].[Users]")
                                {
                                    dataReader.NextResult();
                                    users = objectContext.Translate<User>(dataReader as DbDataReader).ToList();
                                    dataReader.NextResult();
                                }
                                else if (dataReader.GetString(0) == "[dbo].[Services]")
                                {
                                    dataReader.NextResult();
                                    MenuItems = objectContext.Translate<MenuItem>(dataReader as DbDataReader).ToList();
                                    dataReader.NextResult();
                                }
                            }
                        }
                    }
                }
            }
        }

        private List<RestaurantSearchDTO> GetNearRestaurantsFreeText(SearchCriteriaDTO criteria, List<Restaurant> Restaurants, List<User> users, List<MenuItem> MenuItems)
        {
            List<RestaurantSearchDTO> RestaurantSearchList = new List<RestaurantSearchDTO>();

            string RestaurantIDs = string.Join(",", Restaurants.Select(x => x.ID.ToString()).ToArray());
            SqlParameter paramRestaurantIDs = new SqlParameter("@RestaurantIDs", RestaurantIDs) { DbType = DbType.String };

            string userIDs = string.Join(",", users.Select(x => x.ID.ToString()).ToArray());
            SqlParameter paramUserIDs = new SqlParameter("@userIDs", userIDs) { DbType = DbType.String };

            string serviceIDs = string.Join(",", MenuItems.Select(x => x.ID.ToString()).ToArray());
            SqlParameter paramServiceIDs = new SqlParameter("@serviceIDs", serviceIDs) { DbType = DbType.String };

            using (var context = new EateryDbContext())
            {

                RestaurantSearchList = context.Database.SqlQuery<RestaurantSearchDTO>("dbo.spGetNearRestaurantsFreeText @latitude, @longtitude, @distance, @RestaurantIDs, @userIDs, @serviceIDs, @userType",
                    new SqlParameter("@latitude", criteria.Latitude),
                    new SqlParameter("@longtitude", criteria.Longitude),
                    new SqlParameter("@distance", criteria.Distance),
                    paramRestaurantIDs,
                    paramUserIDs,
                    paramServiceIDs,
                    new SqlParameter("@userType", (int)UserTypeEnum.Restaurant)).ToList();
            }

            return RestaurantSearchList;
        }

        private DataTable GetData(SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            String strConnString = ConfigurationManager.ConnectionStrings["EateryDbContext"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            try
            {
                con.Open();
                sda.SelectCommand = cmd;
                sda.Fill(dt);
                return dt;
            }
            catch
            {
                return null;
            }
            finally
            {
                con.Close();
                sda.Dispose();
                con.Dispose();
            }
        }

        #endregion private methods
    }
}
