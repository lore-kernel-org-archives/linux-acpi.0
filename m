From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Sun, 29 Jun 2008 20:05:42 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0806291952590.22548@cliff.in.clinika.pl>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806262152.02099.rjw@sisk.pl>
 <Pine.LNX.4.55.0806270102051.31618@cliff.in.clinika.pl> <200806291600.29059.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200806291600.29059.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 29 Jun 2008, Rafael J. Wysocki wrote:

> >  I believe I removed all the occurences.  I am waiting for a proposal of a
> > quirk based on the DSDT ID -- my time is a bit too limited to study the
> > internals of our ACPI code at the moment; sorry about that.  I will
> > complement it with a change to remove IRQ0 from I/O APIC tables as
> > promised then; this piece of code I am quite familiar with.
> 
> Well, why don't we use the DMI identification as suggested by Matthew?

 Because it checks the wrong property.

> I think we can safely assume that all of these boxes are broken for now and we
> can use a more fine grained identification in the future, if necessary.

 It is the reverse -- checking the DSDT ID is coarser, matching all the
systems that use the broken firmware.  With DMI we may face both false
positives and false negatives which imply further maintenance actions.  
Please note as proved over the years understanding of these issues seems
to be problematic for people, so the result may be another round of
discussions reinventing the wheel in a couple of years' time or so.

 That's my opinion only though -- if it was to hinder the progress, then I
am not going to persist.

 Have you tried to report the issue through the usual manufacturer's
support channels, BTW?  They may not even be aware of the existence of the
bug.  Of course they may dismiss it anyway, but at least they will have a
record of it somewhere.

  Maciej
