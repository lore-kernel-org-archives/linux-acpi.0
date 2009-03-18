From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: linux-next: acpi tree build failure
Date: Wed, 18 Mar 2009 09:09:01 +0800
Message-ID: <1237338541.29562.5.camel@minggr>
References: <20090318115713.bafedc37.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32489 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755969AbZCRBSe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Mar 2009 21:18:34 -0400
In-Reply-To: <20090318115713.bafedc37.sfr@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Len Brown <lenb@kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-03-18 at 08:57 +0800, Stephen Rothwell wrote:
> Hi Len,
> 
> Today's (and several previous day's) linux-next build (i386 allmodconfig)
> failed like this:
> 
> arch/x86/kernel/cpu/cpufreq/longhaul.c: In function 'longhaul_setstate':
> arch/x86/kernel/cpu/cpufreq/longhaul.c:308: error: implicit declaration of function 'acpi_set_register'

Please try below patch,


    ACPI: cpufreq: use new bit register access function
    
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
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


> 
> (http://kisskb.ellerman.id.au/kisskb/target/421/)
> 
> Caused by commit e2f34512879026beb26827c14b1d1e67c07f2858 ("ACPICA:
> Rename ACPI bit register access functions").
> 

