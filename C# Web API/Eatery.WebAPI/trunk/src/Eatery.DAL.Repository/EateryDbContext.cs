using Eatery.DAL.Interface;
using Eatery.DAL.Mappers;
using Eatery.DAL.Repository.Interface;
using Eatery.DAL.Repository.Mappers;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository
{
    public class EateryDbContext : DbContext, IEateryDbContext, IDbContext
    {
        static EateryDbContext()
        {
            Database.SetInitializer<EateryDbContext>(null);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            //modelBuilder.Conventions.Remove<IncludeMetadataConvention>();

            modelBuilder.Configurations.Add(new RestaurantMapper());
            modelBuilder.Configurations.Add(new UserMapper());
            modelBuilder.Configurations.Add(new MenuItemMapper());
            modelBuilder.Configurations.Add(new MenuItemRatingMapper());
        }

        public new DbSet<TEntity> Set<TEntity>() where TEntity : class
        {
            return base.Set<TEntity>();
        }

        public new DbEntityEntry Entry(object entity)
        {
            return base.Entry(entity);
        }
        public Database GetDataBase()
        {
            return base.Database;
        }

        public virtual void Commit()
        {
            //try
            //{
                base.SaveChanges();
            //}
            //catch (Exception)
            //{
            //    this.Rollback();
            //    throw;
            //}
        }

        //public virtual void Rollback()
        //{
        //    foreach (var entry in base.ChangeTracker.Entries())
        //    {
        //        switch (entry.State)
        //        {
        //            case EntityState.Modified:
        //                entry.State = EntityState.Unchanged;
        //                break;
        //            case EntityState.Added:
        //                entry.State = EntityState.Detached;
        //                break;
        //            case EntityState.Deleted:
        //                entry.State = EntityState.Unchanged;
        //                break;
        //        }
        //    }
        //}

        #region

        // Track whether Dispose has been called. 
        private bool disposed = false;


        // Use C# destructor syntax for finalization code. 
        // This destructor will run only if the Dispose method does not get called. 
        // It gives your base class the opportunity to finalize. Do not provide destructors in types derived from this class.
        ~EateryDbContext()
        {
            // Do not re-create Dispose clean-up code here. Calling Dispose(false) is optimal in terms of readability and maintainability.
            Dispose(false);
        }

        // A derived class should not be able to override this method. 
        public new void Dispose()
        {
            Dispose(true);
            // This object will be cleaned up by the Dispose method.  Therefore, you should call GC.SupressFinalize to take this object off the 
            // finalization queue and prevent finalization code for this object from executing a second time.
            GC.SuppressFinalize(this);
        }

        // Dispose(bool disposing) executes in two distinct scenarios. 
        // If disposing equals true, the method has been called directly or indirectly by a user's code. Managed and unmanaged resources can be disposed. 
        // If disposing equals false, the method has been called by the runtime from inside the finalizer and you should not reference other objects. 
        // Only unmanaged resources can be disposed. 
        protected new void Dispose(bool disposing)
        {
            // Check to see if Dispose has already been called. 
            if (!this.disposed)
            {
                // If disposing equals true, dispose all managed and unmanaged resources. 
                if (disposing)
                {
                    // Dispose managed resources.
                    base.Dispose();
                }

                // Note disposing has been done.
                this.disposed = true;
            }
        }
        #endregion
    }
}
