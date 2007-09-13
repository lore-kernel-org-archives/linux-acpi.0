From: Marek Hobler <kernellist@neutrinus.com>
Subject: [PATCH] Add bluetooth enabling support for toshiba_acpi
Date: Thu, 13 Sep 2007 23:45:33 +0200
Message-ID: <46E9AF7D.9090902@neutrinus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from neutrinus.com ([85.10.192.131]:3477 "EHLO neutrinus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbXIMVpf (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 13 Sep 2007 17:45:35 -0400
Received: from neutrinus.com (localhost [127.0.0.1])
	by neutrinus.com (Postfix) with ESMTP id 1E69B300BB26
	for <Linux-acpi@vger.kernel.org>; Thu, 13 Sep 2007 23:48:20 +0200 (CEST)
Received: from [192.168.1.10] (awu106.neoplus.adsl.tpnet.pl [83.27.80.106])
	(Authenticated sender: kernellist@neutrinus.com)
	by neutrinus.com (Postfix) with ESMTP id 9ADA7300BB25
	for <Linux-acpi@vger.kernel.org>; Thu, 13 Sep 2007 23:48:19 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org

Add interface to enable usb-bluetooth device in Toshiba notebook.

Index: linux-2.6.23-rc6/drivers/acpi/toshiba_acpi.c
===================================================================
--- /usr/src/linux-2.6.23-rc6.orig/drivers/acpi/toshiba_acpi.c  2007-07-09 01:32:17.000000000 +0200
+++ /usr/src/linux-2.6.23-rc6/drivers/acpi/toshiba_acpi.c       2007-09-13 23:43:53.818098802 +0200
@@ -90,6 +90,10 @@
 #define HCI_VIDEO_OUT                  0x001c
 #define HCI_HOTKEY_EVENT               0x001e
 #define HCI_LCD_BRIGHTNESS             0x002a
+#define HCI_BT                         0x0056
+#define HCI_BT_POWER                   0x0080
+#define HCI_BT_ATTACH                  0x0040
+

 /* field definitions */
 #define HCI_LCD_BRIGHTNESS_BITS                3
@@ -201,6 +205,17 @@
        return status;
 }

+
+static acpi_status hci_write2(u32 reg, u32 in1, u32 in2, u32* result)
+{
+       u32 in[HCI_WORDS] = { HCI_SET, reg, in1, in2, 0, 0 };
+       u32 out[HCI_WORDS];
+       acpi_status status = hci_raw(in, out);
+       *result = (status == AE_OK) ? out[0] : HCI_FAILURE;
+       return status;
+}
+
+
 static acpi_status hci_read1(u32 reg, u32 * out1, u32 * result)
 {
        u32 in[HCI_WORDS] = { HCI_GET, reg, 0, 0, 0, 0 };
@@ -211,6 +226,19 @@
        return status;
 }

+ static acpi_status hci_read2(u32 reg, u32* out1, u32* out2, u32* result)
+ {
+     u32 in[HCI_WORDS] = { HCI_GET, reg, *out1, *out2, 0, 0 };
+     u32 out[HCI_WORDS];
+     acpi_status status = hci_raw(in, out);
+     *out1 = out[2];
+     *out2 = out[3];
+     *result = (status == AE_OK) ? out[0] : HCI_FAILURE;
+     return status;
+ }
+
+
+
 static struct proc_dir_entry *toshiba_proc_dir /*= 0*/ ;
 static struct backlight_device *toshiba_backlight_device;
 static int force_fan;
@@ -482,6 +510,54 @@
        return count;
 }

+
+static char* read_bt(char* p)
+{
+    u32 hci_result;
+       u32 value = 0;
+    u32 value2 = 0x000;
+       hci_read2(HCI_BT, &value, &value2, &hci_result);
+    if (hci_result == HCI_SUCCESS) {
+        p += sprintf(p,"present:                  %d\n", (value & 0x0f)?1:0);
+    } else {
+        p += sprintf(p, "ERROR\n");
+    }
+
+    value = 0;
+    value2 = 0x0001;
+       hci_read2(HCI_BT, &value, &value2, &hci_result);
+    if (hci_result == HCI_SUCCESS) {
+        p += sprintf(p,"power:                    %d\n", (value & 128) >> 7);
+        p += sprintf(p,"attach:                   %d\n", (value &  64) >> 6);
+        p += sprintf(p,"wireless:                 %d\n", (value & 512) >> 9);
+    } else {
+        p += sprintf(p, "ERROR\n");
+    }
+
+    return p;
+}
+
+static unsigned long write_bt(const char* buffer, unsigned long count)
+{
+    int value;
+    u32 hci_result;
+
+    if (sscanf(buffer, " power : %i", &value) == 1 && ( (value == 0) || (value == 1) ) ) {
+               hci_write2(HCI_BT, value, HCI_BT_POWER, &hci_result);
+        if (hci_result != HCI_SUCCESS)
+            return -EFAULT;
+    } else if (sscanf(buffer, " attach : %i", &value) == 1 && ( (value == 0) || (value == 1) )) {
+               hci_write2(HCI_BT, value, HCI_BT_ATTACH, &hci_result);
+        if (hci_result != HCI_SUCCESS)
+            return -EFAULT;
+    } else {
+        return -EINVAL;
+    }
+
+    return count;
+}
+
+
 static char *read_version(char *p)
 {
        p += sprintf(p, "driver:                  %s\n", TOSHIBA_ACPI_VERSION);
@@ -501,6 +577,7 @@
        {"fan", read_fan, write_fan},
        {"keys", read_keys, write_keys},
        {"version", read_version, NULL},
+       {"bluetooth", read_bt, write_bt },
        {NULL}
 };





regards,
Marek Hobler, 'neutrinus'
-- 
GNU/Human
