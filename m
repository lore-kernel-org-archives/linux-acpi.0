From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 07/12] acpi: flush TLB when pagetable changed
Date: 02 Mar 2005 13:59:47 -0500
Message-ID: <1109789982.2097.578.camel@d845pe>
References: <200502230953.j1N9rJiZ020708@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502230953.j1N9rJiZ020708-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2005-02-23 at 04:53, akpm-3NddpPZAyC0@public.gmane.org wrote:
> From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Possibly it doesn't change anything here (it's low mem), but it's
> better to
> fix it.
> 
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/arch/i386/kernel/acpi/sleep.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN
> arch/i386/kernel/acpi/sleep.c~acpi-flush-tlb-when-pagetable-changed
> arch/i386/kernel/acpi/sleep.c
> ---
> 25/arch/i386/kernel/acpi/sleep.c~acpi-flush-tlb-when-pagetable-changed      2005-02-23 01:48:04.000000000 -0800
> +++ 25-akpm/arch/i386/kernel/acpi/sleep.c       2005-02-23
> 01:48:04.000000000 -0800
> @@ -8,7 +8,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bootmem.h>
>  #include <asm/smp.h>
> -
> +#include <asm/tlbflush.h>
> 
>  /* address in low memory of the wakeup routine. */
>  unsigned long acpi_wakeup_address = 0;
> @@ -27,6 +27,7 @@ static void init_low_mapping(pgd_t *pgd,
>                 set_pgd(pgd, *(pgd+USER_PTRS_PER_PGD));
>                 pgd_ofs++, pgd++;
>         }
> +       flush_tlb_all();
>  }
> 
>  /**
> _
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
