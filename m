From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: Disable Vista compatibility for Sony VGN-NS50B_L
Date: Tue, 08 Jun 2010 15:28:40 +0800
Message-ID: <1275982120.19052.11515.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63719 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab0FHH2P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jun 2010 03:28:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, harestomper@gmail.com


Disable Vista compatibility for Sony VGN-NS50B_L.
https://bugzilla.kernel.org/show_bug.cgi?id=12904#c46

Tested-by: Voldemar <harestomper@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/blacklist.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/drivers/acpi/blacklist.c
===================================================================
--- linux-2.6.orig/drivers/acpi/blacklist.c
+++ linux-2.6/drivers/acpi/blacklist.c
@@ -218,6 +218,14 @@ static struct dmi_system_id acpi_osi_dmi
 		},
 	},
 	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "VGN-NS50B_L",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NS50B_L"),
+		},
+	},
+	{
 	.callback = dmi_disable_osi_win7,
 	.ident = "ASUS K50IJ",
 	.matches = {


