From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2] ACPI/EC: Enable storm prevention mechanisms.
Date: Tue, 15 Jul 2014 15:09:01 +0800
Message-ID: <d43c4857af0aef38ba62fd21f62cb69deea888f3.1405407302.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35135 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbaGOHJO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2014 03:09:14 -0400
In-Reply-To: <cover.1403060601.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch enables storm prevention mechanisms. After applying this patch,
when the command/event storms are actually detected, EC driver will be
switched from the IRQ mode to the polling mode.

If regressions are reported against storm prevention support, this patch
can be bisected and reverted before issues can be root caused.

By changing the storm threshold to 0 and stops returning from
advance_transaction() without increasing irq_count on non-error cases, we
can perform unit test for the storm prevention. The result is as follows:
  [    4.525321] ACPI : EC: ***** Command(RD_EC) started *****
  [    4.525321] ACPI : EC: ===== TASK =====
  [    4.525326] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.525327] ACPI : EC: EC_SC(W) = 0x80
  [    4.525436] ACPI : EC: ===== IRQ =====
  [    4.525442] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.525442] ACPI : EC: EC_DATA(W) = 0x23
  [    4.525448] ACPI : EC: +++++ Polling enabled +++++
  [    4.525451] ACPI : EC: EC_SC(R) = 0x02 SCI_EVT=0 BURST=0 CMD=0 IBF=1 OBF=0
# [    4.528954] ACPI : EC: ===== TASK =====
  [    4.528957] ACPI : EC: EC_SC(R) = 0x01 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=1
  [    4.528960] ACPI : EC: EC_DATA(R) = 0x2b
  [    4.528963] ACPI : EC: +++++ Polling disabled +++++
  [    4.528964] ACPI : EC: ***** Command(RD_EC) stopped *****
  [    4.528974] ACPI : EC: ===== IRQ =====
  [    4.528977] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.528980] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.528988] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.529347] ACPI : EC: ***** Command(WR_EC) started *****
  [    4.529348] ACPI : EC: ===== TASK =====
  [    4.529352] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.529353] ACPI : EC: EC_SC(W) = 0x81
* [    4.529467] ACPI : EC: ===== IRQ =====
  [    4.529473] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.529473] ACPI : EC: EC_DATA(W) = 0x04
  [    4.529479] ACPI : EC: +++++ Polling enabled +++++
  [    4.529482] ACPI : EC: EC_SC(R) = 0x02 SCI_EVT=0 BURST=0 CMD=0 IBF=1 OBF=0
  [    4.532951] ACPI : EC: ===== TASK =====
  [    4.532957] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.532957] ACPI : EC: EC_DATA(W) = 0x01
  [    4.536952] ACPI : EC: ===== TASK =====
  [    4.536957] ACPI : EC: EC_SC(R) = 0x00 SCI_EVT=0 BURST=0 CMD=0 IBF=0 OBF=0
  [    4.536964] ACPI : EC: +++++ Polling disabled +++++
  [    4.536965] ACPI : EC: ***** Command(WR_EC) stopped *****
We can see the command is advanced in the task context after enabling the
polling mode (#) and the next command can still be started from the high
performance IRQ mode (*).

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d3b1bd7..f40144e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -825,13 +825,17 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
 {
 	unsigned long flags;
 	struct acpi_ec *ec = data;
+	u32 enable = 0;
 
 	spin_lock_irqsave(&ec->lock, flags);
 	if (advance_transaction(ec))
 		wake_up(&ec->wait);
+	if (!test_bit(EC_FLAGS_EVENT_STORM, &ec->flags) &&
+	    !test_bit(EC_FLAGS_COMMAND_STORM, &ec->flags))
+		enable = ACPI_REENABLE_GPE;
 	spin_unlock_irqrestore(&ec->lock, flags);
 	ec_check_sci(ec, acpi_ec_read_status(ec));
-	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
+	return ACPI_INTERRUPT_HANDLED | enable;
 }
 
 /* --------------------------------------------------------------------------
-- 
1.7.10

