From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: C2, C3 and bus master activity
Date: Wed, 20 Jul 2005 01:00:03 +0200
Message-ID: <42DD85F3.9050300@tzi.de>
References: <200507192050.28343.pumpkin@gmx.de> <200507192118.37528.bob@diamond.demon.co.uk> <200507192359.56553.pumpkin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507192359.56553.pumpkin-Mmb7MZpHnFY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pumpkin-Mmb7MZpHnFY@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

pumpkin wrote:
> Hello
> 
> I tested this by removing kernel/driver/usb/* and rebuilding initrd (just to 
> be sure). It did not change anything for console (still 50:50 between C2 and 
> C3) and made Xorg crash pretty hard.
> 
> Do you think removing all the other external buses (Firewire, ethernet, 
> WLAN ,..) would change something ? 
> 
Sometimes an active WLAN driver causes bus master activity...
You also should not use an USB Mouse...

And by the way, what's wrong with 50:50 C2 C3 ?
This seems pretty normal to me.

> Could cpufreqd be part of the problem ?
> 
> Thanks,
> 
> On Tuesday 19 July 2005 22:18, Bob Lees wrote:
> 
>>Hi
>>
>>In a word USB.  I don't fully understand why, but if I disable USB then
>>both my laptops will go into C3 or C4, with USB enabled stays in C2.
>>
>>Laptops are Compaq EVO 800c and IBM T42p both running SUSE 9.3 with a stock
>>SuSE kernel 2.6.11-suse modified
>>
>>Bob
>>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
