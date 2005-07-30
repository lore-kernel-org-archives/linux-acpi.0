From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP 600X))
Date: Sat, 30 Jul 2005 12:30:34 +0200
Message-ID: <20050730103034.GC1942@elf.ucw.cz>
References: <20050723003544.GC1988@elf.ucw.cz> <E1DyfYO-0006oI-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1DyfYO-0006oI-00-KmINTRm7+bkRAIupTkoUWTYRy0cijUJx@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >> One other glitch is that pdnsd (a nameserver caching daemon) has crashed
> >> when the system wakes up from swsusp.  It also happens when waking up
> >> from S3, which was working with 2.6.11.4 although not with 2.6.13-rc3.
> >> Many people have said mysql also does not suspend well.  Is their use of
> >> a named pipe or socket causing the problem?
> 
> > No idea, strace?
> 
> The upshot of stracing is in tthe Debian BTS <bugs.debian.org>
> #319572.  Paul Rombouts, an author of pdnsd, reproduced the strace
> crash and found the problem:
> 
> > Apparently strace causes sigwait to return EINTR, which is
> > inconsistent with the documentation I could find on sigwait.
> 
> Which is true.  The sigwait man entry (Debian 'etch') says:
>        The !sigwait! function never returns an error.
> 
> His patch (available in the BTS and included below) fixed the problem
> of strace or S3 sleep crashing pdnsd.

If you think it is a linux bug, can you produce small test case doing
just the sigwait, and post it on l-k with big title "sigwait() breaks
when straced, and on suspend"?

That way it is going to get some attetion, and you'll get either
documentation or kernel fixed.
								Pavel


-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
