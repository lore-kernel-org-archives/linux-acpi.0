From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: Re: [PATCH] hysteresis for active cooling
Date: Mon, 25 Jul 2005 04:08:13 +0100
Message-ID: <E1DwtK9-000275-00@skye.ra.phy.cam.ac.uk>
References: <42E31751.4080802@yahoo.com.br>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Sun, 24 Jul 2005 01:21:37 -0300."
             <42E31751.4080802-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Currently as I type that, my system starts active cooling when it
> reaches 52 C and turns off when it reaches 44.

> In my system, what your patch would do? Will it turn off fan when it
> reach 42, instead of actual 44?

I don't know for sure, since I don't understand why your system starts
active cooling at 52 C (instead of 50 C) -- maybe there's hysteresis
in the hardware?  And why does it have to get way down to 44 C instead
of only 50 C before turning off?

>From reading the acpi spec, I understood that the ACPI interpreter is
supposed to handle updating the temperature, querying the embedded
controller, providing interfaces to turn the fan on and off; but that
the OSPM (operating system power management code) is supposed to
decide when to turn the fan on and off.  In Linux that code is in the
thermal module (drivers/acpi/thermal.c), and the only code I found to
turn off active cooling was the else clause of

	    if (tz->temperature >= active->temperature) {

Would an ACPI guru clear up my lack of clue?

-Sanjoy


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
