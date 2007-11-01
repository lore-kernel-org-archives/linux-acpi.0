From: Joe Perches <joe@perches.com>
Subject: [PATCH] - bay.c - convert macro to function
Date: Thu, 01 Nov 2007 15:45:40 -0700
Message-ID: <1193957140.21506.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:4102 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbXKAWpt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Nov 2007 18:45:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org

Convert bay_dprintk from macro to function.

Compiled/untested x86
Reduces image size ~250 bytes.

old:
$ size drivers/acpi/bay.o
   text    data     bss     dec     hex filename
   2088      48       0    2136     858 drivers/acpi/bay.o

new:
$ size drivers/acpi/bay.o
   text    data     bss     dec     hex filename
   1716      48       0    1764     6e4 drivers/acpi/bay.o

Signed-off-by: Joe Perches <joe@perches.com>

---

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 6daf608..93c735b 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -39,11 +39,7 @@ MODULE_LICENSE("GPL");
 #define ACPI_BAY_CLASS "bay"
 #define ACPI_BAY_COMPONENT	0x10000000
 #define _COMPONENT ACPI_BAY_COMPONENT
-#define bay_dprintk(h,s) {\
-	char prefix[80] = {'\0'};\
-	struct acpi_buffer buffer = {sizeof(prefix), prefix};\
-	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);\
-	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, s); }
+
 static void bay_notify(acpi_handle handle, u32 event, void *data);
 
 struct bay {
@@ -55,6 +51,14 @@ struct bay {
 
 static LIST_HEAD(drive_bays);
 
+static void bay_dprintk(acpi_handle handle, const char *string)
+{
+	char prefix[80] = {'\0'};
+	struct acpi_buffer buffer = {sizeof(prefix), prefix};
+
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, string);
+}
 
 /*****************************************************************************
  *                         Drive Bay functions                               *


