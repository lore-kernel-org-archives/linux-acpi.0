From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] acpi/blacklist: enable OSI(Linux) on newer eeepc
Date: Fri, 20 Nov 2009 22:29:08 +0100
Message-ID: <1258752548-9299-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:39757 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189AbZKTV24 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Nov 2009 16:28:56 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Corentin Chary <corentincj@iksaif.net>

Without this patch, eeepc-laptop won't work on newer Eeepc
because the interface it uses is disabled.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/acpi/blacklist.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index e56b2a7..cd7015d 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -218,6 +218,27 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 */
 
 	/*
+	 * On newer Eeepc, the interface used by eeepc-laptop (ASUS010)
+	 * is disabled without _OSI(Linux)
+	 */
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Asus Eeepc-1000H",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "1000H"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Asus Eeepc-1005HA",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "1005HA"),
+		},
+	},
+
+	/*
 	 * Lenovo has a mix of systems OSI(Linux) situations
 	 * and thus we can not wildcard the vendor.
 	 *
-- 
1.6.5.2

