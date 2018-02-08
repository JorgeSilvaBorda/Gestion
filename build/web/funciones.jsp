<%@page import="java.util.concurrent.ThreadLocalRandom"%>
<%!
    public String randomNumber() {
        int randomNum = ThreadLocalRandom.current().nextInt(100000, 999999 + 1);
        return Integer.toString(randomNum);
    }
%>
