import QtQuick 2.0

Item {
    id: test_module

    width: parent.width
    height: parent.height

    property int module_local_id: -1
    property string action_data: "";

    property string module_json_data: ""

    signal moduleAction(int module_local_id_, string type)

    function actionData()
    {
        var ret_data = action_data;
        action_data = "";
        return ret_data;
    }

    property string bg_color: "yellow"
    property string title_text: "Enjoy!"
    property string page_global_id: ""

    onModule_json_dataChanged: {
        var json_object = JSON.parse(module_json_data);

        if(json_object.bg_color)
            bg_color = json_object.bg_color;

        if(json_object.title_text)
            title_text = json_object.title_text;

        if(json_object.page_global_id)
            page_global_id = json_object.page_global_id;
    }

    Rectangle {

        anchors.fill: parent

        color: bg_color

        Text {
            id: top_text

            text: "This is a test module!"

            anchors.centerIn: parent
        }

        Text {
            text: title_text

            anchors.top: top_text.bottom

            MouseArea {
                anchors.fill: parent

                onClicked: {

                    var page_data = {};
                    page_data["page_id"] = test_module.page_global_id;

                    test_module.action_data = JSON.stringify(page_data);

                    moduleAction(module_local_id, "open_page");
                }
            }
        }
    }
}

