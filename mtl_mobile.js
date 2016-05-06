//var module_data = '{"meta" : {}, "pages" : \
//                    [ \
//                    {   "id": 1, \
//                        "title":"Главная", \
//                        "icon":"", \
//                        "module":"test_module", \
//                        "module_local_data" : {} \
//                    }, \
//                    {   "id": 2, \
//                        "title":"Продукты", \
//                        "icon":"", \
//                        "module":"test_module", \
//                        "module_local_data" : \
//                            { \
//                            "bg_color" : "blue", \
//                            "title_text" : "lol!", \
//                            "page_global_id" : 1 \
//                            } \
//                    } \
//                    ]}';

//'{ "meta" : {  }, "pages" : [ { "icon" : "", "id" : 0, "module" : "demo_module", "module_local_data" : { "bg_image" : "/home/user/projects/img/porshe.jpg", "title_text" : "\u042d\u0442\u043e \u043f\u043e\u0440\u0448\u0435, \u0434\u0435\u0442\u043a\u0430" }, "title" : "\u041f\u043e\u0440\u0448\u0435" }, { "icon" : "", "id" : 0, "module" : "demo_module", "module_local_data" : { "bg_image" : "/home/user/projects/img/ferrari.jpg", "title_text" : "\u0424\u0435\u0440\u0440\u0430\u0440\u0438, \u0434\u0435\u0442\u043a\u0430" }, "title" : "\u0424\u0435\u0440\u0440\u0430\u0440\u0438" } ] }';
//var module_data = '{ "meta" : {  }, "pages" : [ { "icon" : "", "id" : 1, "module" : "demo_module", "module_local_data" : { "bg_image" : "file://home/user/projects/img/porshe.jpg", "title_text" : "\u042d\u0442\u043e \u043f\u043e\u0440\u0448\u0435, \u0434\u0435\u0442\u043a\u0430" }, "title" : "\u041f\u043e\u0440\u0448\u0435" }, { "icon" : "", "id" : 0, "module" : "demo_module", "module_local_data" : { "bg_image" : "file://home/user/projects/img/ferrari.jpg", "title_text" : "\u0424\u0435\u0440\u0440\u0430\u0440\u0438, \u0434\u0435\u0442\u043a\u0430" }, "title" : "\u0424\u0435\u0440\u0440\u0430\u0440\u0438" } ] }';

var module_data; //  = '{ "meta" : {  }, "pages" : [ { "icon" : "file:///home/user/projects/img/porsche_logo.png", "id" : 0, "module" : "demo_module", "module_local_data" : { "bg_image" : "file:///home/user/projects/img/porshe.jpg", "title_text" : "Porcshe, baby!" }, "title" : "Page 0" } ] }'

var js_modules_container = {};
var js_modules_counter = 0;

var js_pages_container = {};
var js_pages_counter = 0;

var js_current_page;

var js_page_stack = [];
var js_page_stack_counter = 0;

function load_modules() {
var json_object = JSON.parse(module_data);

    for(var i = 0; i < json_object.pages.length; i++)
    {
        var page_component = Qt.createComponent("qrc:/mtl_page.qml");
        if (page_component.status == Component.Ready) {
            var page_object = page_component.createObject(page_container);
            page_object.visible = false;

            page_object.title = json_object.pages[i].title;
            page_object.icon = json_object.pages[i].icon;

            var module_component =
                    Qt.createComponent("qrc:/modules/" +
                                       json_object.pages[i].module +
                                       ".qml");

            if (module_component.status == Component.Ready) {
                var module_object = module_component.createObject(page_object);


                module_object.module_local_id = js_modules_counter;

                module_object.module_json_data =
                        JSON.stringify(json_object.pages[i].module_local_data);

                module_object.moduleAction.connect(container.onModuleAction);

                var delegate_data = {};

                delegate_data["page_title"] = page_object.title
                delegate_data["page_icon_source"] = page_object.icon
                delegate_data["page_id"] = json_object.pages[i].id

                menu_list_model.append(delegate_data);

                js_pages_container[json_object.pages[i].id] = page_object;

                js_modules_container[JsObject.js_modules_counter] = module_object;
                js_modules_counter++;
            }
        }
    }
}

function showPage(page_id)
{
    if(js_current_page)
        js_current_page.visible = false;

    var page_object = js_pages_container[page_id];

    if(page_object)
    {
        header_text.text = page_object.title;

        js_current_page = page_object;
        page_object.visible = true;
    }
}

