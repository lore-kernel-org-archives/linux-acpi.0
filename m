From: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Subject: Re: Re: Should battery generate events?
Date: Tue, 12 Oct 2004 20:20:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041012202010.750c98b4@commensaal.drs.p>
References: <20041004232557.6c342288@commensaal.drs.p>
	<20041008161046.GC10581@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041008161046.GC10581-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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

On Fri, 8 Oct 2004 18:10:46 +0200
Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org> wrote:

> On Mon, Oct 04, 2004 at 11:25:57PM +0200, Tim Dijkstra wrote:
>  
> > I would want to avoid this happening again. Ideally I would want my
> > laptop to "shutdown -h now" if battery power is to low (well rather
> > have it go to S3 or softwaresuspend, but it seems hopeless to get
> > that to work :(  
> 
> Well, there are user space tools that will do this for you.
> SUSE provides powersaved which will poll your battery if it doesn't
> support events and take apropriate action (default is shutdown if
> battery is <2%). It is also caching the data so that your battery
> applet does not have to poll the battery by itself (which is
> ridiculously expensive on many machines) but it only has to ask
> powersaved.

I could not find a lot about it on the web, then downloaded the src rpm
from suse. Looks interesting ... I do not use suse myself but maybe I
can get (parts of it) to work on my system.

> Regarding suwsusp: this should work on most i386 machines out of the
> box with upcoming SUSE 9.2.

I find that a bold statement if I look at the number of posts to this
and the swsusp2 list in which people tell they can't get suspend to
work. 

grts Tim


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
