From: Thomas Renninger <trenn@suse.de>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Tue, 26 Feb 2008 17:26:45 +0100
Message-ID: <1204043205.4995.228.camel@queen.suse.de>
References: <1203471860.3358.177.camel@linux-2bdv.site>
	 <20080220173248.GA22709@srcf.ucam.org>
	 <20080220182339.GC17648@khazad-dum.debian.net>
	 <20080220184954.GB23679@srcf.ucam.org>
	 <20080221031324.GB6344@khazad-dum.debian.net>
	 <20080221091532.GA3091@srcf.ucam.org>  <20080221135132.GE14614@mit.edu>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35946 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbYBZQ0r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 11:26:47 -0500
In-Reply-To: <20080221135132.GE14614@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thu, 2008-02-21 at 08:51 -0500, Theodore Tso wrote:
> On Thu, Feb 21, 2008 at 09:15:32AM +0000, Matthew Garrett wrote:
> > 
> > Offering OSI(Linux) makes a statement about our implementation - we're 
> > telling the firmware that it behaves in a certain way. That lets vendors 
> > start depending on that behaviour, and if that behaviour turns out to be 
> > different to Windows then we never get to fix that behaviour. Fine for 
> > vendors that have special-cased their firmware, bad for the vast 
> > majority of systems.
> 
> Exactly, that's the problem.  Suppose we put in an OSI(Linux), and
> Lenovo, thanks to the fact that they are working with Novell, puts in
> a special case hack just for whatever version of SLES they happen to
> be testing with.  Well, great.  Now suppose that three other laptops
> from different manufacturers (say, Sony, Fujitsu, and Asus) do things
> differently, the Windows way, and someone posts a patch to the ACPI
> drivers (and it might not and probably won't be the Thinkpad specific
> thinkpad_acpi.c file) which changes things so that it works for Sony,
> Fujitsu, et. al. --- and in the process, it breaks things for Lenovo,
> because the Lenovo is doing something special based on OSI(Linux)
> thanks to their special collaboration with Thomas Renniger and Novell.
> Oops.  Now we have a mess, and we have to start having special
> DMI-based blacklists and whitelists, and life generally sucks.
I doubt it. With your approach you end in a dmi black/whitelisting mess
and you violate the behavior BIOS developers seem to expect (that is
what we want to be compatible with, what BIOS developers write down,
right?).

Return true for OSI("Linux") for some T61 is wrong. It depends on the
BIOS (latest X61 might not have it yet, but will later, etc.), trying to
identify it is pretty much impossible (you can grep for "Linux" through
the memory where the table lies, yet more ugly than the current
"solution".
Probably the same for Dell and as said others might fill this with BIOS
updates.
The interface has been added and now it has to be kept.
And even if it has not been added, vendors are using it, as this has
been identified to be be more important than specs: Provide it.

> It would be much better if we define feature-specific OSI() strings
> that have well defined meanings for each place where Lenovo has to do
> something different than What Happens With Windows
Yes. But at the time the BIOS fix should be released, these
feature-specific OSI strings do not exist. And it takes at least a
kernel iteration until it comes into mainline kernel for sure. So you
want the vendor to wait half a year before the Linux BIOS hot-fix is
released?
They need if(OSI("Linux"). As soon as it is clear what the
fix/workaround (or even missing feature) is about, it can be discussed
to include an _OSI("feature") string to the kernel.
Vendors who care for linux would probably have no problem with updating
their fix in a later BIOS revision then(still embedded in linux only, to
not cause Windows regressions of course):
if(_OSI("Linux"){
   Store(0x1, fix1)
   Store(0x1, fix2)
}
to something like:
if(_OSI("Linux"){
   Store(0x1, fix1)
   if(_OSI("!Feature XY")
       Store(0x1, fix2)
}


>  --- especially for
> stuff which is generic, since all laptop manufactuers need to
> interoperate with whatever cr*p Windows ship.  
As said you cannot interoperate with all crap all Windows Versions ship.
They fix up things... and we are trying to stay compatible with the
bugs, this does not make any sense.
> At the end of the day,
> since Intel was originally too lazy to ship an ACPI conformance test
> suite, like it or not, Windows *has* become the APCI conformance test
> suite, and all laptop manufacturers (at least for today) must bow to
> the might and power which is the market share of Microsoft.
Wrong.
Currently there is a move to also ship laptops with Linux. It's not only
Lenovo, but also Dell and others.
These vendors can (if not cut down by OS too much) support their
machines. They are supporting driver development and they must make sure
that every single bit of the HW is running fine with Linux.
E.g. Lenovo released some native SATA and USB fixes for their BIOS
recently, you probably do not want to miss them.
If people have some spare time, they can go back some BIOS versions
before and fix up the drivers. But do not let vendors who care about
Linux force to
a) Duplicate bugs they already have to do for Windows (disable
   HW capability for a SP or whatever they add)
b) Not be able to provide BIOS fix-ups (e.g. if ASL code is needed) for
   Linux

You do not get machines fixed by that if the vendor does not care about
Linux (with the next _OSI("Windows 200X") hack he adds, things will
break anyway as these guys do not do a single test on Linux).

You want customers who buy a Linux machine (and I also would insist that
it is running just fine on Linux then), to open bug reports on
bugzilla.kernel.org so that they/you are able to debug problems that
"might" happen on machines who's vendors don't give a Cent for Linux?

No that is not working, it's working like that:
As soon as the vendors who are currently start to sell Linux with their
laptops are only gaining say 2% market share because of some more sold
machines to Linux users. Then the others will follow.
They are forced to use HW which uses open drivers and they have to make
sure their BIOS is half way compatible with Linux (if not they have to
modify it -> _OSI("Linux") needed for BIOS updates!).

This makes much more sense and is more realistic than trying to be
compatible with Windows or even all Windows Versions and it should get
supported as much as possible.

   Thomas

