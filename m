From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 21:00:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730190041.GH7567@atrey.karlin.mff.cuni.cz>
References: <20020730184442.GE7567@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0207301148350.22697-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207301148350.22697-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
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

> > I believe we should ease the pain of driver maintainers by
> > guaranteeing:
> > 
> > when driver_suspend() / driver_resume() is called
> > 
> > 1) userspace is stopped.
> 
> I thought that was a given ;)

Benjamin Herrenschmidt was arguing for doing driver_suspend() while
userspace is still running. If you assumed stopped userspace, you
don't have to add semaphore into device read() etc...

> > 2) we are running with just one active CPU.
> 
> Sure. We can tie that into subsystem notification, like this:
> 
> - The level at which we want to stop requests appears to be at the device 
>   class level. 
> 
> - Device classes are coming RSN. 
> 
> - CPUs belong to a device class.
> 
> - We can integrate PM notication into device classes.
> 
> - The CPU device class can shut off all APs (application processors [silly 
>   Intel term]).

I believe shutting down CPUs should be done outside device_suspend()
so all device_suspends() run on just one CPU...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
