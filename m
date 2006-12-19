From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 4/22] Change methods names
Date: Tue, 19 Dec 2006 22:19:03 +0100
Message-ID: <200612192219.03908.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50177 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933018AbWLSVZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

This patch change the methods name from mt_xxx to xxx_set as I think it's
easier to understand like that.

---
 asus_acpi.c |  174 
++++++++++++++++++++++++++++++------------------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 10:38:26.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 10:42:16.000000000 +0100
@@ -80,16 +80,16 @@
  * those marked with R are relative to HOTK, A for absolute */
 struct model_data {
        char *name;             //name of the laptop________________A
-       char *mt_mled;          //method to handle mled_____________R
+       char *mled_set;         //method to handle mled_____________R
        char *mled_status;      //node to handle mled reading_______A
-       char *mt_wled;          //method to handle wled_____________R
+       char *wled_set;         //method to handle wled_____________R
        char *wled_status;      //node to handle wled reading_______A
-       char *mt_tled;          //method to handle tled_____________R
+       char *tled_set;         //method to handle tled_____________R
        char *tled_status;      //node to handle tled reading_______A
-       char *mt_ledd;          //method to handle LED display______R
-       char *mt_bt_switch;     //method to switch Bluetooth on/off_R
-       char *bt_status;        //no model currently supports this__?
-       char *mt_lcd_switch;    //method to turn LCD on/off_________A
+       char *ledd_set;         //method to handle LED display______R
+       char *bt_switch;        //method to switch Bluetooth on/off_R
+       char *bt_status;        //method to read Bluetooth state____A
+       char *lcd_switch;       //method to turn LCD on/off_________A
        char *lcd_status;       //node to read LCD panel state______A
        char *brightness_up;    //method to set brightness up_______A
        char *brightness_down;  //guess what ?______________________A
@@ -157,19 +157,19 @@

        {
         .name = "A1x",
-        .mt_mled = "MLED",
+        .mled_set = "MLED",
         .mled_status = "\\MAIL",
-        .mt_lcd_switch = A1x_PREFIX "_Q10",
+        .lcd_switch = A1x_PREFIX "_Q10",
         .lcd_status = "\\BKLI",
         .brightness_up = A1x_PREFIX "_Q0E",
         .brightness_down = A1x_PREFIX "_Q0F"},

        {
         .name = "A2x",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
         .wled_status = "\\SG66",
-        .mt_lcd_switch = "\\Q10",
+        .lcd_switch = "\\Q10",
         .lcd_status = "\\BAOF",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -178,9 +178,9 @@

        {
         .name = "A4G",
-        .mt_mled = "MLED",
+        .mled_set = "MLED",
 /* WLED present, but not controlled by ACPI */
-        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_switch = xxN_PREFIX "_Q10",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
         .display_set = "SDSP",
@@ -188,8 +188,8 @@

        {
         .name = "D1x",
-        .mt_mled = "MLED",
-        .mt_lcd_switch = "\\Q0D",
+        .mled_set = "MLED",
+        .lcd_switch = "\\Q0D",
         .lcd_status = "\\GP11",
         .brightness_up = "\\Q0C",
         .brightness_down = "\\Q0B",
@@ -199,11 +199,11 @@

        {
         .name = "L2D",
-        .mt_mled = "MLED",
+        .mled_set = "MLED",
         .mled_status = "\\SGP6",
-        .mt_wled = "WLED",
+        .wled_set = "WLED",
         .wled_status = "\\RCP3",
-        .mt_lcd_switch = "\\Q10",
+        .lcd_switch = "\\Q10",
         .lcd_status = "\\SGP0",
         .brightness_up = "\\Q0E",
         .brightness_down = "\\Q0F",
@@ -212,9 +212,9 @@

        {
         .name = "L3C",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = L3C_PREFIX "_Q10",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = L3C_PREFIX "_Q10",
         .lcd_status = "\\GL32",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -223,10 +223,10 @@

        {
         .name = "L3D",
-        .mt_mled = "MLED",
+        .mled_set = "MLED",
         .mled_status = "\\MALD",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = "\\Q10",
+        .wled_set = "WLED",
+        .lcd_switch = "\\Q10",
         .lcd_status = "\\BKLG",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -235,9 +235,9 @@

        {
         .name = "L3H",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = "EHK",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = "EHK",
         .lcd_status = "\\_SB.PCI0.PM.PBC",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -246,10 +246,10 @@

        {
         .name = "L4R",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
         .wled_status = "\\_SB.PCI0.SBRG.SG13",
-        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_switch = xxN_PREFIX "_Q10",
         .lcd_status = "\\_SB.PCI0.SBSM.SEO4",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -258,10 +258,10 @@

        {
         .name = "L5x",
-        .mt_mled = "MLED",
+        .mled_set = "MLED",
 /* WLED present, but not controlled by ACPI */
-        .mt_tled = "TLED",
-        .mt_lcd_switch = "\\Q0D",
+        .tled_set = "TLED",
+        .lcd_switch = "\\Q0D",
         .lcd_status = "\\BAOF",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -275,8 +275,8 @@

        {
         .name = "M1A",
-        .mt_mled = "MLED",
-        .mt_lcd_switch = M1A_PREFIX "Q10",
+        .mled_set = "MLED",
+        .lcd_switch = M1A_PREFIX "Q10",
         .lcd_status = "\\PNOF",
         .brightness_up = M1A_PREFIX "Q0E",
         .brightness_down = M1A_PREFIX "Q0F",
@@ -286,9 +286,9 @@

        {
         .name = "M2E",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = "\\Q10",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = "\\Q10",
         .lcd_status = "\\GP06",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -297,10 +297,10 @@

        {
         .name = "M6N",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
         .wled_status = "\\_SB.PCI0.SBRG.SG13",
-        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_switch = xxN_PREFIX "_Q10",
         .lcd_status = "\\_SB.BKLT",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -309,9 +309,9 @@

        {
         .name = "M6R",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
         .lcd_status = "\\_SB.PCI0.SBSM.SEO4",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -320,8 +320,8 @@

        {
         .name = "P30",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = P30_PREFIX "_Q0E",
+        .wled_set = "WLED",
+        .lcd_switch = P30_PREFIX "_Q0E",
         .lcd_status = "\\BKLT",
         .brightness_up = P30_PREFIX "_Q68",
         .brightness_down = P30_PREFIX "_Q69",
@@ -331,29 +331,29 @@

        {
         .name = "S1x",
-        .mt_mled = "MLED",
+        .mled_set = "MLED",
         .mled_status = "\\EMLE",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = S1x_PREFIX "Q10",
+        .wled_set = "WLED",
+        .lcd_switch = S1x_PREFIX "Q10",
         .lcd_status = "\\PNOF",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV"},

        {
         .name = "S2x",
-        .mt_mled = "MLED",
+        .mled_set = "MLED",
         .mled_status = "\\MAIL",
-        .mt_lcd_switch = S2x_PREFIX "_Q10",
+        .lcd_switch = S2x_PREFIX "_Q10",
         .lcd_status = "\\BKLI",
         .brightness_up = S2x_PREFIX "_Q0B",
         .brightness_down = S2x_PREFIX "_Q0A"},

        {
         .name = "W1N",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
-        .mt_ledd = "SLCM",
-        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .ledd_set = "SLCM",
+        .lcd_switch = xxN_PREFIX "_Q10",
         .lcd_status = "\\BKLT",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -362,9 +362,9 @@

        {
         .name = "W5A",
-        .mt_bt_switch = "BLED",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .bt_switch = "BLED",
+        .wled_set = "WLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
         .display_set = "SDSP",
@@ -372,9 +372,9 @@

        {
         .name = "W3V",
-        .mt_mled = "MLED",
-        .mt_wled = "WLED",
-        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
         .lcd_status = "\\BKLT",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -383,9 +383,9 @@

        {
         .name = "xxN",
-        .mt_mled = "MLED",
+        .mled_set = "MLED",
 /* WLED present, but not controlled by ACPI */
-        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_switch = xxN_PREFIX "_Q10",
         .lcd_status = "\\BKLT",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
@@ -596,7 +596,7 @@
 proc_write_mled(struct file *file, const char __user * buffer,
                unsigned long count, void *data)
 {
-       return write_led(buffer, count, hotk->methods->mt_mled, MLED_ON, 1);
+       return write_led(buffer, count, hotk->methods->mled_set, MLED_ON, 1);
 }

 /*
@@ -618,7 +618,7 @@
        rv = parse_arg(buffer, count, &value);
        if (rv > 0) {
                if (!write_acpi_int
-                   (hotk->handle, hotk->methods->mt_ledd, value, NULL))
+                   (hotk->handle, hotk->methods->ledd_set, value, NULL))
                        printk(KERN_WARNING
                               "Asus ACPI: LED display write failed\n");
                else
@@ -642,7 +642,7 @@
 proc_write_wled(struct file *file, const char __user * buffer,
                unsigned long count, void *data)
 {
-       return write_led(buffer, count, hotk->methods->mt_wled, WLED_ON, 0);
+       return write_led(buffer, count, hotk->methods->wled_set, WLED_ON, 0);
 }

 /*
@@ -659,9 +659,9 @@
 proc_write_bluetooth(struct file *file, const char __user * buffer,
                     unsigned long count, void *data)
 {
-       /* Note: mt_bt_switch controls both internal Bluetooth adapter's
+       /* Note: bt_switch controls both internal Bluetooth adapter's
           presence and its LED */
-       return write_led(buffer, count, hotk->methods->mt_bt_switch, BT_ON, 
0);
+       return write_led(buffer, count, hotk->methods->bt_switch, BT_ON, 0);
 }

 /*
@@ -679,7 +679,7 @@
 proc_write_tled(struct file *file, const char __user * buffer,
                unsigned long count, void *data)
 {
-       return write_led(buffer, count, hotk->methods->mt_tled, TLED_ON, 0);
+       return write_led(buffer, count, hotk->methods->tled_set, TLED_ON, 0);
 }

 static int get_lcd_state(void)
@@ -737,11 +737,11 @@
                if (hotk->model != L3H) {
                        status =
                            acpi_evaluate_object(NULL,
-                                                hotk->methods->mt_lcd_switch,
+                                                hotk->methods->lcd_switch,
                                                 NULL, NULL);
                } else {        /* L3H and the like have to be handled 
differently */
                        if (!write_acpi_int
-                           (hotk->handle, hotk->methods->mt_lcd_switch, 0x07,
+                           (hotk->handle, hotk->methods->lcd_switch, 0x07,
                             NULL))
                                status = AE_ERROR;
                        /* L3H's AML executes EHK (0x07) upon Fn+F7 keypress,
@@ -937,27 +937,27 @@
                       " fs entry\n");
        }

-       if (hotk->methods->mt_wled) {
+       if (hotk->methods->wled_set) {
                asus_proc_add(PROC_WLED, &proc_write_wled, &proc_read_wled,
                              mode, device);
        }

-       if (hotk->methods->mt_ledd) {
+       if (hotk->methods->ledd_set) {
                asus_proc_add(PROC_LEDD, &proc_write_ledd, &proc_read_ledd,
                              mode, device);
        }

-       if (hotk->methods->mt_mled) {
+       if (hotk->methods->mled_set) {
                asus_proc_add(PROC_MLED, &proc_write_mled, &proc_read_mled,
                              mode, device);
        }

-       if (hotk->methods->mt_tled) {
+       if (hotk->methods->tled_set) {
                asus_proc_add(PROC_TLED, &proc_write_tled, &proc_read_tled,
                              mode, device);
        }

-       if (hotk->methods->mt_bt_switch) {
+       if (hotk->methods->bt_switch) {
                asus_proc_add(PROC_BT, &proc_write_bluetooth,
                              &proc_read_bluetooth, mode, device);
        }
@@ -966,7 +966,7 @@
         * We need both read node and write method as LCD switch is also
         * accessible from keyboard
         */
-       if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status) {
+       if (hotk->methods->lcd_switch && hotk->methods->lcd_status) {
                asus_proc_add(PROC_LCD, &proc_write_lcd, &proc_read_lcd, mode,
                              device);
        }
@@ -989,17 +989,17 @@
 {
        if (acpi_device_dir(device)) {
                remove_proc_entry(PROC_INFO, acpi_device_dir(device));
-               if (hotk->methods->mt_wled)
+               if (hotk->methods->wled_set)
                        remove_proc_entry(PROC_WLED, acpi_device_dir(device));
-               if (hotk->methods->mt_mled)
+               if (hotk->methods->mled_set)
                        remove_proc_entry(PROC_MLED, acpi_device_dir(device));
-               if (hotk->methods->mt_tled)
+               if (hotk->methods->tled_set)
                        remove_proc_entry(PROC_TLED, acpi_device_dir(device));
-               if (hotk->methods->mt_ledd)
+               if (hotk->methods->ledd_set)
                        remove_proc_entry(PROC_LEDD, acpi_device_dir(device));
-               if (hotk->methods->mt_bt_switch)
+               if (hotk->methods->bt_switch)
                        remove_proc_entry(PROC_BT, acpi_device_dir(device));
-               if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status)
+               if (hotk->methods->lcd_switch && hotk->methods->lcd_status)
                        remove_proc_entry(PROC_LCD, acpi_device_dir(device));
                if ((hotk->methods->brightness_up
                     && hotk->methods->brightness_down)
@@ -1182,15 +1182,15 @@
        else if (strncmp(string, "S5N", 3) == 0 ||
                 strncmp(string, "M5N", 3) == 0 ||
                 strncmp(string, "W3N", 3) == 0)
-               hotk->methods->mt_mled = NULL;
+               hotk->methods->mled_set = NULL;
        /* S5N, M5N and W3N have no MLED */
        else if (strncmp(string, "L5D", 3) == 0)
-               hotk->methods->mt_wled = NULL;
+               hotk->methods->wled_set = NULL;
        /* L5D's WLED is not controlled by ACPI */
        else if (strncmp(string, "M2N", 3) == 0 ||
                 strncmp(string, "W3V", 3) == 0 ||
                 strncmp(string, "S1N", 3) == 0)
-               hotk->methods->mt_wled = "WLED";
+               hotk->methods->wled_set = "WLED";
        /* M2N, S1N and W3V have a usable WLED */
        else if (asus_info) {
                if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

