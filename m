From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 14:21:50 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207301406440.22697-100000@cherise.pdx.osdl.net>
References: <20020730200634.GA16297@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020730200634.GA16297-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Tue, 30 Jul 2002, Pavel Machek wrote:

> Hi!
> 
> > >All kernel services that can issue requests need kernel threads,
> > >right? My approach is to take kernel threads one by one and make them
> > >suspend-aware.
> > 
> > It wouldn' be bad to do that too. I just "feel" it safer and better
> > to define the driver semantics to be IO blocking. Some user
> >processes
> 
> I do not know if such feelings are worth the effort of driver authors.
> 
> Certainly, it feels safer that way. But I believe that what I
> currently have is bulletproof...

Heh. Famous last words... ;)

I think we have a good start, thanks entirely to the two of you. However, 
we won't be able to completely validate that we have all the theory right 
until we have all the working pieces at least partially in place. 

Unfortunately, I can't dedicate much time, as I'm swamped with other 
infrastructural items. But, I can offer some assistance.

I'm cloning a BK tree right now. It will be at 

	bk://ldm.bkbits.net/linux-2.5-suspend/

Send me patches, and I'll integrate them. We can use this as a test bed
for getting the process right before anything actually gets integrated.
People can clone from this tree for the purpose of testing.

I know there are issues with using BitKeeper. Because of that, I've 
created a directory on kernel.org to export patches of the BK tree. It's 
at:

	http://kernel.org/pub/linux/kernel/people/mochel/suspend/

I'll try and update the BK tree and the patches every kernel version. If 
you notice that I haven't, and it's been a couple of days, kick me. 

Enjoy. 

	-pat



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
