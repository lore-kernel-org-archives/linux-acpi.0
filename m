From: reeja.john-5C7GfCeVMHo@public.gmane.org
Subject: RE: [FAQ?]How to add dsdt.hex to kernel ?
Date: Mon, 3 Feb 2003 14:35:24 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CB35231B9D59D311B18600508B0EDF2F0531B200@caexmta9.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
    Thanks for the reply. But I was wondering whether I will be able to use this patch. Where is the definition of the variable "AmlCode" and where is it initializing? I searched on the  path linux/drivers/acpi and I couldn't find such a variable. Am I missing something or is it because I am using a different version of the kernel. Please let me know.
Thanks,
Reeja

> -----Original Message-----
> From: Stefan Behnel [mailto:behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org]
> Sent: Saturday, February 01, 2003 4:08 AM
> To: John, Reeja
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [FAQ?][ACPI] How to add dsdt.hex to kernel ?
> 
> 
> Hi!
> 
> reeja.john-5C7GfCeVMHo@public.gmane.org wrote:
>  > I created a custom dsdt.hex for my system for the kernel 
> 2.5.55. How
>  > am I able to add this new dsdt into the kernel?
> 
> That one should really go into a FAQ somewhere (or rather replace the 
> outdated description in the existing FAQ).
> 
> This simple patch allows you to include your DSDT.hex file. I 
> called it 
> "my-dsdt.hex" here, has to be in the directory [linux]/drivers/acpi/, 
> where osl.c is located.
> 
> BTW: As this seems to be a common problem, would there be a 
> way to add 
> it as a standard kernel config option?
> 
> Have fun,
> Stefan Behnel
> 
> 
> --- linux-2.4.21/drivers/acpi/osl.c 2003-01-24 
> 09:59:27.000000000 +0100
> +++ linux/drivers/acpi/osl.c	  2003-01-24 13:36:45.000000000 +0100
> @@ -201,6 +201,9 @@
>   	return AE_OK;
>   }
> 
> +/**/static const
> +#include "my-dsdt.hex"
> +
>   acpi_status
>   acpi_os_table_override (struct acpi_table_header *existing_table,
>   			struct acpi_table_header **new_table)
> @@ -208,7 +211,11 @@
>   	if (!existing_table || !new_table)
>   		return AE_BAD_PARAMETER;
> 
> -	*new_table = NULL;
> +	/**/if (strncmp(existing_table->signature,"DSDT",4))
> +	  *new_table = NULL;
> +	/**/else
> +	  *new_table = (struct acpi_table_header *)AmlCode;
> +
>   	return AE_OK;
>   }
> 
> 
> 



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
