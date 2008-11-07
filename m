From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/21] ACPI: SBS: remove useless acpi_cm_sbs_init() initcall
Date: Thu, 06 Nov 2008 23:39:14 -0500
Message-ID: <5b881479af4352791e5004b74e3639f1416c5fe4.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38214 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbYKGEjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:32 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y00DPG4XUG7E1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:31 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

acpi_cm_sbs_init() doesn't do anything, so we can just remove it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/cm_sbs.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index 4441e84..80d5c88 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -105,9 +105,3 @@ void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir_param)
 	return;
 }
 EXPORT_SYMBOL(acpi_unlock_battery_dir);
-
-static int __init acpi_cm_sbs_init(void)
-{
-	return 0;
-}
-subsys_initcall(acpi_cm_sbs_init);
-- 
1.5.6.5

