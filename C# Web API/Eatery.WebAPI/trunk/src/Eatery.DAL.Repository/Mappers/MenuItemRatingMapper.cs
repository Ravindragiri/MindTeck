using Eatery.DataContracts;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository.Mappers
{
    public class MenuItemRatingMapper : EntityTypeConfiguration<MenuItemRating>
    {
        public MenuItemRatingMapper()
        {
            ToTable("MenuItemRatings");

            this.HasKey(t => t.ID);

            this.Property(t => t.MenuItemID).HasColumnName("MenuItemID");
            this.Property(t => t.RatingValue).HasColumnName("RatingValue");

            this.Property(t => t.CreatedBy).HasColumnName("CreatedBy");
            this.Property(t => t.CreatedDate).HasColumnName("CreatedDate");
            this.Property(t => t.UpdatedBy).HasColumnName("UpdatedBy");
            this.Property(t => t.UpdatedDate).HasColumnName("UpdatedDate");
        }
    }
}
