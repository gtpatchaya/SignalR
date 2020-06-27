using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace SignalR2
{
    public class MyHub1 : Hub
    {
        //เพิ่ม Method ในไฟล์ Hub Class เพื่อใช้สำหรับการ รับ-ส่ง ข้อความระหว่าง Client กับ Server
        //จาก Method นี้จะเห็นว่าเป็นเพียงคำสั่งง่าย ๆ ที่รับข้อความ name และ message จากนั้นส่งมันไปยังทุก ๆ Client
        public void MyChatSend(string name, string to, string message)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.broadcastMessage(name, to, message);
        }
    }
}