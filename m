From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] ACPI: Disable Vista compatibility for Sony VGN-SR19XN.
Date: Mon, 16 Mar 2015 17:35:18 +0800
Message-ID: <1426498518-9853-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10929 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbbCPJbF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Mar 2015 05:31:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com, Chen Yu <yu.c.chen@intel.com>

Sony VGN-SR19XN laptop needs to disable windows vista compatibility,
or else it freezes when plugging/unplugging the VGA connector.

https://bugzilla.kernel.org/show_bug.cgi?id=66771

Tested-by: Lionel Duriez <lionelduriez@hotmail.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/blacklist.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 9b693d5..1d17919 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -215,6 +215,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{
 	.callback = dmi_disable_osi_vista,
+	.ident = "VGN-SR19XN",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR19XN"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
 	.ident = "Toshiba Satellite L355",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-- 
1.8.4.2

