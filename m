From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Random shutdowns - some new details
Date: Tue, 16 Sep 2003 14:02:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030916120243.GD602@elf.ucw.cz>
References: <3F5580DE.1060904@sbox.tugraz.at> <20030908095253.GC3944@openzaurus.ucw.cz> <3F66A5B2.2060400@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F66A5B2.2060400-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >In-kernel ACPI will happily call /sbin/halt for you in case of system 
> >overheat.
> >Watch /proc/acpi/thermal/*/*
> 
> Thank you for this information - when digging through the sources I was 
> able to locate the responsible lines.

So try to locate those "/sbin/halt" calling lines, and replace with
something like "logger 'I refuse to die'", and see what happens. If it
does not trigger, you know it is something else.

> To get behind these shutdowns I added some lines dealing with thermal 
> events, mainly cat'ting /proc/acpi/thermal_zone/THRx/temperature, to the 
> script /usr/sbin/acpid_proxy.
> 
> This script is called by acpid with the text of the occured event as 
> parameter (The SuSE-way of handling acpi-events).
> 
> Three days ago another shutdown occured, showing two things:
> 1) I made some mistake when extending acpid_proxy. But the temperatures 
> were logged.
> 2) The temperature logged are far below the trip-points for a shutdown. 
> (see the attached files)
> 
> The trip-point for my thermal zone THRS is 92C, the actual temperature 
> when the event occured was 46C (logged)
> 
> What does this mean?

No idea. [BTW nice system: two thermal zones, I never seen it before].

> Please mind the attached files:
> acpid - a cut from the acpid-logfile
> THRC-trip_points - /proc/acpi/thermal_zone/THRC/trip_points
> THRS-trip_points - /proc/acpi/thermal_zone/THRS/trip_points
> 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
