From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: Re: C2, C3 and bus master activity
Date: Wed, 20 Jul 2005 21:56:43 +0200
Message-ID: <42DEAC7B.7090103@tzi.de>
References: <200507192050.28343.pumpkin@gmx.de> <200507192118.37528.bob@diamond.demon.co.uk> <m23bq98fir.fsf@phoenix.squirrel.nl> <200507202031.38488.bob@diamond.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507202031.38488.bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Bob Lees wrote:
> I agree with Johan, I think it was the uhci-hcd driver which caused the 
> problem.  I must admit that I don't have wireless running when I shut 
> everything off so that may also be a problem.
> 
> Unfortunately its the uhci-hcd driver which allows me to use a usb mouse so I 
> would like to know how the usb driver could be used and still have C3/4 (C4 
> on the IBM)
Actually ff you use an USB device, you can never use the C3 or C4 mode 
of your CPU. USB devices just cause busmaster activity, and as long as 
the kernel detecs busmaster activity, it stops taking the CPU in 
anything behind C2.

If you want to know more please read ACPIspec3.0
8.1.4 Processor Power State C3
on page 253 (the number in the document / the pdfreader says it's page 273)

    Janosch
> 
> Bob
> 
> On Wednesday 20 July 2005 20:05, Johan Vromans wrote:
> 
>>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
