From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: swsusp fails with "FATAL: cannot find swap device, try swapon -a!"
Date: Mon, 28 Feb 2005 15:48:08 +0100
Message-ID: <20050228144808.GB3384@elf.ucw.cz>
References: <42225F85.1000302@gmx.net> <20050228000401.GK1441@elf.ucw.cz> <4222640C.7090706@gmx.net> <42227FE9.1080400@gmx.net> <42228A3D.6080907@gmx.net> <1109564772.16374.1.camel@desktop.cunningham.myip.net.au> <4223174A.80605@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4223174A.80605-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > On Mon, 2005-02-28 at 14:04, Carl-Daniel Hailfinger wrote:
> > 
> >>swsusp: Resume From Partition: /dev/hda6
> >>swsusp: Error -6 resuming
> > 
> > That's no such device. Do you have ide support built as modules and
> > loaded from an initrd?
> 
> Yes.
> CONFIG_IDE=m
> CONFIG_BLK_DEV_IDE=m
> 
> Pavel, could you add a warning to the code which is a bit more
> obvious? "Cannot find swap device" on suspend is a little bit
> confusing. How about "No swap device available at resume time"?

Catching error -6 and telling user that suspend will not work because
it would not be able to resume, anyway, is probably way to go. Feel
free to suggest a patch ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
