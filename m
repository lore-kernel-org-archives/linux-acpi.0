From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI: remove locking from PM1x_STS register reads
Date: Tue, 03 Feb 2009 23:02:00 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902032301170.5607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:36253 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbZBDECR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 23:02:17 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KEI0075SWJDYVH0@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 03 Feb 2009 22:02:01 -0600 (CST)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id n14420e5011738	for
 <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2009 23:02:00 -0500
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) with ESMTP id n14420XH011734
	for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2009 23:02:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

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
1.6.1.2.319.gbd9e

