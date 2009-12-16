From: Len Brown <lenb@kernel.org>
Subject: [PATCH 032/103] eeepc-laptop: fix set_acpi() to return non-zero on
 failure
Date: Wed, 16 Dec 2009 03:35:43 -0500
Message-ID: <13f70029daa3cd7f9983e4aec82f32939b1a6e6a.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41634 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760877AbZLPKGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:00 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:54 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

If the control method does not exist, return -ENODEV for consistency
with get_acpi()

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 8b686b5..abd7389 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -289,26 +289,30 @@ static int read_acpi_int(acpi_handle handle, const char *method, int *val)
 
 static int set_acpi(int cm, int value)
 {
-	if (ehotk->cm_supported & (0x1 << cm)) {
-		const char *method = cm_setv[cm];
-		if (method == NULL)
-			return -ENODEV;
-		if (write_acpi_int(ehotk->handle, method, value, NULL))
-			pr_warning("Error writing %s\n", method);
-	}
+	const char *method = cm_setv[cm];
+
+	if (method == NULL)
+		return -ENODEV;
+	if ((ehotk->cm_supported & (0x1 << cm)) == 0)
+		return -ENODEV;
+
+	if (write_acpi_int(ehotk->handle, method, value, NULL))
+		pr_warning("Error writing %s\n", method);
 	return 0;
 }
 
 static int get_acpi(int cm)
 {
-	int value = -ENODEV;
-	if ((ehotk->cm_supported & (0x1 << cm))) {
-		const char *method = cm_getv[cm];
-		if (method == NULL)
-			return -ENODEV;
-		if (read_acpi_int(ehotk->handle, method, &value))
-			pr_warning("Error reading %s\n", method);
-	}
+	const char *method = cm_getv[cm];
+	int value;
+
+	if (method == NULL)
+		return -ENODEV;
+	if ((ehotk->cm_supported & (0x1 << cm)) == 0)
+		return -ENODEV;
+
+	if (read_acpi_int(ehotk->handle, method, &value))
+		pr_warning("Error reading %s\n", method);
 	return value;
 }
 
-- 
1.6.0.6

