using Eatery.DAL.Repository.Interface;
using Eatery.DataContracts;
using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository
{
    public class UserRepository : GenericRepository<User>, IUserRepository
    {
        
    }
}
