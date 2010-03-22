From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI dock: support multiple ACPI dock devices
Date: Mon, 22 Mar 2010 15:46:49 +0800
Message-ID: <1269244009.2205.1680.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42764 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512Ab0CVHpl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Mar 2010 03:45:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>


There may be multiple ACPI dock devices exist in ACPI namespace
and we should probe all of them.
http://bugzilla.kernel.org/show_bug.cgi?id=15521

CC: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/dock.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/acpi/dock.c
===================================================================
--- linux-2.6.orig/drivers/acpi/dock.c	2010-03-22 10:19:00.000000000 +0800
+++ linux-2.6/drivers/acpi/dock.c	2010-03-22 10:22:31.000000000 +0800
@@ -1025,13 +1025,10 @@
 static acpi_status
 find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	acpi_status status = AE_OK;
-
 	if (is_dock(handle))
-		if (dock_add(handle) >= 0)
-			status = AE_CTRL_TERMINATE;
+		dock_add(handle);
 
-	return status;
+	return AE_OK;
 }
 
 static acpi_status


