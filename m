From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: HP-Compaq nx9110 laptop
Date: Fri, 25 Mar 2005 09:18:15 +0100
Message-ID: <20050325081815.GB17245@elf.ucw.cz>
References: <200503231156.47279.wacky@bourget.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503231156.47279.wacky-kjdgaHvQH9ajKv3TNrM5DQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexandre B <wacky-kjdgaHvQH9ajKv3TNrM5DQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I've acquired an HP-Compaq nx9110 laptop recently and I tested everything and 
> found most of the parts working correctly .. sometimes with non-free drivers, 
> sometimes otherwise.
> 
> One thing still pending to work is the sleep/suspend/resume function. I 
> crawled the web for a while.. found the ACPI DSDT repository and tried 
> fiddling with the DSDT. I fixed a bug in it.. replaced it in an initrd but 
> that couldn't get the suspend/resume to work. I tried software suspend 2, but 
> it hanged all the time. Now I compiled the kernel with ACPI debugging and 
> tried:
> 
> echo 0xffffffff > /proc/acpi/debug_level
> 
> and watched what happened when I did:
> 
> echo 3 > /proc/acpi/sleep
>   or
> echo mem > /sys/power/state
> 
> or anything with these pseudo-files. The thing is I see absolutely nothing in 
> the logs when I try these.. while when I close the laptop cover, a whole 
> bunch of stuff appears in the logs about the LID triggering events. Isn't 
> anything supposed to appear in the logs about ACPI when playing with these 
> files ?
> 
> I read a howto somewhere.. and it recommended to step in this mailing list for 
> suspend resume problems, since it seems it's still being developed. Is that 
> right ?
> 
> I was wondering if anyone could guide me to a solution, or help out getting 
> this to work.
> 
> Below are the outputs of:
> dmidecode
> lspci -vv
> lsusb -vv
> 
> 
> Thanks for any insights.

Try getting swsusp to work, first.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
