From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 1/1] switch the Asus Pundit P1-AH2 to old acpi sleep ordering
Date: Wed, 11 Feb 2009 18:11:22 +0000
Message-ID: <1234375882-5193-1-git-send-email-apw@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37046 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbZBKSL0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Feb 2009 13:11:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Dustin Kirkland <kirkland@canonical.com>

Switch the Asus Pundit P1-AH2 (M2N8L motherboard) to the old ACPI 1.0
sleep ordering by default.  Without this it will not suspend/resume
correctly.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
Tested-by: Dustin Kirkland <kirkland@canonical.com>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 5192666..3ca9868 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -378,6 +378,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Macmini1,1"),
 		},
 	},
+	{
+	.callback = init_old_suspend_ordering,
+	.ident = "Asus Pundit P1-AH2 (M2N8L motherboard)",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTek Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "M2N8L"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */
-- 
1.6.1.2.419.g0d87e

