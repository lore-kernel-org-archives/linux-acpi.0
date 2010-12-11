From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/15] ACPI: EC: Add another dmi match entry for MSI hardware
Date: Sat, 11 Dec 2010 02:06:30 -0500
Message-ID: <a5dc4f898c2a0f66e2cefada6c687db82ba2fcbc.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:52844 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0LKHG7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:06:59 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD9006JY53L3RH2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:06:58 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, stable@kernel.org, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

http://bugzilla.kernel.org/show_bug.cgi?id=15418

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
cc: stable@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 372ff80..302b31e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -934,6 +934,9 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
 	ec_flag_msi, "MSI hardware", {
 	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-Star")}, NULL},
 	{
+	ec_flag_msi, "MSI hardware", {
+	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-STAR")}, NULL},
+	{
 	ec_validate_ecdt, "ASUS hardware", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
 	{},
-- 
1.7.3.3.480.g2f76a

