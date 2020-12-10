using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(guvenemlak.Startup))]
namespace guvenemlak
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
