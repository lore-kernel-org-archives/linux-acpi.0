From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 6/22] Use parse_method() for lcd
Date: Tue, 19 Dec 2006 22:19:16 +0100
Message-ID: <200612192219.16630.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50124 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933006AbWLSVZi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:38 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Here is a good example of what we can do with the new parse_method() 
function. It's not a problem if lcd_status or lcd_switch are NULL, because in 
this case,  there is no /proc/acpi/asus/lcd file.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   75 
++++++++++++++++++++----------------------------------------
 1 file changed, 26 insertions(+), 49 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 12:59:40.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 13:03:55.000000000 +0100
@@ -251,8 +251,8 @@
         .name = "L3H",
         .mled_set = "MLED",
         .wled_set = "WLED",
-        .lcd_switch = "EHK",
-        .lcd_status = "\\_SB.PCI0.PM.PBC",
+        .lcd_switch = "EHK(0x07)",
+        .lcd_status = "\\_SB.PCI0.PM.PBC(0x02,0x02)",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
         .display_set = "SDSP",
@@ -725,71 +725,48 @@

 static int get_lcd_state(void)
 {
+       static struct method mt = { .name = NULL };
        int lcd = 0;

-       if (hotk->model != L3H) {
-               /* We don't have to check anything if we are here */
-               if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd, 
NULL))
-                       printk(KERN_WARNING
-                              "Asus ACPI: Error reading LCD status\n");
+       if(mt.name != hotk->methods->lcd_status)
+               parse_method(hotk->methods->lcd_status, &mt);

-               if (hotk->model == L2D)
-                       lcd = ~lcd;
-       } else {                /* L3H and the like have to be handled 
differently */
-               acpi_status status = 0;
-               struct acpi_object_list input;
-               union acpi_object mt_params[2];
-               struct acpi_buffer output;
-               union acpi_object out_obj;
-
-               input.count = 2;
-               input.pointer = mt_params;
-               /* Note: the following values are partly guessed up, but
-                  otherwise they seem to work */
-               mt_params[0].type = ACPI_TYPE_INTEGER;
-               mt_params[0].integer.value = 0x02;
-               mt_params[1].type = ACPI_TYPE_INTEGER;
-               mt_params[1].integer.value = 0x02;
+       if (!read_acpi_int(NULL, mt.name, &lcd, &mt.input))
+               printk(KERN_WARNING
+                      "Asus ACPI: Error reading LCD status\n");

-               output.length = sizeof(out_obj);
-               output.pointer = &out_obj;
+       if (hotk->model == L2D)
+               lcd = ~lcd;
+       else if(hotk->model == L3H) /* That's what the AML code does */
+               lcd = lcd >> 8;

-               status =
-                   acpi_evaluate_object(NULL, hotk->methods->lcd_status,
-                                        &input, &output);
-               if (status != AE_OK)
-                       return -1;
-               if (out_obj.type == ACPI_TYPE_INTEGER)
-                       /* That's what the AML code does */
-                       lcd = out_obj.integer.value >> 8;
-       }

        return (lcd & 1);
 }

 static int set_lcd_state(int value)
 {
+       static struct method mt = { .name = NULL };
        int lcd = 0;
        acpi_status status = 0;

+       if(mt.name != hotk->methods->lcd_switch)
+               parse_method(hotk->methods->lcd_switch, &mt);
+
        lcd = value ? 1 : 0;
        if (lcd != get_lcd_state()) {
-               /* switch */
-               if (hotk->model != L3H) {
+               if(hotk->model == L3H) /* L3H is special .. */
                        status =
-                           acpi_evaluate_object(NULL,
-                                                hotk->methods->lcd_switch,
-                                                NULL, NULL);
-               } else {        /* L3H and the like have to be handled 
differently */
-                       if (!write_acpi_int
-                           (hotk->handle, hotk->methods->lcd_switch, 0x07,
-                            NULL))
-                               status = AE_ERROR;
-                       /* L3H's AML executes EHK (0x07) upon Fn+F7 keypress,
-                          the exact behaviour is simulated here */
-               }
+                               acpi_evaluate_object(hotk->handle,
+                                                    (char *)mt.name,
+                                                    &mt.input, NULL);
+               else
+                       status = acpi_evaluate_object(NULL, (char *)mt.name,
+                                                     &mt.input, NULL);
+
                if (ACPI_FAILURE(status))
-                       printk(KERN_WARNING "Asus ACPI: Error switching 
LCD\n");
+                       printk(KERN_WARNING
+                              "Asus ACPI: Error switching LCD\n");
        }
        return 0;



-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

