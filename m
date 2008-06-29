From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Sun, 29 Jun 2008 22:02:10 +0200
Message-ID: <20080629200210.GB31633@elte.hu>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806291600.29059.rjw@sisk.pl> <Pine.LNX.4.55.0806291952590.22548@cliff.in.clinika.pl> <200806292123.16237.rjw@sisk.pl> <Pine.LNX.4.55.0806292023320.22548@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:41551 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870AbYF2UCw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Jun 2008 16:02:52 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806292023320.22548@cliff.in.clinika.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi-suse@firstfloor.org>


* Maciej W. Rozycki <macro@linux-mips.org> wrote:

>  You may argue this is a regression, but this is simply the cost paid 
> for progress -- the kernel stays within the spec as defined both by 
> ACPI and MPS, we have just started using a different configuration now 
> and an interrupt source override provided by the manufacturer 
> explicitly states INTIN2 is good to use.  In a sense you were simply 
> lucky previously the kernel was bad enough with the way it configured 
> the timer through the I/O APIC it failed completely avoiding the bug 
> in your firmware.  Now the bug has got uncovered.

well as long as we eliminate the bad effects around via DMI exceptions 
nobody will feel the need to argue whether it's a regression ;-) [this 
problem could be argued to be a regression, even if it's caused by prior 
luck/stupidity of Linux. We have to live with the effects of our 
mistakes.]

	Ingo
