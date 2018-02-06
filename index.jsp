<!DOCTYPE html>
<html>
	<head>
		<title>Documentation EBX</title>
		<link rel="stylesheet" href="assets/vakata-jstree-9770c67/dist/themes/default/style.min.css" />
		<script src="assets/jquery.min.js"></script>
		<script src="assets/vakata-jstree-9770c67/dist/jstree.min.js"></script>
	</head>
	<body>
		<%@page import="java.io.*" %> 
        <%@page import="java.util.*" %> 
        <%!        
			public void GetDirectory(String a_Path, String r_Path, String parent, Vector dataTree) {
				
				String path = a_Path +"/"+ r_Path;
                File l_Directory = new File(path);
                File[] l_files = l_Directory.listFiles();

                for (int c = 0; c < l_files.length; c++) {
                    if (l_files[c].isDirectory()) {
                        dataTree.add("{ " +
							"\"id\" : \""+ l_files[c].getName() + "\", " +
							"\"parent\" : \""+ parent +"\", " +
							"\"text\" : \""+l_files[c].getName()+"\" " +
							"} ");
						GetDirectory(a_Path, r_Path +"/"+ l_files[c].getName(), l_files[c].getName(), dataTree);
                    } else {
                        dataTree.add("{ " +
							"\"id\" : \""+ l_files[c].getName() + "\", " +
							"\"parent\" : \""+ parent +"\", " +
							"\"text\" : \""+l_files[c].getName()+"\", " +
							"\"icon\" : \"jstree-file\"," +
							"\"a_attr\": {\"href\": \""+r_Path+"/"+l_files[c].getName()+"\"}"+
							"} ");
                    }
                }
            }
			public static String strJoin(String sSep, Vector aArr) {
				StringBuilder sbStr = new StringBuilder();
				for (int i = 0, il = aArr.size(); i < il; i++) {
					if (i > 0)
						sbStr.append(sSep);
					sbStr.append(aArr.get(i));
				}
				return sbStr.toString();
			}
        %> 

        <%
            Vector dataTree = new Vector();
			dataTree.add("{ \"id\" : \"docMain\", \"parent\" : \"#\", \"text\" : \"Documentation\", \"state\": {\"opened\": \"true\"} }");
            GetDirectory("C:/ebx-solution/java/Tomcat-6.0/webapps/ROOT/doc", "./docm", "docMain", dataTree);
			
			String resources = strJoin(",", dataTree);
			out.println( "<div id=\"tree\" resources='{\"data\":["+ resources +"]}'></div>");
			
        %> 
		<br>
		<a href="./docm">Acces aux fichiers</a>
		<script type="text/javascript">
			$(document).ready(function(){
				console.log($("#tree").attr('resources'))
				var jsonData = { 'core' : JSON.parse($("#tree").attr('resources'))};
				
				console.log(jsonData);
				$('#tree').jstree(jsonData).bind("select_node.jstree", function (e, data) {
					var href = data.node.a_attr.href;
					console.log(href);
					window.open(href,'_blank');
					//document.location.href = href;
				});
			});
		</script>
	</body>
</html> 