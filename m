From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: Re: 2.6.12-rc2-mm3 (ACPI build problem)
Date: Wed, 13 Apr 2005 03:06:26 +0200
Message-ID: <20050413010626.GJ3631@stusta.de>
References: <425C0AFE.9080106@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <425C0AFE.9080106-D1TkPCJej5s@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stas Sergeev <stsp-D1TkPCJej5s@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 12, 2005 at 09:53:02PM +0400, Stas Sergeev wrote:
> Hello.
> 
> Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> Fails to compile with
> !CONFIG_ACPI && CONFIG_SMP.
> CONFIG_SMP sets CONFIG_X86_HT,
> which sets CONFIG_ACPI_BOOT,
> but that fails without CONFIG_ACPI:
> 
>  CC      arch/i386/kernel/setup.o
> arch/i386/kernel/setup.c:96: error: syntax error before ???acpi_sci_flags???
> arch/i386/kernel/setup.c:96: warning: type defaults to ???int??? in 
> declaration of ???acpi_sci_flags???
> arch/i386/kernel/setup.c:96: warning: data definition has no type or 
> storage class
> arch/i386/kernel/setup.c: In function ???parse_cmdline_early???:
> arch/i386/kernel/setup.c:811: error: request for member ???trigger??? in 
> something not a structure or union
> arch/i386/kernel/setup.c:814: error: request for member ???trigger??? in 
> something not a structure or union
> arch/i386/kernel/setup.c:817: error: request for member ???polarity??? in 
> something not a structure or union
> arch/i386/kernel/setup.c:820: error: request for member ???polarity??? in 
> something not a structure or union

Known bug.

Workaround:
Enable CONFIG_ACPI.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
