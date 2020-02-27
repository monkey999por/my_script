"use strict";
let this_command_name;
let active_detail;
let all_command_details;

//最初にコマンドの詳細を非表示にする
window.onload = function(){
    all_command_details = document.querySelectorAll('.detail');
    all_command_details.forEach(item => item.parentElement.removeChild(item));
}

// clickしたコマンドの詳細表示制御
document.addEventListener('click',function(e){
    if (e.target.id.charAt(0) === "_") {
        this_command_name = e.target.id;
    
        //active_detailの詳細非表示(物理削除)
        if (active_detail !== undefined && active_detail !==null) {
            let active_detail_element = document.getElementById(active_detail);
            if (active_detail_element != null) {
                active_detail_element.parentNode.removeChild(active_detail_element);
            }
        }

        //this_command_nameの詳細表示
        all_command_details.forEach(function(item){
            if (item.id === this_command_name.substr(1)) {
                e.target.parentElement.appendChild(item);
                active_detail = item.id;
            }
        });
    }
},false);





