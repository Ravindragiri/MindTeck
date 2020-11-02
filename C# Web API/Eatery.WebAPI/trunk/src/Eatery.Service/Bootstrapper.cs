using System.Web.Http;
using Microsoft.Practices.Unity;
using Eatery.DAL.Repository.Interface;
using Eatery.DAL.Repository;
using Eatery.Business;
using Eatery.Business.Interface;

namespace Eatery.Service
{
    public static class Bootstrapper
    {
        public static void Initialise()
        {
            var container = BuildUnityContainer();

            GlobalConfiguration.Configuration.DependencyResolver = new Unity.WebApi.UnityDependencyResolver(container);
        }

        private static IUnityContainer BuildUnityContainer()
        {
            var container = new UnityContainer();

            // register all your components with the container here
            // e.g. container.RegisterType<ITestService, TestService>();            

            container.RegisterType<IUnitOfWork, UnitOfWork>(new ContainerControlledLifetimeManager());

            container.RegisterType<IRestaurantRepository, RestaurantRepository>(new ContainerControlledLifetimeManager());
            container.RegisterType<IRestaurantBL, RestaurantBL>(new ContainerControlledLifetimeManager());

            container.RegisterType<IUserRepository, UserRepository>(new ContainerControlledLifetimeManager());
            container.RegisterType<IUserBL, UserBL>(new ContainerControlledLifetimeManager());

            container.RegisterType<IMenuItemRepository, MenuItemRepository>(new ContainerControlledLifetimeManager());
            container.RegisterType<IMenuItemBL, MenuItemBL>(new ContainerControlledLifetimeManager());

            container.RegisterType<IMenuItemRatingRepository, MenuItemRatingRepository>(new ContainerControlledLifetimeManager());
            container.RegisterType<IMenuItemRatingBL, MenuItemRatingBL>(new ContainerControlledLifetimeManager());

            container.RegisterType<IRestaurantRatingRepository, RestaurantRatingRepository>(new ContainerControlledLifetimeManager());
            container.RegisterType<IRestaurantRatingBL, RestaurantRatingBL>(new ContainerControlledLifetimeManager());

            container.RegisterType<IRawSQLDbContext, RawSQLDbContext>(new ContainerControlledLifetimeManager());

            return container;
        }
    }
}