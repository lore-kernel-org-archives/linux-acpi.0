From: Tobias Schumacher <tobe.schumacher@gmail.com>
Subject: [PATCH] Fix lock up when switching off discrete graphics card in Dell XPS 9560 https://bugzilla.kernel.org/show_bug.cgi?id=156341
Date: Tue, 21 Feb 2017 01:36:25 +0100
Message-ID: <20170221003625.17551-1-tobe.schumacher@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36829 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdBUAgy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2017 19:36:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Tobias Schumacher <tobe.schumacher@gmail.com>

Signed-off-by: Tobias Schumacher <tobe.schumacher@gmail.com>
---
 drivers/acpi/blacklist.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 4421f7c..7945f2f 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -188,6 +188,20 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
 		      DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3350"),
 		},
 	},
+	/*
+	 * Resolves issues that cause the system to lock up
+	 * under certain conditions when the discrete graphics
+	 * card is turned off
+	 */
+	{
+	 .callback = dmi_enable_rev_override,
+	 .ident = "DELL XPS 15 (2017)",
+	 .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9560"),
+		},
+	},
+
 #endif
 	{}
 };
-- 
2.9.3

