From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI mode change...
Date: Thu, 25 Jul 2002 11:15:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <59885C5E3098D511AD690002A5072D3C07990D7E@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, alex_williamson-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 
[snip explanation]

After reading your explanation, I'm still unclear...In light of the checks
we are doing in evxfevnt.c acpi_enable(), can you explain why these 3
additional checks are also needed? I would think that systems with 0
fadt->acpi_enable, acpi_disable, or smi_cmd, SCI_EN would already be 1, so
hw_set_mode would never be called, yes?

Regards -- Andy

> diff -Nura linux-0709/drivers/acpi/hardware/hwacpi.c 
> linux-ia64-0622+0709/drivers/acpi/hardware/hwacpi.c
> --- linux-0709/drivers/acpi/hardware/hwacpi.c	Tue Jul  9 20:02:07 2002
> +++ linux-ia64-0622+0709/drivers/acpi/hardware/hwacpi.c	
> Tue Jul  9 20:54:52 2002
> @@ -96,6 +96,14 @@
>  
>  	ACPI_FUNCTION_TRACE ("Hw_set_mode");
>  
> +
> +	if (mode == acpi_hw_get_mode())
> +		return_ACPI_STATUS (AE_OK);
> +
> +	/* If no SMI_CMD, system does not support SMI */
> +	if (!acpi_gbl_FADT->smi_cmd)
> +		return_ACPI_STATUS (AE_NO_HARDWARE_RESPONSE);
> +
>  	switch (mode) {
>  	case ACPI_SYS_MODE_ACPI:
>  
> @@ -108,6 +116,10 @@
>  
>  	case ACPI_SYS_MODE_LEGACY:
>  
> +		/* If both enable/disable are zero, legacy mode 
> is not supported */
> +		if (!acpi_gbl_FADT->acpi_enable && 
> !acpi_gbl_FADT->acpi_disable)
> +			return_ACPI_STATUS (AE_NO_HARDWARE_RESPONSE);
> +
>  		/*
>  		 * BIOS should clear all fixed status bits and 
> restore fixed event
>  		 * enable bits to default


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
