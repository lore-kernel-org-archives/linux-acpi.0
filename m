From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: Should battery generate events?
Date: Wed, 13 Oct 2004 01:14:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041012231408.GB7166@message-id.gmane0305.slipkontur.de>
References: <20041004232557.6c342288@commensaal.drs.p> <20041008161046.GC10581@message-id.gmane0305.slipkontur.de> <20041012202010.750c98b4@commensaal.drs.p>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041012202010.750c98b4-7SZEXzPdWeU90gtriz95AQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 12, 2004 at 08:20:10PM +0200, Tim Dijkstra wrote:
> On Fri, 8 Oct 2004 18:10:46 +0200

> I could not find a lot about it on the web, then downloaded the src rpm
> from suse. Looks interesting ... I do not use suse myself but maybe I
> can get (parts of it) to work on my system.

we are currently working on getting it more portable, it is pretty
SUSE-centric right now but this should change soon. If it builds and
runs on other distributions, tarballs and packages will be available
from forge.novell.com (the CVS is hosted there).
 
> > Regarding suwsusp: this should work on most i386 machines out of the
> > box with upcoming SUSE 9.2.
> 
> I find that a bold statement if I look at the number of posts to this
> and the swsusp2 list in which people tell they can't get suspend to
> work. 

It worked at least on every i386 notebook i could get my hands on during
beta and that were a lot of machines. I did not test many desktops (i don't
have many of them :-) but i really believe it should work out of the box
on most i386 notebooks. Of course there are known show-stoppers like the
binary NVidia drivers but these should fail gracefully and there is not
much we can do about them.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
