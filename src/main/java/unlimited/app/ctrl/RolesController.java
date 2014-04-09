package unlimited.app.ctrl;

import com.jfinal.core.Controller;
import org.apache.shiro.authz.annotation.RequiresRoles;

/**
 * Created by unlimited on 2014/4/9.
 */

@RequiresRoles("admin")
public class RolesController extends Controller {

    public void index() {
        render("index.html");
    }

    public void login() {}

    public void logout() {}

    public void err404() {
        render("err404.html");
    }

    public void err500() {
        render("err500.html");
    }
}
