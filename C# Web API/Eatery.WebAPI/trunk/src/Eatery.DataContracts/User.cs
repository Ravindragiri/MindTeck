using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DataContracts
{
    public class User
    {
        public int ID { get; set; }
        public string PhoneNumber { get; set; }
        public string CountryCode { get; set; }
        public string Country { get; set; }
        //public decimal Latitude { get; set; }
        //public decimal Longitude { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string PasswordHash { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string PasswordSalt { get; set; }
        public int UserType { get; set; }

        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedDate { get; set; }
    }
}
