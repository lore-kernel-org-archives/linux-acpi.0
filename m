From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 11:47:46 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207301136050.22697-100000@cherise.pdx.osdl.net>
References: <20020730182921.GD7567@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020730182921.GD7567-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
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


> > Well, you do have to deal with drivers. Users programs is not enough,
> > drivers can be kicked by things going on in the kernel as well.
> 
> Well, so that "thing" that could kick it has to be found and made
> suspend-aware. Better than touching 1000 drivers.

Ok, so the real prize is in finding exactly what the right level of 
abstraction is. I will give you that one. But in doing so, it is not a 
decision of "Touching Every Driver" vs. "Not Touching Any Drivers".

Drivers must be modified. 

Notifying subsystems of a suspend/resume transition is a good thing to do. 
We touched on this briefly in Ottawa, though nothing was written down, as 
we were more concerned with dealing with proper driver ordering. 

Even if we stop I/O requests to the devices, we still have to save and 
restore their state, as well as put the devices in their own low power 
state. 

There are about 6 pages in the ACPI 2.0 spec that I actually trust and am
willing to repeat. Section 9.1.6: "Transitioning from the Working to the 
Sleep State" (pg. 231), it says:

...
3) OSPM places all devices into their respective Dx state.
...

If you do that, you must save and restore all device context that will be 
lost during the transition. 

You don't want to re-init the device because you can assume information 
based on what you saved away. It wastes time, and it's unnecessary. 

Suspend states are simply an illusion to the user. They want the system to
come back to _exactly_ where they left off, as fast as possible.  
Powerbooks do this incredibly well. Windows even does a decent job. 

	-pat



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
