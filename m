From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [patch 4/4] CONFIG_ACPI=n build fix
Date: Tue, 5 Apr 2005 00:22:36 -0700
Message-ID: <20050405002236.1b29451a.akpm@osdl.org>
References: <200504050657.j356vG0I032687@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504050657.j356vG0I032687-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

akpm-3NddpPZAyC0@public.gmane.org wrote:
>
>  
>  -static inline int acpi_boot_init(void)
>  -{
>  -	return 0;
>  -}
>  -
>  -static inline int acpi_boot_table_init(void)
>  -{
>  -	return 0;
>  -}
>  -
>   #endif 	/*!CONFIG_ACPI_BOOT*/
>   
>   unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
>  @@ -539,4 +529,15 @@ static inline int acpi_get_pxm(acpi_hand
>   extern int pnpacpi_disabled;
>   
>   #endif	/* CONFIG_ACPI */
>  +
>  +static inline int acpi_boot_init(void)
>  +{
>  +	return 0;
>  +}
>  +
>  +static inline int acpi_boot_table_init(void)
>  +{
>  +	return 0;
>  +}
>  +

Nope, that's no good.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
