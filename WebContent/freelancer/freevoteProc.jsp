<%@page import="freelancer.FreelancerMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
String uid = request.getParameter("uid");
String fid = request.getParameter("fid");
FreelancerMgr mgr = new FreelancerMgr();

if (mgr.free_usercheck(uid, fid)) {
	String votecnt = mgr.getfree_user(uid, fid).getVote();
	mgr.updatefree_user(uid, fid, votecnt);
} else {
	mgr.insertfree_user(uid, fid);
}
session.setAttribute("idKey", uid);
%>
<script>
	location.href = "board_include_F.jsp";
</script>