using Eatery.DataContracts;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Mappers
{
    public class MenuItemMapper : EntityTypeConfiguration<MenuItem>
    {
        public MenuItemMapper()
        {
            ToTable("MenuItems");
            // Primary Key
            this.HasKey(t => t.ID);
            
            this.Property(t => t.RestaurantID);

            this.Property(t => t.Title);
            this.Property(t => t.Description);
            this.Property(t => t.Price);
            this.Property(t => t.Rating);
            this.Property(t => t.IsPublished);

            this.Property(t => t.CreatedDate);
            this.Property(t => t.CreatedBy);
            this.Property(t => t.UpdatedDate);
            this.Property(t => t.UpdatedBy);
        }
    }
}
