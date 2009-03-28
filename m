From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/98] ACPICA: Condense some protected ports
Date: Sat, 28 Mar 2009 00:31:24 -0400
Message-ID: <ee6a0fbd0ccb7736a3be56630e3ad65ceddfb5bd.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8294 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbZC1EdU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:20 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH70032O8MQXGOL@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:51 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

One entry in the protected port table eliminated. Added extra
comments to describe each table entry.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwvalid.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index e0b562f..105b818 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -63,24 +63,42 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width);
  *
  * This provides ACPICA with the desired port protections and
  * Microsoft compatibility.
+ *
+ * Description of port entries:
+ *  DMA:   DMA controller
+ *  PIC0:  Programmable Interrupt Controller (8259_a)
+ *  PIT1:  System Timer 1
+ *  PIT2:  System Timer 2 failsafe
+ *  RTC:   Real-time clock
+ *  CMOS:  Extended CMOS
+ *  DMA1:  DMA 1 page registers
+ *  DMA1L: DMA 1 Ch 0 low page
+ *  DMA2:  DMA 2 page registers
+ *  DMA2L: DMA 2 low page refresh
+ *  ARBC:  Arbitration control
+ *  SETUP: Reserved system board setup
+ *  POS:   POS channel select
+ *  PIC1:  Cascaded PIC
+ *  IDMA:  ISA DMA
+ *  ELCR:  PIC edge/level registers
+ *  PCI:   PCI configuration space
  */
 static const struct acpi_port_info acpi_protected_ports[] = {
-	{"DMA1", 0x0000, 0x000F, ACPI_OSI_WIN_XP},
+	{"DMA", 0x0000, 0x000F, ACPI_OSI_WIN_XP},
 	{"PIC0", 0x0020, 0x0021, ACPI_ALWAYS_ILLEGAL},
 	{"PIT1", 0x0040, 0x0043, ACPI_OSI_WIN_XP},
 	{"PIT2", 0x0048, 0x004B, ACPI_OSI_WIN_XP},
 	{"RTC", 0x0070, 0x0071, ACPI_OSI_WIN_XP},
 	{"CMOS", 0x0074, 0x0076, ACPI_OSI_WIN_XP},
 	{"DMA1", 0x0081, 0x0083, ACPI_OSI_WIN_XP},
-	{"DMA1", 0x0087, 0x0087, ACPI_OSI_WIN_XP},
-	{"DMA2", 0x0089, 0x0089, ACPI_OSI_WIN_XP},
-	{"DMA2", 0x008A, 0x008B, ACPI_OSI_WIN_XP},
-	{"DMA2", 0x008F, 0x008F, ACPI_OSI_WIN_XP},
-	{"Arb", 0x0090, 0x0091, ACPI_OSI_WIN_XP},
-	{"Setup", 0x0093, 0x0094, ACPI_OSI_WIN_XP},
+	{"DMA1L", 0x0087, 0x0087, ACPI_OSI_WIN_XP},
+	{"DMA2", 0x0089, 0x008B, ACPI_OSI_WIN_XP},
+	{"DMA2L", 0x008F, 0x008F, ACPI_OSI_WIN_XP},
+	{"ARBC", 0x0090, 0x0091, ACPI_OSI_WIN_XP},
+	{"SETUP", 0x0093, 0x0094, ACPI_OSI_WIN_XP},
 	{"POS", 0x0096, 0x0097, ACPI_OSI_WIN_XP},
 	{"PIC1", 0x00A0, 0x00A1, ACPI_ALWAYS_ILLEGAL},
-	{"DMA", 0x00C0, 0x00DF, ACPI_OSI_WIN_XP},
+	{"IDMA", 0x00C0, 0x00DF, ACPI_OSI_WIN_XP},
 	{"ELCR", 0x04D0, 0x04D1, ACPI_ALWAYS_ILLEGAL},
 	{"PCI", 0x0CF8, 0x0D00, ACPI_OSI_WIN_XP}
 };
-- 
1.6.0.6

