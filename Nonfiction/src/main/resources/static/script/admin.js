function go_search( requestName ){

	document.frm.action = requestName + "?page=1";
	document.frm.submit();
}

function go_view(qseq){
	location.href="adminQnaView?qseq="+qseq;
}

function go_rep(){
	if(document.frm.reply.value==""){
		alert("내용을 입력하세요");
		return;
	}
	document.frm.action="adminQnaRepSave";
	document.frm.submit();
}

function searchPosts(page) {
    var keyword = document.getElementsByName("key")[0].value;
    location.href = page + "?key=" + keyword; 
}


function go_qnaList() {
    document.getElementsByName("key")[0].value = "";
    searchPosts('adminQnaList'); 
}


function go_memberList() {
    document.getElementsByName("key")[0].value = "";
    searchPosts('memberList'); 
}



function reInsert(userid,useyn){
	location.href="memberReinsert?userid="+userid+"&useyn"+useyn;
}











