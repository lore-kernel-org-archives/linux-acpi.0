From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.{29-32}.stable]  ACPI: enable C2 and Turbo-mode on Nehalem
 notebooks on A/C
Date: Tue, 26 Jan 2010 16:15:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001261554510.4493@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:59936 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab0AZVPc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2010 16:15:32 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWV009QLHPTHH20@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 26 Jan 2010 15:15:32 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

upstream in 2.6.33-rc:  5d76b6f6c17572e662f5c99c2023adae92100855

Refreshed here for 2.6.32.y, applies w/ offset back to 2.6.29.y.

Linux has always ignored ACPI BIOS C2 with exit latency > 100 usec,
and the ACPI spec is clear that is correct FADT-supplied C2.

However, the ACPI spec explicitly states that _CST-supplied C-states
have no latency limits.

So move the 100usec C2 test out of the code shared
by FADT and _CST code-paths, and into the FADT-specific path.

This bug has not been visible until Nehalem, which advertises
a CPU-C2 worst case exit latency on servers of 205usec.
That (incorrect) figure is being used by BIOS writers
on mobile Nehalem systems for the AC configuration.
Thus, Linux ignores C2 leaving just C1, which is
saves less power, and also impacts performance
by preventing the use of turbo mode.

http://bugzilla.kernel.org/show_bug.cgi?id=15064

Tested-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

Index: linux-2.6.32.y/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.32.y.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.32.y/drivers/acpi/processor_idle.c
@@ -299,6 +299,17 @@ static int acpi_processor_get_power_info
 	pr->power.states[ACPI_STATE_C2].latency = acpi_gbl_FADT.C2latency;
 	pr->power.states[ACPI_STATE_C3].latency = acpi_gbl_FADT.C3latency;
 
+	/*
+	 * FADT specified C2 latency must be less than or equal to
+	 * 100 microseconds.
+	 */
+	if (acpi_gbl_FADT.C2latency > ACPI_PROCESSOR_MAX_C2_LATENCY) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"C2 latency too large [%d]\n", acpi_gbl_FADT.C2latency));
+		/* invalidate C2 */
+		pr->power.states[ACPI_STATE_C2].address = 0;
+	}
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "lvl2[0x%08x] lvl3[0x%08x]\n",
 			  pr->power.states[ACPI_STATE_C2].address,
@@ -495,16 +506,6 @@ static void acpi_processor_power_verify_
 		return;
 
 	/*
-	 * C2 latency must be less than or equal to 100
-	 * microseconds.
-	 */
-	else if (cx->latency > ACPI_PROCESSOR_MAX_C2_LATENCY) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "latency too large [%d]\n", cx->latency));
-		return;
-	}
-
-	/*
 	 * Otherwise we've met all of our C2 requirements.
 	 * Normalize the C2 latency to expidite policy
 	 */
