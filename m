From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 02/12] ia64 acpi build fix
Date: 02 Mar 2005 13:42:54 -0500
Message-ID: <1109788974.2101.561.camel@d845pe>
References: <200502230953.j1N9rCep020693@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502230953.j1N9rCep020693-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2005-02-23 at 04:52, akpm-3NddpPZAyC0@public.gmane.org wrote:
> 
> arch/ia64/kernel/acpi.c: In function `acpi_map_iosapic':
> arch/ia64/kernel/acpi.c:822: error: `MAX_PXM_DOMAINS' undeclared
> (first use in this function)
> arch/ia64/kernel/acpi.c:822: error: (Each undeclared identifier is
> reported only once
> arch/ia64/kernel/acpi.c:822: error: for each function it appears in.)
> arch/ia64/kernel/acpi.c:827: error: `pxm_to_nid_map' undeclared (first
> use in this function)
> 
> 
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/arch/ia64/kernel/acpi.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN arch/ia64/kernel/acpi.c~ia64-acpi-build-fix
> arch/ia64/kernel/acpi.c
> --- 25/arch/ia64/kernel/acpi.c~ia64-acpi-build-fix      2005-02-23
> 01:47:50.000000000 -0800
> +++ 25-akpm/arch/ia64/kernel/acpi.c     2005-02-23 01:47:50.000000000
> -0800
> @@ -771,7 +771,7 @@ EXPORT_SYMBOL(acpi_unmap_lsapic);
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>  
> 
> -#ifdef CONFIG_NUMA
> +#ifdef CONFIG_ACPI_NUMA
>  acpi_status __init
>  acpi_map_iosapic (acpi_handle handle, u32 depth, void *context, void
> **ret)
>  {
> _
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
