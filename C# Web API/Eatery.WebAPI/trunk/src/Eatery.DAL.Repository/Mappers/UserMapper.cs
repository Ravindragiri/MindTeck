using Eatery.DataContracts;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository.Mappers
{
    public class UserMapper : EntityTypeConfiguration<User>
    {
        public UserMapper()
        {
            ToTable("Users");

            this.HasKey(t => t.ID);

            #region Registration like Whatsapp

            //Username: Phone number with country code but without '+' or '00', ie: 34123456789
            this.Property(t => t.PhoneNumber).HasColumnName("PhoneNumber");
            
            this.Property(t => t.CountryCode).HasColumnName("CountryCode");
            //this.Property(t => t.Latitude).HasColumnName("Latitude");
            //this.Property(t => t.Longitude).HasColumnName("Longitude");
            
            this.Property(t => t.Email).HasColumnName("Email");
            this.Property(t => t.Password).HasColumnName("Password");
            this.Property(t => t.FirstName).HasColumnName("FirstName");

            this.Property(t => t.Username).HasColumnName("Username");
            this.Property(t => t.UserType).HasColumnName("UserType");


            this.Property(t => t.PasswordHash).HasColumnName("PasswordHash");
            this.Property(t => t.PasswordSalt).HasColumnName("PasswordSalt");

            this.Property(t => t.CreatedBy).HasColumnName("CreatedBy");
            this.Property(t => t.CreatedDate).HasColumnName("CreatedDate");
            this.Property(t => t.UpdatedBy).HasColumnName("UpdatedBy");
            this.Property(t => t.UpdatedDate).HasColumnName("UpdatedDate");

            #endregion
        }
    }
}
