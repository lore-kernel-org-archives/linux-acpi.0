From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi/numa: use (void) parameter list
Date: 09 Mar 2005 01:10:31 -0500
Message-ID: <1110348630.9336.19.camel@d845pe>
References: <20050216163731.0b9e7598.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050216163731.0b9e7598.rddunlap-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2005-02-16 at 19:37, Randy.Dunlap wrote:
> I thought that I had seen this patch, but I can't find
> it just now.
> 
> 
> Add void parameter list to function:
> drivers/acpi/numa.c:173:16: warning: non-ANSI function declaration
> 
> Signed-off-by: Randy Dunlap <rddunlap-3NddpPZAyC0@public.gmane.org>
> 
> diffstat:=
>  drivers/acpi/numa.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -Naurp ./drivers/acpi/numa.c~acpi_numa_func ./drivers/acpi/numa.c
> --- ./drivers/acpi/numa.c~acpi_numa_func        2005-02-15
> 13:48:44.941520896 -0800
> +++ ./drivers/acpi/numa.c       2005-02-16 10:55:16.231088912 -0800
> @@ -170,7 +170,7 @@ acpi_table_parse_srat (
> 
> 
>  int __init
> -acpi_numa_init()
> +acpi_numa_init(void)
>  {
>         int                     result;
> 
> 
> 
> ---
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
