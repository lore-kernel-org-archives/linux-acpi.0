From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/18] ACPI EC: enable MSI workaround for Quanta laptops
Date: Sun, 29 May 2011 05:44:08 -0400
Message-ID: <534bc4e3d27096e2f3fc00c14a20efd597837a4f.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55529 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1E2J5y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:57:54 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY0094DBOGA0E2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:57:53 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Enable MSI workaround for Quanta laptops.
https://bugzilla.kernel.org/show_bug.cgi?id=20242

Tested-by: Jan-Matthias Braun <jan_braun@gmx.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index fa848c4..62628e5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -938,6 +938,14 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
 	ec_flag_msi, "MSI hardware", {
 	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-STAR")}, NULL},
 	{
+	ec_flag_msi, "Quanta hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "Quanta"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "TW8/SW8/DW8"),}, NULL},
+	{
+	ec_flag_msi, "Quanta hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "Quanta"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "TW9/SW9"),}, NULL},
+	{
 	ec_validate_ecdt, "ASUS hardware", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
 	{},
-- 
1.7.5.3.367.ga9930.dirty

