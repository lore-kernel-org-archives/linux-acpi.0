From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 15/33] eeepc-laptop: fix set_acpi() to return non-zero on failure
Date: Thu,  3 Dec 2009 08:44:59 +0100
Message-ID: <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44220 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbZLCHof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:35 -0500
In-Reply-To: <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

If the control method does not exist, return -ENODEV for consistency
with get_acpi()

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
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
1.6.5.3

