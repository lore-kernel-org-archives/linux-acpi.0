From: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Subject: Re: Should battery generate events?
Date: Tue, 5 Oct 2004 22:41:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041005224124.36a215c5@commensaal.drs.p>
References: <20041004232557.6c342288@commensaal.drs.p>
	<4161CB55.9040800@linuxboxen.org>
	<20041005202844.50abc833@commensaal.drs.p>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041005202844.50abc833-7SZEXzPdWeU90gtriz95AQ@public.gmane.org>
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

On Tue, 5 Oct 2004 20:28:44 +0200
Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org> wrote:

> On Mon, 04 Oct 2004 15:14:45 -0700
> David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org> wrote:
> 
> > Tim Dijkstra wrote:
> >   
> > >From some googl'ing I get the impression that ACPI should generate
> > >battery events on a change of capacity or at least when it's low.
> > >My idea was to have acpid call some script on battery events. 
> > >The problem is that there doesn't seem to be such events on my
> > >machine. 
> > >  
> > >
> > Whenever polling is required, this is expected to be done in
> > userspace, not in kernelspace. There's a long history of people
> > asking"why doesn't battery status changes generate events" and a
> > long history of people saying "because it would require polling in
> > either acpid or the kernel, which is a Bad Thing(tm)".
> 
> Hmm, sounds reasonable ... But what do these entries in
> /proc/acpi/battery/BAT0/info mean:
> 
> design capacity warning: 30 mAh
> design capacity low:     20 mAh
> 
> it seems to imply to me that there should be a warning of some kind
> when the capacity hits 30 mAh. But if I read your post correctly there
> is no such thing?

Replying to my self here ... 

Readying the ACPI spec I learned there _is_ such a thing, but it's not
required. And browsing through my dsdt I see there's no _BTP method,
which probably means my battery doesn't support that:( 
After reading battery.c I can further reply to myself in my first
post:

> > > Does it have anything to do with
> > > tdykstra@bonenpikster:/$ cat /proc/acpi/battery/BAT0/alarm
> > > alarm:                   unsupported

Yes, this means there's no _BTP and hence no warning events.

So polling is the only option for me ...


grts Tim


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
