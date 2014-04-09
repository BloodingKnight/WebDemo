package unlimited.app.model;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

/**
 * Created by unlimited on 2014/4/9.
 */

@TableBind(tableName = "roles", pkName = "id")
public class Role extends Model<Role> {
    public static Role dao = new Role();
}
