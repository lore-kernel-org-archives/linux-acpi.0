From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: 2.6.10-rc3 /proc/acpi/alarm does not wakeup from S3, videomode lost
Date: Sat, 25 Dec 2004 22:07:04 +0100
Message-ID: <20041225210704.GA20109@elf.ucw.cz>
References: <200412212059.43909.mhf@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200412212059.43909.mhf-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mhf-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Tried this on several machines:
> 
> # date -d +${x}seconds '+%Y-%m-%d %H:%M:%S' > /proc/acpi/alarm
> # echo "3" > /proc/acpi/sleep
> 
> 3 <= x <= 100 seconds.
> 
> Sleeps alright but alarm is ignored, power switch wakes up. /proc/acpi/alarm 
> readback correct. 
> 
> When machine awoken by button, textmode console videomode (80x60) is lost 
> seems to be 80x25 and cursor gone and scroll messed up.

Have you tright various options from Documentation/power/video.txt?

Or try just loading new fonts with setfont.

> Sometimes "evevent-0286: *** Error: No installed handler for fixed event 
> [00000004]" was observed on wakeup from _2nd_ S3.
> 
> How to make the alarm function work?

No idea, it never worked for me.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
