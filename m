From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/8] eeepc-laptop: makes get_acpi() returns -ENODEV
Date: Fri, 26 Jun 2009 00:20:17 -0400
Message-ID: <de5d83707f832b2e6fe3b9d067eb4a3b1ca7dd47.1245989983.git.len.brown@intel.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:38147 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZFZEVK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 00:21:10 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLT00EXFW2ARWJ4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Jun 2009 23:20:40 -0500 (CDT)
In-reply-to: <1245990020-20455-1-git-send-email-lenb@kernel.org>
In-reply-to: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
References: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

If there is there is no getter defined, get_acpi()
will return -ENODEV.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 5b102c2..19cc9ae 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -289,7 +289,7 @@ static int set_acpi(int cm, int value)
 
 static int get_acpi(int cm)
 {
-	int value = -1;
+	int value = -ENODEV;
 	if ((ehotk->cm_supported & (0x1 << cm))) {
 		const char *method = cm_getv[cm];
 		if (method == NULL)
@@ -367,13 +367,19 @@ static ssize_t store_sys_acpi(int cm, const char *buf, size_t count)
 
 	rv = parse_arg(buf, count, &value);
 	if (rv > 0)
-		set_acpi(cm, value);
+		value = set_acpi(cm, value);
+	if (value < 0)
+		return value;
 	return rv;
 }
 
 static ssize_t show_sys_acpi(int cm, char *buf)
 {
-	return sprintf(buf, "%d\n", get_acpi(cm));
+	int value = get_acpi(cm);
+
+	if (value < 0)
+		return value;
+	return sprintf(buf, "%d\n", value);
 }
 
 #define EEEPC_CREATE_DEVICE_ATTR(_name, _cm)				\
@@ -1036,8 +1042,9 @@ static int eeepc_new_rfkill(struct rfkill **rfkill,
 {
 	int result;
 
-	if (get_acpi(cm) == -1)
-		return -ENODEV;
+	result = get_acpi(cm);
+	if (result < 0)
+		return result;
 
 	*rfkill = rfkill_alloc(name, dev, type,
 			       &eeepc_rfkill_ops, (void *)(unsigned long)cm);
-- 
1.6.0.6

