From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/19] ACPI: suspend: restore BM_RLD on resume
Date: Sat, 16 May 2009 02:02:11 -0400
Message-ID: <815ab0fd40579ad2aa42058298073503648762b9.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:33333 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbZEPGCb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:31 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00F163G2YURT@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:27 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

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
 drivers/acpi/processor_idle.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f7ca8c5..c1d59cf 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -202,15 +202,38 @@ static void acpi_state_timer_broadcast(struct acpi_processor *pr,
  * Suspend / resume control
  */
 static int acpi_idle_suspend;
+static u32 saved_bm_rld;
+
+static void acpi_idle_bm_rld_save(void)
+{
+	acpi_read_bit_register(ACPI_BITREG_BUS_MASTER_RLD, &saved_bm_rld);
+}
+static void acpi_idle_bm_rld_restore(void)
+{
+	u32 resumed_bm_rld;
+
+	acpi_read_bit_register(ACPI_BITREG_BUS_MASTER_RLD, &resumed_bm_rld);
+
+	if (resumed_bm_rld != saved_bm_rld)
+		acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, saved_bm_rld);
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
1.6.0.6

