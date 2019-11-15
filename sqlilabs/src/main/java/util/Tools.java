package util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;
/**
 * Create by 杨浩宇
 * Time: 2019/11/14
 */
public class Tools {

    //判断是否为数字
    public static boolean isInteger(String str) {
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");
        return pattern.matcher(str).matches();
    }

    //less17
    public static String check_input(String value, int len) {
        if((value != null || value.equals("")) && value.length() > 15) {
            value = value.substring(0,len);
        }
        if(!isInteger(value)) {
            value = "'" + StringEscapeUtils.escapeSql(value) + "'";
        } else { //提取整数
            String regEx="[^0-9]";
            Pattern p = Pattern.compile(regEx);
            Matcher m = p.matcher(value);
            value =m.replaceAll("").trim();
        }
        return value;
    }

//    public static String annotation(String )

    public static void main(String[] args) {
        Tools tools = new Tools();
        System.out.println(tools.check_input("-012qew3456",15));
    }

}
