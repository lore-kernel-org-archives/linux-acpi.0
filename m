From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 20:54:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730185414.GG7567@atrey.karlin.mff.cuni.cz>
References: <20020730182921.GD7567@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0207301136050.22697-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207301136050.22697-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
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

> > > Well, you do have to deal with drivers. Users programs is not enough,
> > > drivers can be kicked by things going on in the kernel as well.
> > 
> > Well, so that "thing" that could kick it has to be found and made
> > suspend-aware. Better than touching 1000 drivers.
> 
> Ok, so the real prize is in finding exactly what the right level of 
> abstraction is. I will give you that one. But in doing so, it is not a 
> decision of "Touching Every Driver" vs. "Not Touching Any Drivers".

Agreed.

> Drivers must be modified. 

Yep.

> Even if we stop I/O requests to the devices, we still have to save and 
> restore their state, as well as put the devices in their own low power 
> state. 

We have to save/restore their state.

We do not need to put them in low power states for swsusp (we are
powered), but we should do that for S3.

> You don't want to re-init the device because you can assume information 
> based on what you saved away. It wastes time, and it's unnecessary. 

More time consuming etc but simpler in some cases ;-).

[ne2000 driver is so used to working with crap that you can live
without suspend/resume support. You go S3. You return. ne2000 driver
tries to communicate with the card, and it appears dead, so it kicks
it back alive after timeout. Hack hack ;-)].

> Suspend states are simply an illusion to the user. They want the system to
> come back to _exactly_ where they left off, as fast as possible.  
> Powerbooks do this incredibly well. Windows even does a decent job. 

Yes but it is not actually important if we can enter S3 in 100 msec or
120 msec, right? Same goes for resume. We want to avoid touching hot
paths.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
