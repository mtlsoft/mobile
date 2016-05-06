import QtQuick 2.0
import "qrc:/mtl_mobile.js" as JsObject

Item {
    id: container

    property real p_header_container_height: 0.1
    property string p_menu_button_color: "red"

    property string p_header_font_family: "Helvetica"
    property real p_header_font_point_size: 18
    property string p_page_header_image_source: ""

    property string p_page_header_color: "transparent"

    property int p_menu_container_show_duration: 50
    property int p_menu_container_hide_duration: 50
    property real p_menu_container_max_opacity: 0.2

    property string p_menu_shadow_color: "black"

    property string p_menu_list_view_container_color: "white"

    property real menu_list_view_container_width_koef: 0.7

    property int p_menu_items_count: 7

    property string p_delegate_image_source: ""
    property string p_delegate_color: "blue"

    property string p_delegate_active_image_source: ""
    property string p_delegate_active_color: "ligthsteel"

    property string p_delegate_font_family: "Helvetica"
    property real p_delegate_point_size: 10
    property string p_delegate_font_color: "white"

    //

    property string json_init_data: ""

    function onModuleAction(module_local_id, action)
    {
        if(action == "open_page")
        {
            var tmp_module = JsObject.js_modules_container[module_local_id];

            if(tmp_module)
            {
            var json_data = tmp_module.actionData();

                if(json_data != "")
                {
                    var json_object = JSON.parse(json_data);

                    JsObject.js_page_stack.push(json_object.page_id);
                    JsObject.showPage(json_object.page_id);
                }
            }
        }
    }

    onJson_init_dataChanged:
    {
        JsObject.module_data = json_init_data;

        JsObject.load_modules();
    }

    Component.onCompleted: {
    }

    Rectangle{

        id: header_container

        width: container.width
        height: container.height * p_header_container_height

        Rectangle {
            id: menu_button

            height: parent.height
            width: height

            color: p_menu_button_color

            y: 0
            x: 0

            MouseArea {

                anchors.fill: parent

                onClicked: {

                    menu_container.visible = true;

                    menu_container.show();
                }
            }
        }

        Rectangle {
            id: page_header

            anchors.left: menu_button.right

            width: parent.width - menu_button.width
            height: parent.height

            color: p_page_header_color

            Image {
                id: page_header_image
                source: p_page_header_image_source

                width: parent.width
                height: parent.height
            }

            Text {
                id: header_text
                text: ""

                font.family: p_header_font_family
                font.pointSize: p_header_font_point_size

                anchors.centerIn: parent
            }
        }
    }

    Rectangle {
        id: page_container

        width: container.width
        height: container.height - page_header.height

        anchors.top: header_container.bottom
    }

    Rectangle {
        id: menu_container
        height: container.height
        width: parent.width

        color: "transparent"

        property int show_duration: p_menu_container_show_duration
        property int hide_duration: p_menu_container_hide_duration
        property real shadow_max_opacity: p_menu_container_max_opacity


        function show()
        {
            menu_shadow_show.start();
            menu_list_view_show.start();
        }

        function hide()
        {
            menu_shadow_hide.start();
            menu_list_view_hide.start();
        }


        Rectangle {
            id: menu_shadow

            opacity: 0

            width: container.width
            height: container.height

            visible: opacity != 0

            color: p_menu_shadow_color

            MouseArea {
                anchors.fill: parent

                onClicked:
                {
                    if(menu_shadow.opacity > 0)
                    {
                        menu_container.hide();
                    }
                }
            }
        }

        ListModel {
            id: menu_list_model
        }

        Rectangle {
            id: menu_list_view_container

            color: p_menu_list_view_container_color

            height: parent.height
            width: parent.width * menu_list_view_container_width_koef
            x: -width

            Component {
                id: list_view_delegate

                Item {
                    height: menu_list_view.height / p_menu_items_count
                    width: menu_list_view.width

                    property int page_delegate_id: page_id

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height

                        color: (menu_list_view.currentItem == list_view_delegate)?p_delegate_active_color:p_delegate_color

                        Image {
                            id: delegate_image

                            source: (menu_list_view.currentItem == list_view_delegate)?p_delegate_active_image_source:p_delegate_image_source

                            width: parent.width
                            height: parent.height

                            anchors.left: parent.left
                        }

                        Image {
                            id: delegate_icon
                            source: page_icon_source

                            height: parent.height
                            width: height

                            anchors.left: parent.left
                        }

                        Rectangle {
                            color: "transparent"

                            width: parent.width - delegate_icon.width
                            height: parent.height

                            anchors.left: delegate_icon.right

                            Text {
                                id: delegate_text
                                text: page_title

                                font.family: p_delegate_font_family
                                font.pointSize: p_delegate_point_size

                                color: p_delegate_font_color

                                anchors.centerIn: parent
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            JsObject.showPage(parent.page_delegate_id);

                            menu_container.hide();
                        }
                    }
                }
            }

            ListView {
                id: menu_list_view
                height: parent.height

                model: menu_list_model

                delegate: list_view_delegate

                anchors.fill: parent
            }
        }

        NumberAnimation {
            id: menu_shadow_show

            target: menu_shadow
            property: "opacity"
            duration: menu_container.show_duration
            easing.type: Easing.Linear
            from: 0
            to: menu_container.shadow_max_opacity
        }

        NumberAnimation {
            id: menu_shadow_hide

            target: menu_shadow
            property: "opacity"
            duration: menu_container.hide_duration
            easing.type: Easing.Linear
            from: menu_container.shadow_max_opacity
            to: 0
        }


        NumberAnimation {
            id: menu_list_view_show

            target: menu_list_view_container
            property: "x"
            duration: menu_container.show_duration
            easing.type: Easing.Linear
            from: -menu_list_view_container.width
            to: 0
        }

        NumberAnimation {
            id: menu_list_view_hide

            target: menu_list_view_container
            property: "x"
            duration: menu_container.hide_duration
            easing.type: Easing.Linear
            from: 0
            to: -menu_list_view_container.width
        }
    }

}

