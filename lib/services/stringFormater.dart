class StringFormater {
    static String removeSlash(String str) {
        String newStr = "";
        if(str[0] == "/") {
            for(int i = 0, l = str.length; i < l; i++) {
                newStr+=str[i];
            }
        } else {
            newStr = str;
        }
        return newStr;
    }
}