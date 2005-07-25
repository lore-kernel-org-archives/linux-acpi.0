From: Jamie Lentin <lentinj-aI60gWiEnN8g9ELcbhaJlPXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] hysteresis for active cooling
Date: Mon, 25 Jul 2005 10:07:24 +0100 (BST)
Message-ID: <Pine.LNX.4.58.0507250950540.4364@nacho>
References: <E1DwtK9-000275-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1DwtK9-000275-00-KmINTRm7+bkRAIupTkoUWTYRy0cijUJx@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Cc: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> I don't know for sure, since I don't understand why your system starts
> active cooling at 52 C (instead of 50 C) -- maybe there's hysteresis
> in the hardware?  And why does it have to get way down to 44 C instead
> of only 50 C before turning off?

There is probably hysteresis built into the DSDT.  The ACPI Spec
suggests doing this (don't have a page # handy tho', sorry), it's how
hysteresis is implemented on my laptop (as well as yours---atlhough the
hysteresis code is probably broken as it was on mine.  I'm preparing a
page in the DSDT fixes/rewrites I've done on my laptop, if you're
interested.  Your 600x DSDT code seems pretty much identical to my 770x
code).

Basically, whenever there is a change in fan state, the DSDT can trigger
the OS to re-read the trip-points from the DSDT, and give lower values.
Again, once the fan turns off, it can tell the OS to re-read, and give
higher trip-point values.

The problem with this is I can't really play with my trip-points using
/proc, because as soon as the fan changes state, my changes get
overwritten by the DSDT.  It would be interesting if anyone has any ideas
of getting around this.

Cheers,


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
