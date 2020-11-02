using Eatery.DAL.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository.Interface
{
    /// <summary>
    /// Base interface to implement UnitOfWork Pattern.
    /// </summary>
    public interface IUnitOfWork
    {
        IEateryDbContext GetEateryDbContext();
        void Commit(IEateryDbContext context);
        //void Rollback(IEateryDbContext context);
    }
}
