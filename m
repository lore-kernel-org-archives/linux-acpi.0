From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: RE: Thermal OOPS fixed
Date: Wed, 02 Oct 2002 22:43:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033591429.363.9.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <Pine.SOL.4.21.0210012247410.28739-100000@neptun>
 <1033591347.360.6.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1033591347.360.6.camel-s1IKGncK6J2OERECOqmV57dB6IYNvbhm87tLKu7D3g4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Forget to mention this is 2.4 specific only (to be precise: 2.4.20-pre7
+ acpi latest) as it seems that kind of device/driver handling has
changed in 2.5

-Knut

Am Mit, 2002-10-02 um 22.42 schrieb Knut Neumann:
> Am Die, 2002-10-01 um 22.52 schrieb kneumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org:
> > On Tue, 1 Oct 2002, Grover, Andrew wrote:
> > > I will fix the timer init problem. Can you submit a patch for the rmmod
> > > /proc issue?
> > 
> > Not yet, but I am working on it. It seems that something goes wrong in
> > acpi_bus_unregister_driver. Obviously acpi_thermal_remove does not get
> > called. I will submit a patch if I can as soon as possible.
> 
> Ok. I guess I found it: In acpi/drivers/bus.c::acpi_bus_unattach l 1176:
> 
> 	if (device->driver != driver)
> 		return_VALUE(-ENOENT);
> 
> This assertion fails, because device->driver is not set anywhere around
> when the driver is attached to the device. I fixed it by adding
> 
> 	device->driver = driver;
> 
> in bus.c::apci_bus_driver_init l 1089 just after driver->ops.add(device)
> has been successfully executed.
> 
> I am not quite sure this is the right place to set it though...
> 
> -Knut
> 
> -- 
> Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
> Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
> Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
> fon: +49-211-81-11314                           fax: +49-211-81-13105
> 
> 
> 
> 
> 
> 
> 
-- 
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
fon: +49-211-81-11314                           fax: +49-211-81-13105











-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
