From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: Re: [PATCH] hysteresis for active cooling
Date: Tue, 26 Jul 2005 19:59:31 +0100
Message-ID: <E1DxUeJ-0004YO-00@skye.ra.phy.cam.ac.uk>
References: <Pine.LNX.4.58.0507250950540.4364@nacho>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Mon, 25 Jul 2005 10:07:24 BST."
             <Pine.LNX.4.58.0507250950540.4364@nacho>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jamie Lentin <lentinj-aI60gWiEnN8g9ELcbhaJlPXRex20P6io@public.gmane.org>
Cc: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> The problem with this is I can't really play with my trip-points
> using /proc, because as soon as the fan changes state, my changes
> get overwritten by the DSDT.

Hmm, I've noticed that overwriting when the laptop wakes up from
suspend (S3).  The wakeup script sets the THM2 zone's active trip
point to 50 C, but after maybe 10 or 15 minutes, it reverts to 34C
(the default I think) and the fan turns on -- as it did just a minute
ago.  I haven't noticed this overwriting except after a wakeup;
normally, the setting made using /proc remains constant.  Maybe I
should reload the thermal module upon wakeup, then set the
temperature.

> I'm preparing a page in the DSDT fixes/rewrites I've done on my
> laptop, if you're interested.

Thanks, I'd be interested.  The 600X has the best keyboard of any
computer I've used, even better than my old 560.  With the maximum
memory in it, it is plenty fast enough for what I do (TeX/MetaPost,
computational physics) so I never want to upgrade to a newer and
shoddier piece of hardware, and would like to fix as much as possible
with the 600X's power management.

-Sanjoy


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
