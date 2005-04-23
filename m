From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 1/1] bk-acpi alpha build fix
Date: 22 Apr 2005 23:47:33 -0400
Message-ID: <1114228053.2930.36.camel@d845pe>
References: <200504021149.j32BnaCk006108@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504021149.j32BnaCk006108-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yeah, that's the right fix.
Applied.

thanks,
-Len

On Sat, 2005-04-02 at 06:49, akpm-3NddpPZAyC0@public.gmane.org wrote:
> 
> ACPI doesn't work on alphas.
> 
>   CC      drivers/pci/quirks.o
> distcc[25816] ERROR: compile on localhost failed
> In file included from include/acpi/platform/acenv.h:123,
>                  from include/acpi/acpi.h:53,
>                  from include/linux/acpi.h:34,
>                  from drivers/pci/quirks.c:21:
> include/acpi/platform/aclinux.h:59:22: asm/acpi.h: No such file or
> directory
> In file included from include/acpi/acpi.h:54,
>                  from include/linux/acpi.h:34,
>                  from drivers/pci/quirks.c:21:
> include/acpi/actypes.h:110: error: parse error before "INT64"
> include/acpi/actypes.h:110: warning: type defaults to `int' in
> declaration of `INT64'
> include/acpi/actypes.h:110: warning: data definition has no type or
> storage class
> include/acpi/actypes.h:111: error: parse error before "UINT64"
> include/acpi/actypes.h:111: warning: type defaults to `int' in
> declaration of `UINT64'
> include/acpi/actypes.h:111: warning: data definition has no type or
> storage class
> In file included from drivers/pci/quirks.c:21:
> include/linux/acpi.h:37:22: asm/acpi.h: No such file or directory
> 
> 
> I chose to fix it in acpi.h.  Seems cleaner than adding an ifdef to
> quirks.c.
> 
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-alpha-akpm/include/linux/acpi.h |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff -puN include/linux/acpi.h~bk-acpi-alpha-build-fix
> include/linux/acpi.h
> --- 25-alpha/include/linux/acpi.h~bk-acpi-alpha-build-fix      
> 2005-04-02 01:54:02.000000000 -0800
> +++ 25-alpha-akpm/include/linux/acpi.h  2005-04-02 01:54:30.000000000
> -0800
> @@ -25,6 +25,8 @@
>  #ifndef _LINUX_ACPI_H
>  #define _LINUX_ACPI_H
> 
> +#ifdef CONFIG_ACPI
> +
>  #ifndef _LINUX
>  #define _LINUX
>  #endif
> @@ -536,4 +538,5 @@ static inline int acpi_get_pxm(acpi_hand
> 
>  extern int pnpacpi_disabled;
> 
> -#endif /*_LINUX_ACPI_H*/
> +#endif /* CONFIG_ACPI */
> +#endif /* _LINUX_ACPI_H */
> _
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
