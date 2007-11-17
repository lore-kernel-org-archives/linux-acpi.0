From: Len Brown <lenb@kernel.org>
Subject: Re: [2.6 patch] x86: acpi_pciprobe_dmi_table[] must be __devinitdata
Date: Fri, 16 Nov 2007 21:21:09 -0500
Message-ID: <200711162121.09923.lenb@kernel.org>
References: <20071109060211.GP26163@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33246 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbXKQCVg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Nov 2007 21:21:36 -0500
In-Reply-To: <20071109060211.GP26163@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

applied.

thanks,
-len

On Friday 09 November 2007 01:02, Adrian Bunk wrote:
> This patch fixes the following section mismatches with CONFIG_HOTPLUG=n:
> 
> <--  snip  -->
> 
> ...
> WARNING: vmlinux.o(.data+0x23640): Section mismatch: reference to .init.text.20:can_skip_ioresource_align (between 'acpi_pciprobe_dmi_table' and 'pcibios_irq_mask')
> WARNING: vmlinux.o(.data+0x2366c): Section mismatch: reference to .init.text.20:can_skip_ioresource_align (between 'acpi_pciprobe_dmi_table' and 'pcibios_irq_mask')
> WARNING: vmlinux.o(.data+0x23698): Section mismatch: reference to .init.text.20:can_skip_ioresource_align (between 'acpi_pciprobe_dmi_table' and 'pcibios_irq_mask')
> ...
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 3225b3c19396e0e45f496dfe82e85ebc86951d91 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 2d88f7c..a7536dc 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -13,7 +13,7 @@ static int __devinit can_skip_ioresource_align(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> -static struct dmi_system_id acpi_pciprobe_dmi_table[] = {
> +static struct dmi_system_id acpi_pciprobe_dmi_table[] __devinitdata = {
>  /*
>   * Systems where PCI IO resource ISA alignment can be skipped
>   * when the ISA enable bit in the bridge control is not set
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
