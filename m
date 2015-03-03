From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI / blacklist: blacklist Win8 OSI for HP Pavilion dv6
Date: Tue,  3 Mar 2015 14:39:14 +0800
Message-ID: <1425364754-31900-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51862 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbbCCGjW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2015 01:39:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, alex.hung@canonical.com

The brightness hotkeys of HP Pavilion dv6 does not work with Win8 OSI. Due
to insufficient documentation for the driver implementation, blacklist
it as a workaround.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/blacklist.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 9b693d5..98aa360 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -300,6 +300,18 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 
 	/*
+	 * The brightness hotkeys do not work on those machines when
+	 * returning true for _OSI("Windows 2012")
+	 */
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "HP Pavilion dv6",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv6 Notebook PC"),
+		},
+	},
+	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
 	 * Linux ignores it, except for the machines enumerated below.
 	 */
-- 
1.7.9.5

