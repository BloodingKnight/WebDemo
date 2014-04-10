package unlimited.app.cfg;

import com.alibaba.druid.filter.stat.StatFilter;
import com.jfinal.config.*;
import com.jfinal.ext.plugin.shiro.ShiroInterceptor;
import com.jfinal.ext.plugin.shiro.ShiroPlugin;
import com.jfinal.ext.plugin.tablebind.AutoTableBindPlugin;
import com.jfinal.ext.plugin.tablebind.SimpleNameStyles;
import com.jfinal.ext.route.AutoBindRoutes;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.IErrorRenderFactory;
import com.jfinal.render.RedirectRender;
import com.jfinal.render.Render;
import com.jfinal.render.ViewType;

/**
 * Created by unlimited on 2014/4/9.
 */
public class MainConfig extends JFinalConfig {

    /**
     * for shiro
     */
    Routes routes;

    @Override
    public void configConstant(Constants me) {
        loadPropertyFile("a_little_config.txt");
        me.setViewType(ViewType.JSP);
        me.setBaseViewPath("/WEB-INF/pages/");
//        me.setErrorView(401, "/WEB-INF/pages/login.html");
//        me.setErrorView(403, "/WEB-INF/pages/login.html");
        me.setError401View("/err401");
        me.setError403View("/err403");
        me.setError404View("/err404");
        me.setError500View("/err500");
        me.setErrorRenderFactory(new IErrorRenderFactory() {
            @Override
            public Render getRender(int errorCode, String view) {
                return new RedirectRender(view);
            }
        });
    }

    @Override
    public void configRoute(Routes me) {
        this.routes = me;
        me.add(new AutoBindRoutes());
    }

    @Override
    public void configPlugin(Plugins me) {
        me.add(new ShiroPlugin(routes));
        me.add(new EhCachePlugin());
        // 配置数据库连接池插件
        DruidPlugin druidPlugin = new DruidPlugin(getProperty("jdbc.url"),
                getProperty("jdbc.username"),
                getProperty("jdbc.password"),
                getProperty("jdbc.driver"));

        druidPlugin.addFilter(new StatFilter());
        me.add(druidPlugin);

        //添加自动绑定model与表插件
        AutoTableBindPlugin autoTableBindPlugin = new AutoTableBindPlugin(druidPlugin, SimpleNameStyles.LOWER_UNDERLINE);
        autoTableBindPlugin.setShowSql(true);
        autoTableBindPlugin.setContainerFactory(new CaseInsensitiveContainerFactory());
//        autoTableBindPlugin.setAutoScan(false);
        me.add(autoTableBindPlugin);
//        me.add(new SqlInXmlPlugin());
    }

    @Override
    public void configInterceptor(Interceptors me) {
        me.add(new ShiroInterceptor());
    }

    @Override
    public void configHandler(Handlers handlers) {

    }
}
