From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: b44 driver suspend/resume (was Re: Re: Re: various problems
 with Acer TM654, suspend, ACAD, radeon)
Date: Wed, 25 Aug 2004 10:53:18 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <412CA7DE.8050706@optonline.net>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <20040823070534.GD24853@message-id.gmane0305.slipkontur.de> <20040823103515.GH8635@gamma.logic.tuwien.ac.at> <20040824233153.GA15474@message-id.gmane0305.slipkontur.de> <20040825131109.GD6119@gamma.logic.tuwien.ac.at> <412C9980.803@optonline.net> <412CA0F5.4@optonline.net> <20040825144038.GA17522@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040825144038.GA17522-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-net-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Norbert Preining wrote:
> Hi Nathan!
> 
> On Mit, 25 Aug 2004, Nathan Bryant wrote:
>>
>>Oops, never mind that. That's just because you hadn't ifup'd the device 
> 
> 
> I did.

Before you ran cat /proc/interrupts after resume? Are you sure? eth0 
didn't appear anywhere in there...

> 
> 
>>yet. But I still suspect a driver issue; your IRQ routing looks like it 
>>should be OK, but somebody is sending repeated interrupts. You could 
>>test with "acpi=noirq", but I don't think that will help.
> 
> 
> It worked!!!! Yes, no problems. Booting with acpi=noirq and loading the
> b44 module let it find irq 5 and it is working. I am writing this email
> from after a resume, even X worked out of the box.

Back to the drawing board. :( That means there's still something wrong 
with pci_link.c


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
