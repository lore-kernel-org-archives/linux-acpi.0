From: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Subject: Re: Should battery generate events?
Date: Tue, 5 Oct 2004 20:28:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041005202844.50abc833@commensaal.drs.p>
References: <20041004232557.6c342288@commensaal.drs.p>
	<4161CB55.9040800@linuxboxen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4161CB55.9040800-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
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

On Mon, 04 Oct 2004 15:14:45 -0700
David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org> wrote:

> Tim Dijkstra wrote:
>   
> >From some googl'ing I get the impression that ACPI should generate
> >battery events on a change of capacity or at least when it's low. My
> >idea was to have acpid call some script on battery events. 
> >The problem is that there doesn't seem to be such events on my
> >machine. 
> >  
> >
> Whenever polling is required, this is expected to be done in
> userspace, not in kernelspace. There's a long history of people asking
> "why doesn't battery status changes generate events" and a long
> history of people saying "because it would require polling in either
> acpid or the kernel, which is a Bad Thing(tm)".

Hmm, sounds reasonable ... But what do these entries in
/proc/acpi/battery/BAT0/info mean:

design capacity warning: 30 mAh
design capacity low:     20 mAh

it seems to imply to me that there should be a warning of some kind when
the capacity hits 30 mAh. But if I read your post correctly there is no
such thing?

> If you'd like something to watch the battery capacity, perhaps you 
> should use something like KLaptop -- you can configure it to run a 
> command (like 'echo -n "disk" > /sys/power/state') on low and/or on 
> critical battery level warnings. 

Yeah, but several people log in on this laptop (wife, kid (well not
yet), brothers, sister ...) and that means I have to set up their
desktops and hope they don't accidentally disable it. It seemed a much
cleaner solution to have a gui/user independent process handle it.

It seems I have to hack a little script that polls the battery status
ones in a while and takes appropriate action...

grts Tim 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
