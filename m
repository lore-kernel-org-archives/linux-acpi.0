From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/34] ACPI: EC: Fix MSI DMI detection
Date: Thu, 24 Dec 2009 01:23:37 -0500
Message-ID: <55b313f249e11b815fd0be51869f166aaf368f44.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:29691 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbZLXGYO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 01:24:14 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV5008VS8GC2423@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 00:24:13 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, stable@kernel.org, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

MSI strings should be ORed, not ANDed.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=14446

cc: stable@kernel.org
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index baef28c..7511029 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -916,6 +916,7 @@ static int ec_validate_ecdt(const struct dmi_system_id *id)
 /* MSI EC needs special treatment, enable it */
 static int ec_flag_msi(const struct dmi_system_id *id)
 {
+	printk(KERN_DEBUG PREFIX "Detected MSI hardware, enabling workarounds.\n");
 	EC_FLAGS_MSI = 1;
 	EC_FLAGS_VALIDATE_ECDT = 1;
 	return 0;
@@ -928,8 +929,13 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
 	DMI_MATCH(DMI_BOARD_NAME, "JFL92") }, NULL},
 	{
 	ec_flag_msi, "MSI hardware", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "Micro-Star"),
-	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-Star") }, NULL},
+	DMI_MATCH(DMI_BIOS_VENDOR, "Micro-Star")}, NULL},
+	{
+	ec_flag_msi, "MSI hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star")}, NULL},
+	{
+	ec_flag_msi, "MSI hardware", {
+	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-Star")}, NULL},
 	{
 	ec_validate_ecdt, "ASUS hardware", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
-- 
1.6.0.6

