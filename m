From: Len Brown <lenb@kernel.org>
Subject: [PATCH 047/103] eeepc-laptop: fix coding style
Date: Wed, 16 Dec 2009 03:35:58 -0500
Message-ID: <f90be874303eddc53c199083a37bc44d65ab8351.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951AbZLPKFv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:05:51 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:50 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

fix styles problems introduced by commit
e86bda235a08b6a8e64c1e8bb9d175f6961554e3

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 920d9d9..5f0eb76 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -244,7 +244,8 @@ static int get_acpi(struct eeepc_laptop *eeepc, int cm)
 	return value;
 }
 
-static int acpi_setter_handle(struct eeepc_laptop *eeepc, int cm, acpi_handle *handle)
+static int acpi_setter_handle(struct eeepc_laptop *eeepc, int cm,
+			      acpi_handle *handle)
 {
 	const char *method = cm_setv[cm];
 	acpi_status status;
@@ -255,7 +256,7 @@ static int acpi_setter_handle(struct eeepc_laptop *eeepc, int cm, acpi_handle *h
 		return -ENODEV;
 
 	status = acpi_get_handle(eeepc->handle, (char *)method,
-			         handle);
+				 handle);
 	if (status != AE_OK) {
 		pr_warning("Error finding %s\n", method);
 		return -ENODEV;
@@ -1274,7 +1275,8 @@ static void cmsg_quirks(struct eeepc_laptop *eeepc)
 	cmsg_quirk(eeepc, CM_ASL_TPD, "TPD");
 }
 
-static int eeepc_acpi_init(struct eeepc_laptop *eeepc, struct acpi_device *device)
+static int eeepc_acpi_init(struct eeepc_laptop *eeepc,
+			   struct acpi_device *device)
 {
 	unsigned int init_flags;
 	int result;
-- 
1.6.0.6

