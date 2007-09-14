From: Marek Hobler <kernellist@neutrinus.com>
Subject: Re: [PATCH] Add bluetooth enabling support for toshiba_acpi
Date: Fri, 14 Sep 2007 12:06:36 +0200
Message-ID: <46EA5D2C.8080306@neutrinus.com>
References: <46E9AF7D.9090902@neutrinus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from neutrinus.com ([85.10.192.131]:4962 "EHLO neutrinus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbXINKGZ (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 14 Sep 2007 06:06:25 -0400
In-Reply-To: <46E9AF7D.9090902@neutrinus.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org, lenb@kernel.org

In my last patch was a bug in checking parametrs in write_bt().. This patch doesn't have this bug.


Add interface to enable usb-bluetooth device in Toshiba notebook.

Index: linux-2.6.23-rc6/drivers/acpi/toshiba_acpi.c
===================================================================
--- /usr/src/linux-2.6.23-rc6.orig/drivers/acpi/toshiba_acpi.c  2007-07-09 01:32:17.000000000 +0200
+++ /usr/src/linux-2.6.23-rc6/drivers/acpi/toshiba_acpi.c       2007-09-14 11:44:22.000000000 +0200
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
+    if (sscanf(buffer, " power : %i", &value) == 1 &&  (value >= 0 && value <= 1)  ) {
+               hci_write2(HCI_BT, value, HCI_BT_POWER, &hci_result);
+        if (hci_result != HCI_SUCCESS)
+            return -EFAULT;
+    } else if (sscanf(buffer, " attach : %i", &value) == 1 && ( value >= 0 && value <= 1 )) {
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
