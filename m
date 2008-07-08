From: Pavel Machek <pavel@suse.cz>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Tue, 8 Jul 2008 14:48:20 +0200
Message-ID: <20080708124820.GB16313@elf.ucw.cz>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806201353.59083.rjw@sisk.pl> <20080620115714.GC8637@srcf.ucam.org> <200806201422.12659.rjw@sisk.pl> <20080624091516.GA5642@ucw.cz> <Pine.LNX.4.55.0806270249490.31618@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806270249490.31618@cliff.in.clinika.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri 2008-06-27 02:53:09, Maciej W. Rozycki wrote:
> On Tue, 24 Jun 2008, Pavel Machek wrote:
> 
> > > $ cat /proc/acpi/thermal_zone/TZ*/trip_points
> > > 
> > > in the failing case:
> > > 
> > > critical (S5):           105 C
> > > passive:                 16 C: tc1=1 tc2=2 tsp=100 devices=C000 C001 
> > > active[0]:               16 C: devices=C34F 
> > > active[1]:               16 C: devices=C350 
> > > active[2]:               16 C: devices=C351 
> > > active[3]:               16 C: devices=C352 
> > > critical (S5):           100 C
> > > passive:                 16 C: tc1=1 tc2=2 tsp=300 devices=C000 C001 
> > > critical (S5):           100 C
> > > passive:                 16 C: tc1=1 tc2=2 tsp=300 devices=C000 C001 
> > 
> > Can we call the ACPI BIOS to be terminally broken at this point?
> 
>  Do we have any point of contact at HP and/or ATI/AMD?  I suppose getting 
> hands on a SB400 datasheet could be tricky, but someone may be able to 
> answer questions about the interrupt routing between the 8254, the 8259A 
> and the I/O APIC for this chip and/or fix the DSDT.

Yes, we do have AMD contacts. Contact me privately if that's still
relevant.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
