From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Sun, 29 Jun 2008 21:14:35 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0806292104560.22548@cliff.in.clinika.pl>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806291600.29059.rjw@sisk.pl>
 <Pine.LNX.4.55.0806291952590.22548@cliff.in.clinika.pl> <200806292123.16237.rjw@sisk.pl>
 <Pine.LNX.4.55.0806292023320.22548@cliff.in.clinika.pl> <20080629200210.GB31633@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080629200210.GB31633@elte.hu>
Sender: linux-next-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi-suse@firstfloor.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 29 Jun 2008, Ingo Molnar wrote:

> >  You may argue this is a regression, but this is simply the cost paid 
> > for progress -- the kernel stays within the spec as defined both by 
> > ACPI and MPS, we have just started using a different configuration now 
> > and an interrupt source override provided by the manufacturer 
> > explicitly states INTIN2 is good to use.  In a sense you were simply 
> > lucky previously the kernel was bad enough with the way it configured 
> > the timer through the I/O APIC it failed completely avoiding the bug 
> > in your firmware.  Now the bug has got uncovered.
> 
> well as long as we eliminate the bad effects around via DMI exceptions 
> nobody will feel the need to argue whether it's a regression ;-) [this 
> problem could be argued to be a regression, even if it's caused by prior 
> luck/stupidity of Linux. We have to live with the effects of our 
> mistakes.]

 Of course -- this is the only reason I can be bothered with the issue in
the first place.  Otherwise, I would have said: 'Get the manufacturer to
fix it, use "noapic" or live with a local patch.'

 This is actually how I have kept one of my old MPS SMP systems up for
years now -- it has a broken MP table which prevents interrupts from
working when too many PCI option cards are present, so I have prepared a
patch for patching the table manually.  I proposed it once, which you may
recall, but it was rejected on the grounds of the syntax being too tough
to comprehend to a poor average user being.  I am sure more systems would
benefit as MP table breakages used to be quite common.

 Here the simple workaround was "noapic" too, so everyone else could be
happy and I have been happy to keep the patch and use the capabilities of
the piece of hardware properly despite its broken firmware.

  Maciej
