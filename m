From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: fix string mismatch for Sony SR290 laptop
Date: Mon, 21 Jun 2010 12:47:05 +0800
Message-ID: <1277095625.1679.8559.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36110 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab0FUEqe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jun 2010 00:46:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "melchior+kernel@cmu.edu" <melchior+kernel@cmu.edu>, "Zhang, Rui" <rui.zhang@intel.com>

From: Nik A. Melchior <melchior+kernel@cmu.edu>

Fix string mismatch for Sony SR290 laptop.
https://bugzilla.kernel.org/show_bug.cgi?id=12904#c45

Signed-off-by: Nik A. Melchior <melchior+kernel@cmu.edu>
---
 drivers/acpi/blacklist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/blacklist.c
===================================================================
--- linux-2.6.orig/drivers/acpi/blacklist.c
+++ linux-2.6/drivers/acpi/blacklist.c
@@ -214,7 +214,7 @@ static struct dmi_system_id acpi_osi_dmi
 	.ident = "Sony VGN-SR290J",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Sony VGN-SR290J"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR290J"),
 		},
 	},
 	{


