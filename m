From: Andi Kleen <andi@firstfloor.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Mon, 30 Jun 2008 11:24:41 +0200
Message-ID: <4868A659.2080308@firstfloor.org>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <20080629200210.GB31633@elte.hu> <Pine.LNX.4.55.0806292104560.22548@cliff.in.clinika.pl> <200806300106.38414.rjw@sisk.pl> <Pine.LNX.4.55.0806300205180.22548@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0806300205180.22548@cliff.in.clinika.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi-suse@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org


>  That is certainly true for standard hardware.  We have to take
> responsibility for own bugs, sure.  I cannot readily understand why you
> apparently try to imply hardware vendors do not.

Sorry Maciej, you're totally off base on that. On consumer hardware
vendors very rarely fix anything after release of the machine
and in general users expect Linux to work around any BIOS or
hardware bugs that happen (especially if it's a regression and worked
before)

So you either need to provide a workaround for the problem or your
patches should be reverted.

-Andi
