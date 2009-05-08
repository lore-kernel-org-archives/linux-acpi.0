From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: suspend: restore BM_RLD on resume
Date: Thu, 07 May 2009 22:32:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905072228030.20287@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:44477 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbZEHCcQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 May 2009 22:32:16 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJB00AZW0DQOEK4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 07 May 2009 21:32:15 -0500 (CDT)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id n482WDUe031544	for
 <linux-acpi@vger.kernel.org>; Thu, 07 May 2009 22:32:14 -0400
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) with ESMTP id n482WDlC031540
	for <linux-acpi@vger.kernel.org>; Thu, 07 May 2009 22:32:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

In 2.6.29,
31878dd86b7df9a147f5e6cc6e07092b4308782b
"ACPI: remove BM_RLD access from idle entry path"
moved BM_RLD initialization to init-time from run time.

But we discovered that some BIOS do not restore BM_RLD
after suspend, causing device errors on C3 and C4
after resume.  So now the kernel restores BM_RLD.

http://bugzilla.kernel.org/show_bug.cgi?id=13032

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f7ca8c5..afa5c03 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -202,15 +202,41 @@ static void acpi_state_timer_broadcast(struct acpi_processor *pr,
  * Suspend / resume control
  */
 static int acpi_idle_suspend;
+static u32 saved_bm_rld;
+
+static void acpi_idle_bm_rld_save(void)
+{
+	acpi_read_bit_register(ACPI_BITREG_BUS_MASTER_RLD, &saved_bm_rld);
+	printk(KERN_NOTICE PREFIX "saved: BM_RLD %u\n", saved_bm_rld);
+}
+static void acpi_idle_bm_rld_restore(void)
+{
+	u32 resumed_bm_rld;
+
+	acpi_read_bit_register(ACPI_BITREG_BUS_MASTER_RLD, &resumed_bm_rld);
+	printk(KERN_NOTICE PREFIX "resumed: BM_RLD %u\n", resumed_bm_rld);
+	if (resumed_bm_rld != saved_bm_rld) {
+		printk(KERN_WARNING PREFIX "restored BM_RLD %u\n", saved_bm_rld);
+		acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, saved_bm_rld);
+	}
+}
 
 int acpi_processor_suspend(struct acpi_device * device, pm_message_t state)
 {
+	if (acpi_idle_suspend == 1)
+		return 0;
+
+	acpi_idle_bm_rld_save();
 	acpi_idle_suspend = 1;
 	return 0;
 }
 
 int acpi_processor_resume(struct acpi_device * device)
 {
+	if (acpi_idle_suspend == 0)
+		return 0;
+
+	acpi_idle_bm_rld_restore();
 	acpi_idle_suspend = 0;
 	return 0;
 }
-- 
1.6.3

