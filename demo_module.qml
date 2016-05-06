import QtQuick 2.0

Item {
    id: demo_module

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

//    <param type="file" name="bg_image" />
//    <param type="string" name="title_text" />

    property string bg_image: ""
    property string title_text: ""
    property string title_text_color: "white"



    onModule_json_dataChanged: {
        var json_object = JSON.parse(module_json_data);

        bg_image = json_object.bg_image;
        title_text = json_object.title_text;
    }

    Image {
        id: demo_module_image
        source: demo_module.bg_image

        width: parent.width
        height: parent.height


        Text {
            id: demo_module_title_text
            text: demo_module.title_text

            anchors.centerIn: parent

            color: demo_module.title_text_color
        }
    }
}

