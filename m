From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Oops when loading ac
Date: 24 Aug 2004 16:22:15 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093378935.17222.270.camel@dhcppc4>
References: <412B86A9.80404@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <412B86A9.80404-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

no idea.
does compiling the module static or disabling PREEMPT
or disabling DEBUG_PAGEALLOC have any effect?

On Tue, 2004-08-24 at 14:19, Pierre Ossman wrote:
> Somewhere between 2.6.7 + acpi_20040715 and 2.6.8.1 (still present in 
> 2.6.9-rc1) there appeared a bug that causes the ac module to crash when 
> loading. I had no problems with the ac module before this. Any ideas on 
> what has been changed and what to do about it?
> 
> Rgds
> Pierre
> 
>  From dmesg:
> 
> Unable to handle kernel paging request at virtual address c0452440
>  printing eip:
> c0233162
> *pde = 00488027
> *pte = 00452000
> Oops: 0002 [#1]
> PREEMPT DEBUG_PAGEALLOC
> Modules linked in: ac radeon ipv6 xfs
> CPU:    0
> EIP:    0060:[<c0233162>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.9-rc1)
> EIP is at acpi_bus_register_driver+0xd4/0x169
> eax: c0452440   ebx: e0903b40   ecx: e090336b   edx: ffffffed
> esi: dd468000   edi: e0903c80   ebp: c03cec60   esp: dd469f84
> ds: 007b   es: 007b   ss: 0068
> Process insmod (pid: 573, threadinfo=dd468000 task=dd4909f0)
> Stack: c03ceca0 e0905031 e0903b40 c014c54b c0469884 00000001 e0903c80 
> 4003edfa
>        0001120e bffffeec 00000004 40010008 00000000 00000000 dd468000 
> c0106b79
>        40010008 0002edf2 0807a008 00000000 00000000 bfffcef8 00000080 
> 0000007b
> Call Trace:
>  [<e0905031>] init_module+0x31/0x52 [ac]
>  [<c014c54b>] sys_init_module+0x1ab/0x370
>  [<c0106b79>] sysenter_past_esp+0x52/0x71
> Code: 00 00 00 a1 6c 75 3d c0 c7 05 f8 74 3d c0 7c f2 39 c0 c7 05 fc 74 
> 3d c0 bd 01 00 00 89 1d 6c 75 3d c0 c7 03 68 75 3d c0 89 43 04 <89> 18 
> 81 3d e8 74 3d c0 3c 4b 24 1d 74 1c 68 e8 74 3d c0 68 bf
>  <6>note: insmod[573] exited with preempt_count 1
> drivers/acpi/scan.c:445: spin_lock(drivers/acpi/scan.c:c03d74e8) already 
> locked by drivers/acpi/scan.c/445
> 
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



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
