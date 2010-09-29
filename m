From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/16] ACPI: delete ZEPTO idle=nomwait DMI quirk
Date: Tue, 28 Sep 2010 23:44:34 -0400
Message-ID: <64a32307b710c100beb101e9c78f8022f0e8ba61.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:57311 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab0I2Dp0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:26 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00L9MP378O00@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:10 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

per comments in the bug report, this entry
seems to hurt at much as it helps.

https://bugzilla.kernel.org/show_bug.cgi?id=10807

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index e9699aa..b618f88 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -29,12 +29,6 @@ static int set_no_mwait(const struct dmi_system_id *id)
 
 static struct dmi_system_id __cpuinitdata processor_idle_dmi_table[] = {
 	{
-	set_no_mwait, "IFL91 board", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
-	DMI_MATCH(DMI_SYS_VENDOR, "ZEPTO"),
-	DMI_MATCH(DMI_PRODUCT_VERSION, "3215W"),
-	DMI_MATCH(DMI_BOARD_NAME, "IFL91") }, NULL},
-	{
 	set_no_mwait, "Extensa 5220", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 	DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
1.7.3.2.g9027fa

