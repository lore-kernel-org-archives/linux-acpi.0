From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [Fwd: [Fwd: patch to include a custom dsdt]]
Date: Mon, 16 Aug 2004 09:20:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040816072049.GA25783@elf.ucw.cz>
References: <1092070755.2217.16.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1092070755.2217.16.camel@dhcppc4>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> This looks handy.
> comments?

It certainly makes life better for developers.

								Pavel

> --- linux-2.6.7/drivers/acpi/Kconfig.orig	2004-07-17 10:34:39.000000000 +0200
> +++ linux-2.6.7/drivers/acpi/Kconfig	2004-07-17 10:28:11.000000000 +0200
> @@ -204,6 +204,23 @@
>  	  If you have a legacy free Toshiba laptop (such as the Libretto L1
>  	  series), say Y.
>  
> +config ACPI_CUSTOM_TABLE
> +	bool "Include Custom ACPI Table"
> +	depends on X86
> +	depends on ACPI_INTERPRETER
> +	default ""
> +	help
> +	  Thist option is to load a custom acpi dsdt table, e.g. for buggy acpi 
> +	  implementations like on DELL inspiron 5100
> +
> +config ACPI_CUSTOM_TABLE_FILE
> +	string "Custom ACPI Table file to include"
> +	depends on ACPI_CUSTOM_TABLE
> +	default ""
> +	help
> +	  please enter the full path name to the file wich includes the AmlCode delclaration
> +
> +
>  config ACPI_DEBUG
>  	bool "Debug Statements"
>  	depends on ACPI_INTERPRETER
> --- linux-2.6.7/drivers/acpi/osl.c.orig	2004-07-17 08:39:55.000000000 +0200
> +++ linux-2.6.7/drivers/acpi/osl.c	2004-07-17 10:31:51.000000000 +0200
> @@ -55,6 +55,9 @@
>      void		    *context;
>  };
>  
> +#ifdef CONFIG_ACPI_CUSTOM_TABLE
> +#include CONFIG_ACPI_CUSTOM_TABLE_FILE
> +#endif
>  
>  #ifdef ENABLE_DEBUGGER
>  #include <linux/kdb.h>
> @@ -235,7 +238,14 @@
>  	if (!existing_table || !new_table)
>  		return AE_BAD_PARAMETER;
>  
> +#ifdef CONFIG_ACPI_CUSTOM_TABLE
> +	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
> +		*new_table = (struct acpi_table_header*)AmlCode;
> +	else
> +		*new_table = NULL;
> +#else
>  	*new_table = NULL;
> +#endif
>  	return AE_OK;
>  }
>  




-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
