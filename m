From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: /proc/acpi/alarm not working
Date: Tue, 14 Jun 2005 23:40:08 +0200
Message-ID: <20050614214008.GC2172@elf.ucw.cz>
References: <42A7842C.2060207@colitti.com> <20050609134938.GA4478@openzaurus.ucw.cz> <42AF2063.3050104@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42AF2063.3050104-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>I am trying to use /proc/acpi/alarm to wake my laptop from S3 and go 
> >>into S4 after a fixed amount of time. But I can't get 
> >>/proc/acpi/alarm to work.
> > That sounds dangerous to me... drive might spin up during bad time when being
> > transported...
> 
> I am also missing that functionality!
> My older Lifebook was able to do that automatically using APM. This was
> very convenient because you never had to care about usign one over the
> other suspend method. You simply close the lid - dot.
...
> I always had the timeout to 30 minutes and was very hapy with it.

> And I also have not had any problem with my harddisk at all - I just
> sometimes wondered what would happen if I close the lid and the machine
> starts to suspend to disk while sitting in an airplane ;) but that's
> another problem.

Really? Turning on machine at some random time seems dangerous to
me. Airplane is one example. Or imagine closing lid than going
horseback riding with your laptop. Machine can probably survive that
kind of vibrations when powered down, but I do not think it would
survive them with disk spinning...

> > Why not enter S3 but save image to disk in case battery runs out?
> 
> Two reasons:
> 1. Not necessary in most cases (at least it does not give a huge benefit).
> 2. Too much battery drain causing battery to wear out too early.

IBM was calling it "redisafe". I'm not sure how fast it killed the
batteries...

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
