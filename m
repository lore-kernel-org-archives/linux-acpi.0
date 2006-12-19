From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 5/22] Add support for more flexible methods definitions
Date: Tue, 19 Dec 2006 22:19:10 +0100
Message-ID: <200612192219.10425.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50213 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933015AbWLSV0K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:26:10 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

This Patch adds a clean way to handle methods with parameters (like for the 
L3H). See Patch 6 for an example.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
asus_acpi.c |   63 
+++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 11 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 12:50:55.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 12:57:54.000000000 +0100
@@ -28,6 +28,7 @@
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
  *  Eric Burghard  - LED display support for W1N
+ *  Brice Arnould  - Some help for parse_method()
  *
  */

@@ -72,12 +73,18 @@
 #define TLED_ON     0x04       //touchpad LED
 #define BT_ON       0x08       //internal Bluetooth

+/*
+ * Methods configuration
+ */
+#define MT_MAX_ARGS 3
+
 MODULE_AUTHOR("Julien Lerouge, Karol Kozimor, Corentin Chary");
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
 MODULE_LICENSE("GPL");

 /* For each model, all features implemented,
- * those marked with R are relative to HOTK, A for absolute */
+ * those marked with R are relative to HOTK, A for absolute
+ */
 struct model_data {
        char *name;             //name of the laptop________________A
        char *mled_set;         //method to handle mled_____________R
@@ -100,6 +107,13 @@
        char *display_get;      //method to get video output________R
 };

+/* A method have a name, and from 0 to MT_MAX_ARGS params ... */
+struct method {
+       const char * name;
+       struct acpi_object_list input;
+       union acpi_object params[MT_MAX_ARGS];
+};
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -422,6 +436,32 @@
 };

 /*
+ * Take a string describing a method,
+ * parse it, and store the result into mt
+ */
+static void parse_method(char *orig, struct method *mt)
+{
+       char *args = orig;
+       uint argc = 0;
+
+       mt->name = strsep(&args, "(");
+       mt->input.count = 0;
+       mt->input.pointer = mt->params;
+
+       while(args && *args && argc < MT_MAX_ARGS) {
+               char *tmp;
+               tmp = strsep(&args, ",");
+
+               mt->params[argc].type = ACPI_TYPE_INTEGER;
+               mt->params[argc].integer.value = simple_strtoul(tmp, NULL, 0);
+
+               argc++;
+       }
+
+       mt->input.count = argc;
+}
+
+/*
  * This function evaluates an ACPI method, given an int as parameter, the
  * method is searched within the scope of the handle, can be NULL. The output
  * of the method is written is output, which can also be NULL
@@ -444,7 +484,8 @@
        return (status == AE_OK);
 }

-static int read_acpi_int(acpi_handle handle, const char *method, int *val)
+static int read_acpi_int(acpi_handle handle, const char *method, int *val,
+                        struct acpi_object_list *params)
 {
        struct acpi_buffer output;
        union acpi_object out_obj;
@@ -453,7 +494,7 @@
        output.length = sizeof(out_obj);
        output.pointer = &out_obj;

-       status = acpi_evaluate_object(handle, (char *)method, NULL, &output);
+       status = acpi_evaluate_object(handle, (char *)method, params, 
&output);
        *val = out_obj.integer.value;
        return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
 }
@@ -484,7 +525,7 @@
         * bit signifies that the laptop is equipped with a Wi-Fi MiniPCI 
card.
         * The significance of others is yet to be found.
         */
-       if (read_acpi_int(hotk->handle, "SFUN", &temp))
+       if (read_acpi_int(hotk->handle, "SFUN", &temp, NULL))
                len +=
                    sprintf(page + len, "SFUN value         : 0x%04x\n", 
temp);
        /*
@@ -494,7 +535,7 @@
         * Note: since not all the laptops provide this method, errors are
         * silently ignored.
         */
-       if (read_acpi_int(hotk->handle, "ASYM", &temp))
+       if (read_acpi_int(hotk->handle, "ASYM", &temp, NULL))
                len +=
                    sprintf(page + len, "ASYM value         : 0x%04x\n", 
temp);
        if (asus_info) {
@@ -532,7 +573,7 @@
        if (ledname) {
                int led_status;

-               if (read_acpi_int(NULL, ledname, &led_status))
+               if (read_acpi_int(NULL, ledname, &led_status, NULL))
                        return led_status;
                else
                        printk(KERN_WARNING "Asus ACPI: Error reading LED "
@@ -688,7 +729,7 @@

        if (hotk->model != L3H) {
                /* We don't have to check anything if we are here */
-               if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
+               if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd, 
NULL))
                        printk(KERN_WARNING
                               "Asus ACPI: Error reading LCD status\n");

@@ -779,12 +820,12 @@

        if (hotk->methods->brightness_get) {    /* SPLV/GPLV laptop */
                if (!read_acpi_int(hotk->handle, 
hotk->methods->brightness_get,
-                                  &value))
+                                  &value, NULL))
                        printk(KERN_WARNING
                               "Asus ACPI: Error reading brightness\n");
        } else if (hotk->methods->brightness_status) {  /* For D1 for example 
*/
                if (!read_acpi_int(NULL, hotk->methods->brightness_status,
-                                  &value))
+                                  &value, NULL))
                        printk(KERN_WARNING
                               "Asus ACPI: Error reading brightness\n");
        } else                  /* No GPLV method */
@@ -864,7 +905,7 @@
 {
        int value = 0;

-       if (!read_acpi_int(hotk->handle, hotk->methods->display_get, &value))
+       if (!read_acpi_int(hotk->handle, hotk->methods->display_get, &value, 
NULL))
                printk(KERN_WARNING
                       "Asus ACPI: Error reading display status\n");
        value &= 0x07;          /* needed for some models, shouldn't hurt 
others */
@@ -1125,7 +1166,7 @@
        }

        /* This needs to be called for some laptops to init properly */
-       if (!read_acpi_int(hotk->handle, "BSTS", &bsts_result))
+       if (!read_acpi_int(hotk->handle, "BSTS", &bsts_result, NULL))
                printk(KERN_WARNING "  Error calling BSTS\n");
        else if (bsts_result)
                printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n",

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

