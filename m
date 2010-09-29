From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/16] ACPI: EC: add Vista incompatibility DMI entry for
 Toshiba Satellite L355
Date: Tue, 28 Sep 2010 23:44:36 -0400
Message-ID: <7a1d602f5fc35d14907b7da98d5627acb69589d1.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:36923 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab0I2DpM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:12 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H002SXP3BK884@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:12 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

https://bugzilla.kernel.org/show_bug.cgi?id=12641

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 3eda6c0..571a003 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -228,6 +228,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		},
 	},
 	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Toshiba Satellite L355",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "Satellite L355"),
+		},
+	},
+	{
 	.callback = dmi_disable_osi_win7,
 	.ident = "ASUS K50IJ",
 	.matches = {
-- 
1.7.3.2.g9027fa

