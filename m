From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
Date: Fri, 19 Nov 2004 19:29:14 +0100
Message-ID: <419E3B7A.4000904@free.fr>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.SOC.4.61.0411191934070.29328-ptEonEWSGqKptlylMvRsHA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Tourrilhes <jt-yAE0UhLNZJawPNPzzlOzwdBPR1lH4CV8@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Meelis Roos wrote:
>> Could you send me the result of : "for i in /sys/bus/pnp/devices/*; do 
>> cat $i/id $i/options; done" in order to see if other devices have 
>> missing resources ?
> 
> 
> PNP0c01
> PNP0200
> PNP0800
> PNP0c04
> PNP0303
> PNP0f13
> PNP0b00
> PNP0c02
> PNP0700
> port 0x3f0-0x3f0, align 0x0, size 0x6, 16-bit address decoding
> port 0x3f7-0x3f7, align 0x0, size 0x1, 16-bit address decoding
> irq 6 High-Edge
> dma 2 8-bit compatible
floppy : seem ok
> PNP0501
> Dependent: 01 - Priority acceptable
>    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 02 - Priority acceptable
>    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 03 - Priority acceptable
>    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 04 - Priority acceptable
>    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
serial miss irq
> SMCf010
> Dependent: 01 - Priority acceptable
>    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 02 - Priority acceptable
>    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 03 - Priority acceptable
>    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 04 - Priority acceptable
>    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
irda : miss io,irq,dma
> PNP0401
> Dependent: 01 - Priority acceptable
>    port 0x378-0x378, align 0x0, size 0x3, 16-bit address decoding
>    port 0x778-0x778, align 0x0, size 0x3, 16-bit address decoding
>    irq 7 High-Edge
> Dependent: 02 - Priority acceptable
>    port 0x278-0x278, align 0x0, size 0x3, 16-bit address decoding
>    port 0x678-0x678, align 0x0, size 0x3, 16-bit address decoding
>    irq 5 High-Edge
> Dependent: 03 - Priority acceptable
>    port 0x3bc-0x3bc, align 0x0, size 0x3, 16-bit address decoding
>    port 0x7bc-0x7bc, align 0x0, size 0x3, 16-bit address decoding
>    irq 7 High-Edge
parallel port: miss dma
> TOS6200
> 

Could it be an acpi parsing problem ?
Is there a easy way to use ACPI_DUMP_RESOURCE_LIST in order to find all 
the resource find by acpi in order to see if it is an acpi problem or a 
pnpacpi problem ?

Matthieu


PS : I CC the message to acpi people : look 
http://marc.theaimsgroup.com/?t=110075024500002&r=1&w=2 for the begining.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
