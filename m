From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: How to disable wake-on-Lid Switch
Date: Wed, 09 Mar 2005 11:18:28 +1100
Message-ID: <1110327508.3663.45.camel@desktop.cunningham.myip.net.au>
References: <16942.11475.596633.415660@cse.unsw.edu.au>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <16942.11475.596633.415660-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Wed, 2005-03-09 at 09:53, Neil Brown wrote:
> hi,
>  I have a problem with my notebook. (Dell Latitude D800).
> 
>  It suspends and resumes quite nicely (video, audio, etc all work
>  well) so I'm quite happy.  But there is one little problem.
> 
>  The lid-switch seems to be a bit iffy.  Sometimes, while the laptop
>  is put away snug in it's bag in suspend mode, the lid-switch suddenly
>  thinks that the lid has been opened.  So it wakes up from suspend and
>  starts generating heat.  As it is in a nicely padded bag, the heat
>  doesn't go anywhere, so the temperature goes up up up.
> 
>  I would really like the lid button to *Not* resume from suspend.  I
>  much prefer using the power button to do that.

I believe /proc/acpi/wakeup might be what you're after:

[root@desktop root]# cat /proc/acpi/wakeup
Device  Sleep state     Status
TANA       4            disabled
P0P3       4            disabled
AC97       4            disabled
USB0       3            disabled
USB1       3            disabled
USB2       3            disabled
USB3       3            disabled
USB7       3            disabled
UAR1       4            disabled
SLPB       4            *enabled
[root@desktop root]# echo SLPB > /proc/acpi/wakeup
[root@desktop root]# cat /proc/acpi/wakeup
Device  Sleep state     Status
TANA       4            disabled
P0P3       4            disabled
AC97       4            disabled
USB0       3            disabled
USB1       3            disabled
USB2       3            disabled
USB3       3            disabled
USB7       3            disabled
UAR1       4            disabled
SLPB       4            *disabled
[root@desktop root]#

My laptop lacks an entry for the lid switch here, so it might not help,
but it can't hurt to look.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
