From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] ACPI: Disable ARB_DISABLE on platforms where it is not needed
Date: Thu, 21 May 2009 17:09:10 -0700
Message-ID: <20090522000910.GA14503@linux-os.sc.intel.com>
References: <20090521234813.GA11561@linux-os.sc.intel.com> <20090521235327.GA2064@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7700 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbZEVAJJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 20:09:09 -0400
Content-Disposition: inline
In-Reply-To: <20090521235327.GA2064@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, May 21, 2009 at 04:53:27PM -0700, Matthew Garrett wrote:
> On Thu, May 21, 2009 at 04:48:13PM -0700, Pallipadi, Venkatesh wrote:
> > +	/*
> > +	 * On all recent platforms, ARB_DISABLE is a nop.
> > +	 * So, set bm_control to zero to indicate that ARB_DISABLE
> > +	 * is not required while entering C3 type state on
> > +	 * P4, Core and beyond CPUs
> > +	 */
> > +	if (c->x86_vendor == X86_VENDOR_INTEL &&
> 
> To me, "All recent platforms" is not quite the same as "All recent Intel 
> platforms" :) Is this true of any other vendors? If not, the comment 
> could be clarified a little.

Updated comment to say "all recent Intel platforms".

Thanks,
Venki

ARB_DISABLE is a nop on all of the recent Intel platforms. Disable
ARB_DISABLE and attached c3_lock on C3 entry exit for such platforms.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |   16 +++++++++++++---
 drivers/acpi/processor_idle.c |    7 +++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index bbbe4bb..763637d 100644
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

