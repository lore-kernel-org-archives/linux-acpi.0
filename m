From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] debug.c: don't invent NUM_OF
Date: 07 Jan 2005 13:39:12 -0500
Message-ID: <1105123150.18166.2646.camel@d845pe>
References: <41DEC35C.9020604@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41DEC35C.9020604-3NddpPZAyC0@public.gmane.org>
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

applied.

thanks,
-len

On Fri, 2005-01-07 at 12:14, Randy.Dunlap wrote:
> Use kernel.h for ARRAY_SIZE() instead of using local NUM_OF().
> I.e., use kernel-supplied functions or macros when available.
> 
> Signed-off-by: Randy Dunlap <rddunlap-3NddpPZAyC0@public.gmane.org>
> 
> diffstat:=
>   drivers/acpi/debug.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
> 
> ---
> 
> 
> 
> 
> ______________________________________________________________________
> 
> diff -Naurp ./drivers/acpi/debug.c~acpi_array_size ./drivers/acpi/debug.c
> --- ./drivers/acpi/debug.c~acpi_array_size	2004-12-24 13:35:23.000000000 -0800
> +++ ./drivers/acpi/debug.c	2005-01-07 07:56:19.279389952 -0800
> @@ -4,6 +4,7 @@
>  
>  #include <linux/proc_fs.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
>  #include <linux/moduleparam.h>
>  #include <asm/uaccess.h>
>  #include <acpi/acpi_drivers.h>
> @@ -87,7 +88,6 @@ const struct acpi_dlevel acpi_debug_leve
>  	ACPI_DEBUG_INIT(ACPI_LV_FULL_TABLES),
>  	ACPI_DEBUG_INIT(ACPI_LV_EVENTS),             
>  };
> -#define NUM_OF(v)	( sizeof(v)/sizeof(v[0]) )
>  
>  static int
>  acpi_system_read_debug (
> @@ -109,7 +109,7 @@ acpi_system_read_debug (
>  
>  	switch ((unsigned long) data) {
>  	case 0:
> -		for (i = 0; i < NUM_OF(acpi_debug_layers); i++) {
> +		for (i = 0; i < ARRAY_SIZE(acpi_debug_layers); i++) {
>  			p += sprintf(p, "%-25s\t0x%08lX [%c]\n",
>  				acpi_debug_layers[i].name,
>  				acpi_debug_layers[i].value,
> @@ -126,7 +126,7 @@ acpi_system_read_debug (
>  			acpi_dbg_layer);
>  		break;
>  	case 1:
> -		for (i = 0; i < NUM_OF(acpi_debug_levels); i++) {
> +		for (i = 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
>  			p += sprintf(p, "%-25s\t0x%08lX [%c]\n",
>  				acpi_debug_levels[i].name,
>  				acpi_debug_levels[i].value,



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
