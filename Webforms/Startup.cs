using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Webforms.Startup))]
namespace Webforms
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
