From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] picmode patch v3
Date: Mon, 1 Sep 2003 02:27:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030901012753.GE13467@parcelfarce.linux.theplanet.co.uk>
References: <200308312241.19431.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200308312241.19431.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Aug 31, 2003 at 10:41:19PM +0100, Andrew de Quincey wrote:
> Hi, this is the latest version of my dropback to picmode patch. This version 
> removes the PIC code from the ia64 architecture.

I think this could be simplified ...

> --- linux-2.6.0-test4.orig/include/asm-ia64/acpi.h	2003-08-23 00:59:27.000000000 +0100
> +++ linux-2.6.0-test4/include/asm-ia64/acpi.h	2003-08-31 00:57:29.000000000 +0100
> @@ -112,6 +112,9 @@
>  extern int __initdata nid_to_pxm_map[NR_NODES];
>  #endif
>  
> +/* ACPI-based PIC initialisation */
> +extern int pic_parse_prt (void);
> +
>  #endif /*__KERNEL__*/
>  
>  #endif /*_ASM_ACPI_H*/

+/* ia64 machines don't have PIC controllers */
+static inline int pic_parse_prt(void) { return -1; }

>  #ifdef CONFIG_X86_IO_APIC
>  	/* Program IOAPICs using data from PRT entries. */
>  	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC)
> -		mp_parse_prt();
> + 		if (mp_parse_prt()) 
> + 			acpi_irq_pic_mode();
>  #endif
>  #ifdef CONFIG_IOSAPIC
>  	if (acpi_irq_model == ACPI_IRQ_MODEL_IOSAPIC)
> -		iosapic_parse_prt();
> -#endif
> + 		if (iosapic_parse_prt())
> +			return_VALUE(-ENODEV);
>  
> +	/* IOSAPIC-based machines do not have PICs */
> + 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC)
> +		return_VALUE(-ENODEV);
> +#else // !CONFIG_IOSAPIC
> +   
> + 	/* This one is last, as a catchall */
> + 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC)
> + 		if (pic_parse_prt()) 
> + 			return_VALUE(-ENODEV);
> +#endif // CONFIG_IOSAPIC
> +   

 #ifdef CONFIG_X86_IO_APIC
 	/* Program IOAPICs using data from PRT entries. */
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC)
-		mp_parse_prt();
+ 		if (mp_parse_prt()) 
+ 			acpi_irq_model = ACPI_IRQ_MODEL_PIC;
 #endif
 #ifdef CONFIG_IOSAPIC
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOSAPIC)
-		iosapic_parse_prt();
+ 		if (iosapic_parse_prt())
+			acpi_irq_model = ACPI_IRQ_MODEL_PIC;
 #endif
 
+   
+ 	/* This one is last, as a catchall */
+ 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC)
+ 		if (pic_parse_prt()) 
+ 			return_VALUE(-ENODEV);
+   

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
