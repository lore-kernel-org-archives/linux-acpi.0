From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3/S2 Problems
Date: Mon, 25 Jul 2005 16:56:33 +0200
Message-ID: <20050725145633.GA8485@elf.ucw.cz>
References: <20050724234742.GA18565@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050724234742.GA18565-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nico Schottelius <nico-linux-acpi-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> echo -n 2 > /proc/acpi/sleep
> -> present with the nice ascii printout that it sleeps, but
>    it awakes immeditally.

Are you sure your system support S2? (cat /proc/acpi/sleep)

> echo -n 3 > /proc/acpi/sleep
> -> works partly. System sleeps. But:
>    --> After first sleep, everything is ok.
>    --> After second sleep, the console is broken
>        (many coloured blocks)
>        X is still ok.
>    --> After third and every following sleep:
>       console broken (grey/coloured blocks)
>       X broken (everything seems to be printed doubled like
>       ll)

Strange, see Doc*/power/video.txt, tell me what tricks you are using.

> System:
>    Compaq EVO N400C notebook
>    Linux 2.6.12.3
> 
> Btw,
>    o is there any tool to do sleep / a nice frontend to acpi
>      for the console

no.

>    o where can I find the specification of ACPI sleep states?

ACPI spec from intel?


-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
