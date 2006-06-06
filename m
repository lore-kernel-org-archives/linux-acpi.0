From: "Andy Currid" <ACurrid@nvidia.com>
Subject: RE: [patch 12/13] Fix HPET operation on 64-bit NVIDIA platforms
Date: Tue, 6 Jun 2006 08:11:08 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A15D0E56D@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:35405 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S932183AbWFFPLV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2006 11:11:21 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, ak@muc.de, luming.yu@intel.com


This patch won't have any affect on your system; you're running a
VIA-based Intel platform, and this patch only applies to NVIDIA-based
platforms (i.e. nForce chipset).

Andy 

-----Original Message-----
From: Sergio Monteiro Basto [mailto:sergio@sergiomb.no-ip.org] 
Sent: Tuesday, June 06, 2006 08:07
To: akpm@osdl.org
Cc: len.brown@intel.com; linux-acpi@vger.kernel.org; Andy Currid;
ak@muc.de; luming.yu@intel.com
Subject: Re: [patch 12/13] Fix HPET operation on 64-bit NVIDIA platforms

Hi,
I experience this "kernel panic during boot" with acpi=off and IIRC
pci=noacpi, but what I like to know if this can resolve any other
problems on my bug: http://bugzilla.kernel.org/show_bug.cgi?id=6419
http://bugzilla.kernel.org/show_bug.cgi?id=6419#c17

btw I will try this patch anyway
Thanks,

On Thu, 2006-06-01 at 20:18 -0700, akpm@osdl.org wrote:
> From: "Andy Currid" <ACurrid@nvidia.com>
> 
> This patch fixes a kernel panic during boot that occurs on NVIDIA 
> platforms that have HPET enabled.
> 
> When HPET is enabled, the standard timer IRQ is routed to IOAPIC pin 2

> and is advertised as such in the ACPI APIC table - but an earlier 
> workaround in the kernel was ignoring this override.  The fix is to 
> honor timer IRQ overrides from ACPI when HPET is detected on an NVIDIA
platform.
> 
> Signed-off-by: Andy Currid <acurrid@nvidia.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Cc: "Yu, Luming" <luming.yu@intel.com>
> Cc: Andi Kleen <ak@muc.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  arch/x86_64/kernel/io_apic.c |   30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff -puN
arch/x86_64/kernel/io_apic.c~fix-hpet-operation-on-64-bit-nvidia-platfor
ms arch/x86_64/kernel/io_apic.c
> ---
devel/arch/x86_64/kernel/io_apic.c~fix-hpet-operation-on-64-bit-nvidia-p
latforms	2006-06-01 20:17:10.000000000 -0700
> +++ devel-akpm/arch/x86_64/kernel/io_apic.c	2006-06-01
20:17:10.000000000 -0700
> @@ -271,6 +271,18 @@ __setup("enable_8254_timer", setup_enabl  
> #include <linux/pci_ids.h>  #include <linux/pci.h>
>  
> +
> +#ifdef CONFIG_ACPI
> +
> +static int nvidia_hpet_detected __initdata;
> +
> +static int __init nvidia_hpet_check(unsigned long phys, unsigned long

> +size) {
> +	nvidia_hpet_detected = 1;
> +	return 0;
> +}
> +#endif
> +
>  /* Temporary Hack. Nvidia and VIA boards currently only work with
IO-APIC
>     off. Check for an Nvidia or VIA PCI bridge and turn it off.
>     Use pci direct infrastructure because this runs before the PCI
subsystem. 
> @@ -317,11 +329,19 @@ void __init check_ioapic(void) 
>  					return;
>  				case PCI_VENDOR_ID_NVIDIA:
>  #ifdef CONFIG_ACPI
> -					/* All timer overrides on Nvidia
> -				           seem to be wrong. Skip them.
*/
> -					acpi_skip_timer_override = 1;
> -					printk(KERN_INFO 
> -	     "Nvidia board detected. Ignoring ACPI timer override.\n");
> +					/*
> +					 * All timer overrides on Nvidia
are
> +					 * wrong unless HPET is enabled.
> +					 */
> +					nvidia_hpet_detected = 0;
> +					acpi_table_parse(ACPI_HPET,
> +
nvidia_hpet_check);
> +					if (nvidia_hpet_detected == 0) {
> +						acpi_skip_timer_override
= 1;
> +						printk(KERN_INFO "Nvidia
board "
> +						    "detected. Ignoring
ACPI "
> +						    "timer
override.\n");
> +					}
>  #endif
>  					/* RED-PEN skip them on mptables
too? */
>  					return;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
