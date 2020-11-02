using Eatery.DataContracts;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository.Mappers
{
    public class RestaurantMapper : EntityTypeConfiguration<Restaurant>
    {
        public RestaurantMapper()
        {
            ToTable("Restaurants");

            // Primary Key
            this.HasKey(t => t.ID);

            this.Property(t => t.UserID).HasColumnName("UserID");
            
            this.Property(t => t.Address).HasColumnName("Address");
            this.Property(t => t.City).HasColumnName("City");
            this.Property(t => t.Province).HasColumnName("Province");
            this.Property(t => t.PinCode).HasColumnName("PinCode");

            this.Property(t => t.Latitude).HasColumnName("Latitude");
            this.Property(t => t.Longitude).HasColumnName("Longitude");

            this.Property(t => t.CreatedBy).HasColumnName("CreatedBy");
            this.Property(t => t.CreatedDate).HasColumnName("CreatedDate");
            this.Property(t => t.UpdatedBy).HasColumnName("UpdatedBy");
            this.Property(t => t.UpdatedDate).HasColumnName("UpdatedDate");
        }
    }
}
