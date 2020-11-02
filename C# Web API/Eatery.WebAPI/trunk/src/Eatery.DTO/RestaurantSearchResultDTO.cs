using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class RestaurantSearchDTO
    {
        #region User

        public int? UserID { get; set; }
        public string FirstName { get; set; }
        public string PhoneNumber { get; set; }
        public string CountryCode { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public string Email { get; set; }

        #endregion

        #region Restaurant

        public int? RestaurantID { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Province { get; set; }
        public string City { get; set; }
        public string Address { get; set; }
        public string PinCode { get; set; }
        public double DistanceInKilometers { get; set; }

        #endregion

        #region MenuItem

        public int? MenuItemID { get; set; }



        #endregion
    }

    public class RestaurantSearchResultDTO
    {
        public List<RestaurantSearchDTO> RestaurantSearchDTOList { get; set; }
        public ResponseMessageDTO ResponseMessageDTO { get; set; }
    }
}
