	function lepusCheck(val, filter) {
		switch (filter) {
			default:
				i = /[^0-9a-zA-Z.-]/i.test(val);
		}
		return i;
	}
	
	var getUrlParameter = function getUrlParameter(sParam) {
		var sPageURL = decodeURIComponent(window.location.search.substring(1)),
			sURLVariables = sPageURL.split('&'),
			sParameterName,
			i;
	
		for (i = 0; i < sURLVariables.length; i++) {
			sParameterName = sURLVariables[i].split('=');

			if (sParameterName[0] === sParam) {
				return sParameterName[1] === undefined ? true : sParameterName[1];
			}
		}
	};
	
	$(document).keypress(function(e) {
			if(e.which == 13 && document.getElementById("check_auth") !== null) lepus_login();
	});

	$(document).on("click", "[data-do-login]", function(e) {
		$(this).blur();
		e.preventDefault();
		lepus_login();
	});
		
	var lepus_login = function() {
		login = $('input[id=login]').val();
		passwd = $('input[id=password]').val();
		$.post("//"+document.domain+":"+location.port+"/api/login", {login: login, passwd: passwd}, function(json){
			data = JSON.parse(json);
			if(data.Err == 'OK'){
				location.reload();
			}else{
				alertify.error(data.Mes);
			}
			return;
		});
	};

	$(document).on("click", "[data-do-logout]", function(e) {
		$(this).blur();
		e.preventDefault();
		$.get("//"+document.domain+":"+location.port+"/api/exit");
		location.reload();
	});

	$(document).ready(function(){
		var page = getUrlParameter('page');
		if(page){
			var menu = {};
			menu.hr = '<hr/>'
			menu.www = '<li><a href="/?page=cp">WWW домены</a></li>'
			menu.phpmyadmin = '<li><a href="http://'+document.domain+'/phpmyadmin" target="_blank">phpMyAdmin</a></li>'
			$("#menu").append(menu.hr+menu.phpmyadmin+menu.www+menu.hr);
			
			$.post("//"+document.domain+":"+location.port+"/api/get", {val: "login"}, function(json){
				data = JSON.parse(json);
				if(data.Err == 'OK'){
					$("a#user").html(data.Mes);
				}else{
					console.log(data.Mes)
				}
				return;
			});
		}
		if(page == "cp"){
			var table = $('#mainList').DataTable();
			$.post("//"+document.domain+":"+location.port+"/api/get", {val: "www"}, function(json){
				data = JSON.parse(json);
				//console.log(data.Mes)
				if(data.Err == 'OK'){
					j = JSON.parse(data.Mes);
					console.log(j);
					var i = 0;
					for (var key in j) {
						if(!j.hasOwnProperty(key)) continue;
						if(lepusCheck(key) || lepusCheck(j[key].ip) || lepusCheck(j[key].status)) {
							continue;
						}
						i++;
						table.row.add({
							DT_RowId: key,
							0:     i,
							1:     punycode.toUnicode(key),
							2:     j[key].ip,
							3:     j[key].status,
							4:     '<a href="/?page=wwwedit&www='+key+'" title="Редактировать"><i class="glyphicon glyphicon-pencil"></i></a> &nbsp; <a href="#" data-delete-site='+key+' title="Удалить"><i class="glyphicon glyphicon-remove"></i></a>'
						}).draw(false);
					}
				}
				return;
			});
		}
		if(page == "wwwedit"){
			if(lepusCheck(getUrlParameter('www'))){
				window.location = "/";
				return;
			}
			$("#title").append(punycode.toUnicode(getUrlParameter('www')));
			$.post("//"+document.domain+":"+location.port+"/api/get", {val: "perm", site: getUrlParameter('www')}, function(json){
				data = JSON.parse(json);
				console.log(json);
				if(data.Err == 'OK'){
					if(data.Mes == 'disable'){
						glyphicon = "glyphicon glyphicon-pause";
					}else{
						glyphicon ="glyphicon glyphicon-play";
					}
					tmpIcon = ' <a href="#" data-change-perm-site='+getUrlParameter('www')+' title="Вкл/ выкл"><i id="permStatus" class="'+glyphicon+'" style="vertical-align:middle;"></i></a>';
					$(".page-title").append(tmpIcon);
				}
			});
		
			var table = $('#mainList').DataTable();
			$.post("//"+document.domain+":"+location.port+"/api/get", {val: "www", symlink: getUrlParameter('www')}, function(json){
				data = JSON.parse(json);
				if(data.Err == 'OK'){
					j = JSON.parse(data.Mes);
					console.log(j);
					var i = 0;
					for (var key in j) {
						if(!j.hasOwnProperty(key)) continue;
						if(lepusCheck(key) || lepusCheck(j[key].ip) || lepusCheck(j[key].status)) {
							continue;
						}
						i++;
						table.row.add({
							DT_RowId: key,
							0:     i,
							1:     punycode.toUnicode(key),
							2:     '<a href="#" data-delete-site='+key+' title="Удалить"><i class="glyphicon glyphicon-remove"></i></a>',
						}).draw(false);
					}
				}
				return;
			});	
		
		}
	});

	$(document).on("click", "[data-do-addwww]", function(e) {
		$(this).blur();
		e.preventDefault();
		site = $('input[id=site]').val();
		var table = $('#mainList').DataTable();
		if(getUrlParameter("www")){
			site = getUrlParameter("www");
			var dir = $('input[id=site]').val();
		}
		if((punycode.toASCII(site).split(".").length - 1) > 1)
			symlink = "no";
		else
			symlink = "yes";
		$.post("//"+document.domain+":"+location.port+"/api/addwebdir", {val: punycode.toASCII(site), symlink: symlink, dir: dir}, function(json){
			data = JSON.parse(json);
			if(data.Err == 'OK'){
				if(lepusCheck(data.Mes)) {
					return;
				}
				if(!dir){
					table.row.add({
						DT_RowId: data,
						0:     table.page.info().recordsTotal+1,
						1:     site,
						2:     data.Mes,
						3:     "online",
						4:     '<a href="/?page=wwwedit&www='+punycode.toASCII(site)+'" title="Редактировать"><i class="glyphicon glyphicon-pencil"></i></a> &nbsp; <a href="/" data-delete-site='+punycode.toASCII(site)+' title="Удалить"><i class="glyphicon glyphicon-remove"></i></a>',
					}).draw( false );
				}else{
					table.row.add({
						DT_RowId: data,
						0:     table.page.info().recordsTotal+1,
						1:     dir,
						2:     '<a href="#" data-delete-site='+punycode.toASCII(site)+' title="Удалить"><i class="glyphicon glyphicon-remove"></i></a>',
					}).draw( false );
				}
				alertify.success("Done");
			}else{
				alertify.error(data.Mes);
			}
			return;
		});
	});

	$(document).on("click", "[data-delete-site]", function(e) {
		$(this).blur();
		e.preventDefault();
		var id = this.id;
		site = $(this).data("delete-site");
        var row = $(this).closest("tr").get(0);
        var table = $('#mainList').dataTable();
		if(!confirm("Вы подтверждаете удаление?")) return;
		$.post("//"+document.domain+":"+location.port+"/api/delwebdir", {val: site}, function(json){
		data = JSON.parse(json);
			if(data.Err == 'OK'){
				table.fnDeleteRow(table.fnGetPosition(row));
				alertify.success(data.Mes);
			}else{
				alertify.error(data.Mes);
			}
			return;
		});
	});
	
	$(document).on("click", "[data-change-perm-site]", function(e) {
		$(this).blur();
		e.preventDefault();
		site = $(this).data("change-perm-site");
		$.post("//"+document.domain+":"+location.port+"/api/chwebdir", {val: site}, function(json){
			data = JSON.parse(json);
			if(data.Err == 'OK'){
				if(data.Mes == 'online'){
					$("#permStatus").removeClass("glyphicon-pause");
					$("#permStatus").addClass("glyphicon-play");
				}else{
					$("#permStatus").removeClass("glyphicon-play");
					$("#permStatus").addClass("glyphicon-pause");
				}
				alertify.success(data.Mes);
			}else{
				alertify.error(data.Mes);
			}
			return;
		});
	});

