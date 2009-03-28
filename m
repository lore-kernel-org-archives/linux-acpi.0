From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/98] ACPICA: For PM1B registers,
 do not shift value read or written
Date: Sat, 28 Mar 2009 00:31:00 -0400
Message-ID: <aefc7f9a0220a40beff9b6b3b320cbeae128d0e3.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:27050 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbZC1Eci (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:38 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700LZU8MCL66D@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:37 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The PM1B registers are mirrors of the PM1A registers with
different bits actually implemented. From the ACPI specification:
"Although the bits can be split between the two register blocks
(each register block has a unique pointer within the FADT), the bit
positions are maintained. The register block with unimplemented
bits (that is, those implemented in the other register block)
always returns zeros, and writes have no side effects"

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwregs.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 9c81621..5a64e57 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -372,9 +372,17 @@ acpi_hw_read_multiple(u32 *value,
 		}
 	}
 
-	/* Shift the B bits above the A bits */
-
-	*value = value_a | (value_b << register_a->bit_width);
+	/*
+	 * OR the two return values together. No shifting or masking is necessary,
+	 * because of how the PM1 registers are defined in the ACPI specification:
+	 *
+	 * "Although the bits can be split between the two register blocks (each
+	 * register block has a unique pointer within the FADT), the bit positions
+	 * are maintained. The register block with unimplemented bits (that is,
+	 * those implemented in the other register block) always returns zeros,
+	 * and writes have no side effects"
+	 */
+	*value = (value_a | value_b);
 	return (AE_OK);
 }
 
@@ -406,13 +414,20 @@ acpi_hw_write_multiple(u32 value,
 		return (status);
 	}
 
-	/* Second register is optional */
-
+	/*
+	 * Second register is optional
+	 *
+	 * No bit shifting or clearing is necessary, because of how the PM1
+	 * registers are defined in the ACPI specification:
+	 *
+	 * "Although the bits can be split between the two register blocks (each
+	 * register block has a unique pointer within the FADT), the bit positions
+	 * are maintained. The register block with unimplemented bits (that is,
+	 * those implemented in the other register block) always returns zeros,
+	 * and writes have no side effects"
+	 */
 	if (register_b->address) {
-
-		/* Normalize the B bits before write */
-
-		status = acpi_write(value >> register_a->bit_width, register_b);
+		status = acpi_write(value, register_b);
 	}
 
 	return (status);
-- 
1.6.0.6

