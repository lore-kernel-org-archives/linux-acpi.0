From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: current ACPI status in 2.6.7 kernel
Date: Wed, 11 Aug 2004 09:19:01 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <411A1CC5.5030401@optonline.net>
References: <411881B1.9000903@ti.com>
 <1092132146.2666.3.camel@laptop.cunninghams> <4118D40D.5030404@ti.com>
 <4118F918.7070909@optonline.net> <4119024B.5060602@optonline.net>
 <4119CF6A.8020807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <4119CF6A.8020807-l0cyMroinI0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Sirotkin <demiurg-l0cyMroinI0@public.gmane.org>
Cc: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> Thanks for the tip, fortunately I don't have any SCSI or SATA disks. 
> Unfortunately, I still don't
> know how to do this. Is there an utility to put PC into sleep/suspend 
> ? I know I can switch
> to various S modes using /proc entry, but what about all the 
> peripherals and user mode apps ?
> I would venture that there has to be some kind of subsystem in user 
> mode to take care of
> all this. I probably did not phrase my question right, but when I 
> Asked if ACPI suspend/sleep
> status is stable enough I was actually referring to the whole 
> subsystem, not just kernel
> support.

It's not that big of a deal for userspace, you just need scripts to 
unload any problem device drives before suspend and reload them after 
resume. You would also need to kill and restart any programs that will 
be broken by those devices going away. APM already has config files that 
specify a lot of this which could probably be adapted to ACPI. But the 
ultimate goal is to get devices that don't even need to be unloaded, 
since we now have proper suspend/resume hooks. ;)

I think there is a "pmsuspend" program floating around out there, don't 
know how well it has been integrated with existing suspend/resume 
scripts though. Otherwise you can just talk to the kernel directly...

Nathan

Oh, and there's that annoying little problem where acpid sees the button 
press that I have to use to resume, as a shutdown event...


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
