From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH_2/7] ACPI: Modify the ACPI I/O Access width
Date: Thu, 15 Nov 2007 17:01:06 +0800
Message-ID: <1195117266.6817.33.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39519 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756478AbXKOIwE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 03:52:04 -0500
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Modify the ACPI I/O Access width
>From : Zhao Yakui <yakui.zhao@intel.com>
 
When the argument width is not the multiple of eight, the acpi I/O access
will fail. Modify the acpi I/O access width to the multiple of eight.
 
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/osl.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

Index: linux-2.6.24-rc1/drivers/acpi/osl.c
===================================================================
--- linux-2.6.24-rc1.orig/drivers/acpi/osl.c
+++ linux-2.6.24-rc1/drivers/acpi/osl.c
@@ -387,17 +387,14 @@ acpi_status acpi_os_read_port(acpi_io_ad
 	if (!value)
 		value = &dummy;
 
-	switch (width) {
-	case 8:
+	*value = 0;
+	if (width <= 8) {
 		*(u8 *) value = inb(port);
-		break;
-	case 16:
+	} else if (width <= 16) {
 		*(u16 *) value = inw(port);
-		break;
-	case 32:
+	} else if (width <= 32) {
 		*(u32 *) value = inl(port);
-		break;
-	default:
+	} else {
 		BUG();
 	}
 
@@ -408,17 +405,13 @@ EXPORT_SYMBOL(acpi_os_read_port);
 
 acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 {
-	switch (width) {
-	case 8:
+	if (width <= 8) {
 		outb(value, port);
-		break;
-	case 16:
+	} else if (width <= 16) {
 		outw(value, port);
-		break;
-	case 32:
+	} else if (width <= 32) {
 		outl(value, port);
-		break;
-	default:
+	} else {
 		BUG();
 	}
 
