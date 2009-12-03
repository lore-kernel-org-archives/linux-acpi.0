From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 30/33] eeepc-laptop: fix coding style
Date: Thu,  3 Dec 2009 08:45:14 +0100
Message-ID: <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
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
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-22-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-23-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-24-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-25-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-26-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-28-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-29-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44221 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbZLCHoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:38 -0500
In-Reply-To: <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

fix styles problems introduced by commit
e86bda235a08b6a8e64c1e8bb9d175f6961554e3

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.5.3

