From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI :Restore the previous calculation of FSB ratio for
	mode <2
Date: Tue, 27 Nov 2007 16:20:21 +0800
Message-ID: <1196151621.3766.3.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53016 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbXK0II4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Nov 2007 03:08:56 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI :Restore the previous calculation of FSB ratio for mode <2
>From : Zhao Yakui <yakui.zhao@intel.com>

The ratio is undefined in the register of MSR_FBC_REGSITER_ID
when the model for P4 is less than 2. So the following calculation in
comment (3e4159ab35c88aef5e063ba78796b277b762a30a) is inappropriate.
   if (c->x86_model < 2)
         mult = msr_lo >> 27;

It is more appropriate that the commit is reverted 
until the proper patch in that place has been developed.

http://bugzilla.kernel.org/show_bug.cgi?id=7186

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/speedstep-lib.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.24-rc1/arch/x86/kernel/cpu/cpufreq/speedstep-lib.c
===================================================================
--- linux-2.6.24-rc1.orig/arch/x86/kernel/cpu/cpufreq/speedstep-lib.c
+++ linux-2.6.24-rc1/arch/x86/kernel/cpu/cpufreq/speedstep-lib.c
@@ -189,10 +189,7 @@ static unsigned int pentium4_get_frequen
 		printk(KERN_DEBUG "speedstep-lib: couldn't detect FSB speed. Please send an e-mail to <linux@brodo.de>\n");
 
 	/* Multiplier. */
-	if (c->x86_model < 2)
-		mult = msr_lo >> 27;
-	else
-		mult = msr_lo >> 24;
+	mult = msr_lo >> 24;
 
 	dprintk("P4 - FSB %u kHz; Multiplier %u; Speed %u kHz\n", fsb, mult, (fsb * mult));
 
