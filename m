From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/12] ACPI: Reduce ACPI resource conflict message to
 KERN_WARNING, printk cleanup
Date: Tue, 06 Apr 2010 03:06:23 -0400
Message-ID: <1638bca898e55f1c89f18b2e5accfac8591fed61.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:53006 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138Ab0DFVcG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 17:32:06 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0H00D7A551QQ84@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 16:32:04 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Chase Douglas <chase.douglas@canonical.com>, Len Brown <len.brown@intel.com>

From: Chase Douglas <chase.douglas@canonical.com>

By default, ACPI resource conflict messages are logged at level
KERN_ERR. This is a rather high level for a message that is more a
warning than an indication of a real kernel error. Also, KERN_ERR level
messages can appear over some boot splash screens, and this message is
not serious enough to warrant such treatment. Thus, the log level has
been reduced to KERN_WARNING.

[lenb changed to KERN_WARNING rather than all the way to KERN_INFO]

Also, cleanup message to use %pR resource printing format.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 8e6d866..6e49f62 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1151,16 +1151,10 @@ int acpi_check_resource_conflict(const struct resource *res)
 
 	if (clash) {
 		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
-			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
-			       " conflicts with ACPI region %s"
-			       " [0x%llx-0x%llx]\n",
-			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
-			       ? KERN_WARNING : KERN_ERR,
-			       ioport ? "I/O" : "Memory", res->name,
-			       (long long) res->start, (long long) res->end,
-			       res_list_elem->name,
-			       (long long) res_list_elem->start,
-			       (long long) res_list_elem->end);
+			printk(KERN_WARNING "ACPI: resource %s %pR"
+			       " conflicts with ACPI region %s %pR\n",
+			       res->name, res, res_list_elem->name,
+			       res_list_elem);
 			if (acpi_enforce_resources == ENFORCE_RESOURCES_LAX)
 				printk(KERN_NOTICE "ACPI: This conflict may"
 				       " cause random problems and system"
-- 
1.6.0.6

