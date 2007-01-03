From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC 2/2] don't enable link device in IOAPIC mode
Date: Wed, 3 Jan 2007 17:41:32 -0500
Message-ID: <200701031741.32746.lenb@kernel.org>
References: <1165886792.19586.26.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54866 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932066AbXACWmT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Jan 2007 17:42:19 -0500
In-Reply-To: <1165886792.19586.26.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Stian Jordet <stian_web@jordet.nu>, Andrew Morton <akpm@osdl.org>

On Monday 11 December 2006 20:26, Shaohua Li wrote:
> In Stian's system, if link device is enabled in IOAPIC mode, pci device
> will connect to link device and link device connect to IOAPIC pin. That
> is the device's interrupt is decided by link's irq. If link device is
> disabled, pci device is connected to IOAPIC pin.
> There are two devices who share one link device in pic mode, but in
> IOAPIC mode, _PRT table reported one device connected to IOAPIC pin and
> the other connected to the link device. If the link device is enabled,
> the device connected to IOAPIC pin directly will break as _PRT reported
> interrupt for the device doesn't reflect the case link device is
> enabled. If we leave the link device disabled, the device which
> connected to the link device doesn't break. It appears the link device
> is just used to get an interrupt number instead of for real interrupt
> routing. So in this patch, if current irq model is IOAPIC, we will leave
> link device disabled and just use its active irq number.
> 
> Signed-off-by: Shaohua Li<shaohua.li@intel.com>
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index d53bd98..655bb49 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -527,6 +527,10 @@ static int acpi_pci_link_allocate(struct
>  	int i;
>  
>  
> +	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC && link->irq.active) {
> +		link->irq.initialized = 1;
> +		return 0;
> +	}
>  	if (link->irq.initialized) {
>  		if (link->refcnt == 0)
>  			/* This means the link is disabled but initialized */

Earlier I NAK'd this on the assertion that it would cause some devices to
not get interrupts.

I've now confirmed that assertion was correct.

Annforce2 board uses Link APC3 to connect
int-A of its PCI slot to the IOAPIC, and the link
is disabled by default:

ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.

Before this patch, an e100 in that slot works:

ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
(and eth1 interface works properly)

And after this patch an e100 in that slot does not work:
(APC3 is not enabled, and interface does not come up)
Bringing up interface eth1:
Determining IP information for eth1...PING 192.168.0.1 (192.168.0.1) from 192.168.0.17 eth1: 56(84) bytes of data.

--- 192.168.0.1 ping statistics ---
3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2010ms
, pipe 3
 failed.
[FAILED]                                                                                                                                  

thanks,
-Len
