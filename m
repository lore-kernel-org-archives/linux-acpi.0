From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Thu, 19 Aug 2004 16:54:29 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41251385.9040907@optonline.net>
References: <41103F22.4090303@optonline.net> <200408192224.08271.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408192224.08271.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan Dösinger wrote:
>>This patch should fix multiple user-visible problems with the ACPI IRQ
>>routing after S3 resume:
>>
>>"irq x: nobody cared"
>>"my interrupts are gone"
>>
>>It probably applies to multiple bugzilla entries and mailing list posts.
>>
>>Tested on my machine, which is experiencing similar problems. Seems to
>>work - although I get some non-fatal "nobody cared" messages that might
>>be caused by the i8042 driver.
>>
>>Comments?
>>Stefan, can you test this?
> 
> Sorry for the very late reply.
> 
> I tested with 2.6.8.1(I think your patch it included there) with strange 
> results.
> 
> *It works fine if I unload ipw2100 before suspend and load it later

I can't find anything named "ipw2100" in my kernel source tree...

> *In single user mode with ipw2100 loaded while S3, IRQ 11 is disabled on 
> resume, IRQ is not disabled

Huh? IRQ(what) is not disabled?

Please attach dmesg.

> *When the system is fully booted up, everything seems to work fine.

What do you mean by this? If you suspend when more drivers are loaded, 
things work fine, but don't work when less drivers are loaded?

> 
> I'll test a little bit more and report the results.

Thanks for testing.
Nathan

> 
> Cheers,
> Stefan
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
