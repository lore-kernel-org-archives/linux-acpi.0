From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/8] ACPI: Add ThinkPad R61, ThinkPad T61 to OSI(Linux) white-list
Date: Wed, 23 Jan 2008 21:32:46 -0500
Message-ID: <98f1db22d70b0660a27cc8818a61181b5d503671.1201141721.git.len.brown@intel.com>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:60148 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752505AbYAXCdk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:33:40 -0500
In-Reply-To: <1201141967-28134-1-git-send-email-lenb@kernel.org>
In-Reply-To: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
References: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

acpi_osi=Linux helps sound on these systems.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 018fc16..e88d446 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -173,7 +173,34 @@ int __init acpi_blacklisted(void)
 	return blacklisted;
 }
 #ifdef CONFIG_DMI
+static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
+{
+	acpi_dmi_osi_linux(1, d);	/* enable */
+	return 0;
+}
+
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
+	/*
+	 * _OSI(Linux) helps sound
+	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
+	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+	 */
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad R61",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad T61",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+		},
+	},
 	{}
 };
 
-- 
1.5.4.rc4.14.g6fc74

