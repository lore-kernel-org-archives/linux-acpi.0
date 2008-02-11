From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: 2.6.25-rc1 regression - suspend to ram
Date: Mon, 11 Feb 2008 15:22:13 -0800
Message-ID: <20080211232213.GB8206@linux-os.sc.intel.com>
References: <20080211225811.GB4343@ics.muni.cz> <200802120010.55021.Rafal.Wysocki@fuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18631 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbYBKXWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 18:22:14 -0500
Content-Disposition: inline
In-Reply-To: <200802120010.55021.Rafal.Wysocki@fuw.edu.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, venkatesh.pallipadi@intel.com

On Tue, Feb 12, 2008 at 12:10:54AM +0100, R. J. Wysocki wrote:
> On Monday, 11 of February 2008, Lukas Hejtmanek wrote:
> > Hello,
> 
> Hi,
>  
> > 2.6.25-rc1 takes really long time till it suspends (about 30-40secs, used to
> > be about 5 secs at all) and it is resuming about few minutes.  While resuming,
> > capslock toggles the capslock led but with few secs delay.
> > 
> > 2.6.24-git15 was OK. 2.6.24 is OK.
> > 
> > I have Lenovo ThinkPad T61.
> 
> If you have CONFIG_CPU_IDLE set, please try to boot with idle=poll and see if
> that helps.
> 

Just sent this patch to fix a regression in acpi processor_idle.c on another
thread. Can you try the patch below and check whether that helps.

Thanks,
Venki


Earlier patch (bc71bec91f9875ef825d12104acf3bf4ca215fa4) broke
suspend resume on many laptops. The problem was reported by
Carlos R. Mafra and Calvin Walton, who bisected the issue to above patch.

The problem was because, C2 and C3 code were calling acpi_idle_enter_c1
directly, with C2 or C3 as state parameter, while suspend/resume was in
progress. The patch bc71bec started making use of that state information,
assuming that it would always be referring to C1 state. This caused the
problem with suspend-resume as we ended up using C2/C3 state indirectly.

Fix this by adding acpi_idle_suspend check in enter_c1.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.25-rc1/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.25-rc1.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.25-rc1/drivers/acpi/processor_idle.c
@@ -1420,6 +1420,14 @@ static int acpi_idle_enter_c1(struct cpu
 		return 0;
 
 	local_irq_disable();
+
+	/* Do not access any ACPI IO ports in suspend path */
+	if (acpi_idle_suspend) {
+		acpi_safe_halt();
+		local_irq_enable();
+		return 0;
+	}
+
 	if (pr->flags.bm_check)
 		acpi_idle_update_bm_rld(pr, cx);
 
