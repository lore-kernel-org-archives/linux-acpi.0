From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] warning: implicit declaration of function mp_config_ioapic_for_sci
Date: Wed, 9 Oct 2002 14:42:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021009144232.Z18545@parcelfarce.linux.theplanet.co.uk>
References: <1034060159.1541.24.camel@darkstar.portugal> <20021008125912.Q18545@parcelfarce.linux.theplanet.co.uk> <1034140205.1666.23.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1034140205.1666.23.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>; from sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org on Wed, Oct 09, 2002 at 01:14:13AM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 09, 2002 at 01:14:13AM -0400, Sérgio Monteiro Basto wrote:
> First of all thanks for replying to this email and for the information.
> 
> so I remade the patch, and (I think) now is a good patch, because is not
> need declared the mp_config_ioapic_for_sci function.

> --- linux-2.4.19orig/drivers/acpi/bus.c	Sun Oct  6 21:39:56 2002
> +++ linux-2.4.19acpi/drivers/acpi/bus.c	Wed Oct  9 01:00:12 2002
> @@ -1883,10 +1883,14 @@
>  
>  #ifdef CONFIG_X86
>          /* Ensure the SCI is set to level-triggered, active-low */
> +#ifdef CONFIG_X86_IO_APIC
>          if (acpi_ioapic)
>           	mp_config_ioapic_for_sci(acpi_fadt.sci_int);
>  	else
>                  eisa_set_level_irq(acpi_fadt.sci_int);
> +#else
> +	eisa_set_level_irq(acpi_fadt.sci_int);
> +#endif
>  #endif
>  
>  	status = acpi_enable_subsystem(ACPI_FULL_INITIALIZATION);

the normal way to do this kind of this is:

>  #ifdef CONFIG_X86
>          /* Ensure the SCI is set to level-triggered, active-low */
> +#ifdef CONFIG_X86_IO_APIC
>          if (acpi_ioapic)
>           	mp_config_ioapic_for_sci(acpi_fadt.sci_int);
>  	else
> +#endif
>                  eisa_set_level_irq(acpi_fadt.sci_int);
>  #endif

(could someone fix the indenting here?  it's a mess!)

-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
