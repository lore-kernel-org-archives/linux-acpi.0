From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch] 2.6.1-mm3 acpi frees free irq0
Date: 26 Jan 2004 15:30:31 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075149023.2484.4.camel@dhcppc4>
References: <16390.43574.867869.286685@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16390.43574.867869.286685-4mDQ13Tdud8Jw5R7aSpS0dP8p4LwMBBS@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Accepted.

thanks,
-Len

On Thu, 2004-01-15 at 09:56, Jes Sorensen wrote:
> Hi,
> 
> There is a bug in the ACPI code found in 2.6.1-mm3 where if it can't
> find the interrupt source for the ACPI System Control Interrupt Handler,
> it end up trying to free irq 0.
> 
> Included patch fixes the problem.
> 
> Cheers,
> Jes
> 
> --- linux-2.6.1-mm3/drivers/acpi/osl.c~	Wed Jan 14 05:00:25 2004
> +++ linux-2.6.1-mm3/drivers/acpi/osl.c	Thu Jan 15 06:43:28 2004
> @@ -257,13 +257,13 @@
>  		return AE_OK;
>  	}
>  #endif
> -	acpi_irq_irq = irq;
>  	acpi_irq_handler = handler;
>  	acpi_irq_context = context;
>  	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
>  		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
>  		return AE_NOT_ACQUIRED;
>  	}
> +	acpi_irq_irq = irq;
>  
>  	return AE_OK;
>  }
> @@ -271,12 +271,13 @@
>  acpi_status
>  acpi_os_remove_interrupt_handler(u32 irq, OSD_HANDLER handler)
>  {
> -	if (acpi_irq_handler) {
> +	if (irq) {
>  #if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
>  		irq = acpi_irq_to_vector(irq);
>  #endif
>  		free_irq(irq, acpi_irq);
>  		acpi_irq_handler = NULL;
> +		acpi_irq_irq = 0;
>  	}
>  
>  	return AE_OK;



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
