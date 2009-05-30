From: Len Brown <lenb@kernel.org>
Subject: [PATCH 57/65] ACPI: Disable ARB_DISABLE on platforms where it is not
 needed
Date: Fri, 29 May 2009 21:42:35 -0400
Message-ID: <ee1ca48fae7e575d5e399d4fdcfe0afc1212a64c.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50006 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573AbZE3BnR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:17 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00HIXORR01B2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:04 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>

ARB_DISABLE is a NOP on all of the recent Intel platforms.

For such platforms, reduce contention on c3_lock
by skipping the fake ARB_DISABLE.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |   16 +++++++++++++---
 drivers/acpi/processor_idle.c |    7 +++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index bbbe4bb..8c44c23 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -34,12 +34,22 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 		flags->bm_check = 1;
 	else if (c->x86_vendor == X86_VENDOR_INTEL) {
 		/*
-		 * Today all CPUs that support C3 share cache.
-		 * TBD: This needs to look at cache shared map, once
-		 * multi-core detection patch makes to the base.
+		 * Today all MP CPUs that support C3 share cache.
+		 * And caches should not be flushed by software while
+		 * entering C3 type state.
 		 */
 		flags->bm_check = 1;
 	}
+
+	/*
+	 * On all recent Intel platforms, ARB_DISABLE is a nop.
+	 * So, set bm_control to zero to indicate that ARB_DISABLE
+	 * is not required while entering C3 type state on
+	 * P4, Core and beyond CPUs
+	 */
+	if (c->x86_vendor == X86_VENDOR_INTEL &&
+	    (c->x86 > 0x6 || (c->x86 == 6 && c->x86_model >= 14)))
+			flags->bm_control = 0;
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 72069ba..4840c79 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -512,7 +512,8 @@ static void acpi_processor_power_verify_c2(struct acpi_processor_cx *cx)
 static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 					   struct acpi_processor_cx *cx)
 {
-	static int bm_check_flag;
+	static int bm_check_flag = -1;
+	static int bm_control_flag = -1;
 
 
 	if (!cx->address)
@@ -542,12 +543,14 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	}
 
 	/* All the logic here assumes flags.bm_check is same across all CPUs */
-	if (!bm_check_flag) {
+	if (bm_check_flag == -1) {
 		/* Determine whether bm_check is needed based on CPU  */
 		acpi_processor_power_init_bm_check(&(pr->flags), pr->id);
 		bm_check_flag = pr->flags.bm_check;
+		bm_control_flag = pr->flags.bm_control;
 	} else {
 		pr->flags.bm_check = bm_check_flag;
+		pr->flags.bm_control = bm_control_flag;
 	}
 
 	if (pr->flags.bm_check) {
-- 
1.6.0.6

