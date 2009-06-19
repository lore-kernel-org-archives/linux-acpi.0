From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 6/9] eeepc-laptop: makes get_acpi() returns -ENODEV
Date: Fri, 19 Jun 2009 14:52:08 +0200
Message-ID: <1245415931-26466-6-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
 <1245415931-26466-1-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-2-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-3-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-4-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-5-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.orange.fr ([80.12.242.49]:23098 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbZFSMyn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2009 08:54:43 -0400
In-Reply-To: <1245415931-26466-5-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

If there is there is no getter defined, get_acpi()
will return -ENODEV.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index aad5d16..b1998f9 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -287,7 +287,7 @@ static int set_acpi(int cm, int value)
 
 static int get_acpi(int cm)
 {
-	int value = -1;
+	int value = -ENODEV;
 	if ((ehotk->cm_supported & (0x1 << cm))) {
 		const char *method = cm_getv[cm];
 		if (method == NULL)
@@ -365,13 +365,19 @@ static ssize_t store_sys_acpi(int cm, const char *buf, size_t count)
 
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
@@ -1003,8 +1009,9 @@ static int eeepc_new_rfkill(struct rfkill **rfkill,
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
1.6.3.1


