From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Wed, 2 Jul 2008 02:48:11 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0807020223140.6284@cliff.in.clinika.pl>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806300106.38414.rjw@sisk.pl>
 <Pine.LNX.4.55.0806300205180.22548@cliff.in.clinika.pl> <200806301241.57781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200806301241.57781.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi-suse@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 30 Jun 2008, Rafael J. Wysocki wrote:

> Well, there are lots of pieces of hardware that are not up to the
> specifications, more or less, and I don't think that's a good enough reason
> for us to refuse to support them.  The same applies to BIOSes IMO.

 Refusing to support broken hardware would provide some incentive to
manufacturers to improve it, because people would rather not buy
unsupported pieces of junk.  I realise that may be impractical though --
we would get the blame anyway, because "it runs the other OS just fine."  

 I think we may legitimately request something in return for our effort
though, for example at least minimal support from hardware manufacturers.  
It is not that we would waste a lot of their time, because in general
anything we do not filter out must be really tough.

> Of course, the _default_ should be to follow the spec, but if that doesn't work
> on given hardware/BIOS combination and we know what to do to handle it, we
> should just handle it instead of asking users to fix their BIOSes.

 I think we should insist on getting issues reported back to the 
manufacturer.  We may implement workarounds independently and leave it up 
to the users whether they want to do a BIOS upgrade or not.

> I have seen enough failed BIOS upgrades to be very cautious about such things.
> Certainly, I wouldn't have seriously asked anyone to upgrade the BIOS in a
> notebook, because if that had failed, the user would have end up with a piece
> of electronic junk.

 That's a valid point, although making the point of quality yet clearer --
being critical enough, I would expect it to have been thorougly tested by
the manufacturer.  Also solutions like protected Flash areas have been
available for many years now, which means a machine should be operative
enough for recovery to be doable if an upgrade fails.  So perhaps the very
first thing to do after a new purchase should be doing a BIOS update, so
that you can claim your warranty if something goes wrong.

 Technically upgrading a laptop should be safer as bearing an on-board UPS
they are protected from power failures, which may be problematic for some
users of other equipment.

  Maciej
