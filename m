From: Len Brown <lenb@kernel.org>
Subject: [PATCH 79/98] ACPI: cpufreq: use new bit register access function
Date: Sat, 28 Mar 2009 00:31:54 -0400
Message-ID: <fb318cbff40964999f303d50bcf541dd9ead6780.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22683 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbZC1Edj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700GDO8O1H3SJ@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:38 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

> arch/x86/kernel/cpu/cpufreq/longhaul.c: In function 'longhaul_setstate':
> arch/x86/kernel/cpu/cpufreq/longhaul.c:308: error: implicit declaration of function 'acpi_set_register'

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Compile-tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/longhaul.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/longhaul.c b/arch/x86/kernel/cpu/cpufreq/longhaul.c
index a4cff5d..4e18d51 100644
--- a/arch/x86/kernel/cpu/cpufreq/longhaul.c
+++ b/arch/x86/kernel/cpu/cpufreq/longhaul.c
@@ -303,7 +303,7 @@ retry_loop:
 		outb(3, 0x22);
 	} else if ((pr != NULL) && pr->flags.bm_control) {
 		/* Disable bus master arbitration */
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
+		acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 1);
 	}
 	switch (longhaul_version) {
 
@@ -326,7 +326,7 @@ retry_loop:
 	case TYPE_POWERSAVER:
 		if (longhaul_flags & USE_ACPI_C3) {
 			/* Don't allow wakeup */
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
+			acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 			do_powersaver(cx->address, clock_ratio_index, dir);
 		} else {
 			do_powersaver(0, clock_ratio_index, dir);
@@ -339,7 +339,7 @@ retry_loop:
 		outb(0, 0x22);
 	} else if ((pr != NULL) && pr->flags.bm_control) {
 		/* Enable bus master arbitration */
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
+		acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
 	}
 	outb(pic2_mask,0xA1);	/* restore mask */
 	outb(pic1_mask,0x21);
-- 
1.6.0.6

