From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 20:25:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730182552.1477@192.168.4.1>
References: <Pine.LNX.4.44.0207301148350.22697-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0207301148350.22697-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
>> I believe we should ease the pain of driver maintainers by
>> guaranteeing:
>> 
>> when driver_suspend() / driver_resume() is called
>> 
>> 1) userspace is stopped.
>
>I thought that was a given ;)

This isn't ;) I have userspace working up to the very latest
steps of suspend without trouble here ;) Userspace just stops
when blocked on an IO to a suspended driver, or just when the
CPU stops.

Though for swsusp, the problem of freeing the memory makes
you need to stop userspace, except if you can teach the VM to
not try to use those physical pages again until resume.

>> 2) we are running with just one active CPU.
>
>Sure. We can tie that into subsystem notification, like this:
>
>- The level at which we want to stop requests appears to be at the device 
>  class level. 

yes, _but_ the ordering is still dictated by the bus binding, not the
device class.

>- Device classes are coming RSN. 
>
>- CPUs belong to a device class.
>
>- We can integrate PM notication into device classes.

For the above reason, PM notification has to go via the bus hierarchy,
not the class hierarchy, though the device can then notify it's class
that it's no longer willing to do anything until resumed.

>- The CPU device class can shut off all APs (application processors [silly 
>  Intel term]).





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
