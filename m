From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Wed, 31 Jul 2002 23:44:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020731214405.GA10438@atrey.karlin.mff.cuni.cz>
References: <20020730200634.GA16297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0207301406440.22697-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207301406440.22697-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > >All kernel services that can issue requests need kernel threads,
> > > >right? My approach is to take kernel threads one by one and make them
> > > >suspend-aware.
> > > 
> > > It wouldn' be bad to do that too. I just "feel" it safer and better
> > > to define the driver semantics to be IO blocking. Some user
> > >processes
> > 
> > I do not know if such feelings are worth the effort of driver authors.
> > 
> > Certainly, it feels safer that way. But I believe that what I
> > currently have is bulletproof...
> 
> Heh. Famous last words... ;)

Yep.

> I think we have a good start, thanks entirely to the two of you. However, 
> we won't be able to completely validate that we have all the theory right 
> until we have all the working pieces at least partially in place. 
> 
> Unfortunately, I can't dedicate much time, as I'm swamped with other 
> infrastructural items. But, I can offer some assistance.
> 
> I'm cloning a BK tree right now. It will be at 
> 
> 	bk://ldm.bkbits.net/linux-2.5-suspend/
> 
> Send me patches, and I'll integrate them. We can use this as a test bed
> for getting the process right before anything actually gets integrated.
> People can clone from this tree for the purpose of testing.

Well, it *is* integrated just now. People are actually using swsusp/S3
in 2.5.X more-or-less successfully. Linus is taking swsusp patches
pretty easily, and we get more testing by working on mainline. In
short I believe there's no reason to keep suspend patches
separate. Its experimental feature, marked as experimental, and it
seems to work for people. 
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
