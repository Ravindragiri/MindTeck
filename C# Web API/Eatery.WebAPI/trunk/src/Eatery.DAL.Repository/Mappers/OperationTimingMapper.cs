using Eatery.DataContracts;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Mappers
{
    public class OperationTimingMapper : EntityTypeConfiguration<OperationTiming>
    {
        public OperationTimingMapper()
        {
            ToTable("RestaurantOperationTimings");
            // Primary Key
            this.HasKey(t => t.ID);
            this.Property(t => t.RestaurantID).HasColumnName("RestaurantID");

            this.Property(t => t.DayOfWeek);
            this.Property(t => t.TimeOpen);
            this.Property(t => t.Timeclosed);

            this.Property(t => t.CreatedDate);
            this.Property(t => t.CreatedBy);
            this.Property(t => t.UpdatedDate);
            this.Property(t => t.UpdatedBy);
        }
    }
}
