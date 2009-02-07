From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/30] ACPI: remove locking from PM1x_STS register reads
Date: Sat, 07 Feb 2009 01:41:23 -0500
Message-ID: <a2b7b01c072435b7832ab392167545a1b38cabc3.1233988825.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:22488 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbZBGGl4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:56 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00KGTNXVK442@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:55 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

PM1a_STS and PM1b_STS are twins that get OR'd together
on reads, and all writes are repeated to both.

The fields in PM1x_STS are single bits only,
there are no multi-bit fields.

So it is not necessary to lock PM1x_STS reads against
writes because it is impossible to read an intermediate
value of a single bit.  It will either be 0 or 1,
even if a write is in progress during the read.
Reads are asynchronous to writes no matter if a lock
is used or not.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 66a9d81..ae00108 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -447,7 +447,7 @@ static void acpi_processor_idle(void)
 
 		pr->power.bm_activity <<= diff;
 
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+		acpi_get_register_unlocked(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
 		if (bm_status) {
 			pr->power.bm_activity |= 0x1;
 			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
@@ -1383,7 +1383,7 @@ static int acpi_idle_bm_check(void)
 {
 	u32 bm_status = 0;
 
-	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+	acpi_get_register_unlocked(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
 	if (bm_status)
 		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
 	/*
-- 
1.5.6.6

