From: David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Subject: Re: Should battery generate events?
Date: Mon, 04 Oct 2004 15:14:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4161CB55.9040800@linuxboxen.org>
References: <20041004232557.6c342288@commensaal.drs.p>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041004232557.6c342288-7SZEXzPdWeU90gtriz95AQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Cc: ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Tim Dijkstra wrote:

>Hi,
>
>Last week my laptop (Acer Travelmate 636Lci) run out of power resulting
>in a unclean shutdown, disk corruption and me spending a few evenings to
>get it to sanely work again.
>
>I would want to avoid this happening again. Ideally I would want my
>laptop to "shutdown -h now" if battery power is to low (well rather have
>it go to S3 or softwaresuspend, but it seems hopeless to get that to
>work :(  
>
>>From some googl'ing I get the impression that ACPI should generate
>battery events on a change of capacity or at least when it's low. My
>idea was to have acpid call some script on battery events. 
>The problem is that there doesn't seem to be such events on my machine. 
>  
>
Whenever polling is required, this is expected to be done in userspace, 
not in kernelspace. There's a long history of people asking "why doesn't 
battery status changes generate events" and a long history of people 
saying "because it would require polling in either acpid or the kernel, 
which is a Bad Thing(tm)".

If you'd like something to watch the battery capacity, perhaps you 
should use something like KLaptop -- you can configure it to run a 
command (like 'echo -n "disk" > /sys/power/state') on low and/or on 
critical battery level warnings. Since it tracks this kind of state, you 
don't have to.

Of course, KLaptop's not the only option -- it's just what I have here.

David Bronaugh


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
