From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 8/22] Add Light Sens support.
Date: Tue, 19 Dec 2006 22:19:29 +0100
Message-ID: <200612192219.29352.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50222 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933031AbWLSV0P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:26:15 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Add basic support for the light sensor found in some models, like M7A/M7V.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   90 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 13:14:25.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 13:11:00.000000000 +0100
@@ -29,6 +29,7 @@
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
  *  Eric Burghard  - LED display support for W1N
  *  Brice Arnould  - Some help for parse_method()
+ *  Josh Green     - Light Sens support
  *
  */

@@ -53,6 +54,8 @@
 #define PROC_LCD        "lcd"
 #define PROC_BRN        "brn"
 #define PROC_DISP       "disp"
+#define PROC_LSSW       "lssw"
+#define PROC_LSLVL      "lslvl"

 #define ACPI_HOTK_NAME          "Asus Laptop ACPI Extras Driver"
 #define ACPI_HOTK_CLASS         "hotkey"
@@ -103,6 +106,8 @@
        char *brightness_set;   //method to set absolute brightness_R
        char *brightness_get;   //method to get absolute brightness_R
        char *brightness_status;        //node to get brightness____________A
+       char *light_sens_switch; //light sensor toggle method________R
+       char *light_sens_level; //light sensor level set method_____R
        char *display_set;      //method to set video output________R
        char *display_get;      //method to get video output________R
 };
@@ -125,6 +130,8 @@
        u32 ledd_status;        //status of the LED display
        struct model_data *methods;     //methods available on the laptop
        u8 brightness;          //brightness level
+       u8 light_level;    //light sensor level
+       u8 light_switch;    //light sensor switch value
        enum {
                A1x = 0,        //A1340D, A1300F
                A2x,            //A2500H
@@ -907,6 +914,65 @@
        return rv;
 }

+static void set_light_sens_switch(int value)
+{
+       if (!write_acpi_int(hotk->handle, hotk->methods->light_sens_switch,
+                           value, NULL))
+               printk(KERN_WARNING "Asus ACPI: Error setting light sensor "
+                      " switch\n");
+       hotk->light_switch = value;
+}
+
+static int proc_read_lssw(char *page, char **start, off_t off, int count,
+                         int *eof, void *data)
+{
+       return sprintf(page, "%d\n", hotk->light_switch);
+}
+
+static int proc_write_lssw(struct file *file, const char __user *buffer,
+                          unsigned long count, void *data)
+{
+       int rv, value;
+
+       rv = parse_arg(buffer, count, &value);
+       if (rv > 0)
+               set_light_sens_switch(value ? 1 : 0);
+
+       return rv;
+}
+
+static void set_light_sens_level(int value)
+{
+       if (!write_acpi_int(hotk->handle, hotk->methods->light_sens_level,
+                           value, NULL))
+               printk(KERN_WARNING "Asus ACPI: Error setting light sensor"
+                      " level\n");
+       hotk->light_level = value;
+}
+
+static int
+proc_read_lslvl(char *page, char **start, off_t off, int count, int *eof,
+               void *data)
+{
+       return sprintf(page, "%d\n", hotk->light_level);
+}
+
+static int
+proc_write_lslvl(struct file *file, const char __user *buffer,
+                unsigned long count, void *data)
+{
+       int rv, value;
+
+       rv = parse_arg(buffer, count, &value);
+       if (rv > 0) {
+               value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
+               /* 0 <= value <= 15 */
+               set_light_sens_level(value);
+       }
+
+       return rv;
+}
+
 typedef int (proc_readfunc) (char *page, char **start, off_t off, int count,
                             int *eof, void *data);
 typedef int (proc_writefunc) (struct file * file, const char __user * buffer,
@@ -1000,6 +1066,16 @@
                              mode, device);
        }

+       if (hotk->methods->light_sens_switch) {
+               asus_proc_add(PROC_LSSW, &proc_write_lssw, &proc_read_lssw,
+                             mode, device);
+       }
+
+       if (hotk->methods->light_sens_level) {
+               asus_proc_add(PROC_LSLVL, &proc_write_lslvl, &proc_read_lslvl,
+                             mode, device);
+       }
+
        return 0;
 }

@@ -1026,6 +1102,10 @@
                        remove_proc_entry(PROC_BRN, acpi_device_dir(device));
                if (hotk->methods->display_set)
                        remove_proc_entry(PROC_DISP, acpi_device_dir(device));
+               if (hotk->methods->light_sens_switch)
+                       remove_proc_entry(PROC_LSSW, acpi_device_dir(device));
+               if (hotk->methods->light_sens_level)
+                       remove_proc_entry(PROC_LSLVL, 
acpi_device_dir(device));
        }
        return 0;
 }
@@ -1305,6 +1385,16 @@
        /* LED display is off by default */
        hotk->ledd_status = 0xFFF;

+       /* Set initial values of light sensor and level */
+       hotk->light_switch = 1;/* Default to light sensor disabled */
+       hotk->light_level = 0;/* level 5 for sensor sensitivity */
+
+       if (hotk->methods->light_sens_switch)
+               set_light_sens_switch(hotk->light_switch);
+
+       if (hotk->methods->light_sens_level)
+               set_light_sens_level(hotk->light_level);
+
       end:
        if (result) {
                kfree(hotk);

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

