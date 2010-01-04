From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2/12] PCI / PM: Propagate wake-up enable for PCIe
 devices too
Date: Mon, 4 Jan 2010 15:40:38 -0800
Message-ID: <20100104154038.76a9eedf@jbarnes-piketon>
References: <200912272057.10443.rjw@sisk.pl>
	<200912272100.33117.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-130.bluehost.com ([67.222.38.30]:59957 "HELO
	outbound-mail-130.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753976Ab0ADXkn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 18:40:43 -0500
In-Reply-To: <200912272100.33117.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Oliver Neukum <oliver@neukum.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Shaohua Li <shaohua.li@intel.com>, Francois Romieu <romieu@fr.zoreil.com>

On Sun, 27 Dec 2009 21:00:33 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Having read the PM part of the PCIe 2.0 specification more carefully
> I think that it was a mistake to restrict the wake-up enable
> propagation to non-PCIe devices, because if we do not request
> control of the root ports' PME registers via OSC, PCIe PME is
> supposed to be handled by the platform, just like the non-PCIe PME.
> Even if we do that, the wake-up propagation is done to allow the
> devices to wake up the system from sleep states which involves the
> platform anyway, so it won't hurt.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-acpi.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-acpi.c
> +++ linux-2.6/drivers/pci/pci-acpi.c
> @@ -112,11 +112,7 @@ static bool acpi_pci_can_wakeup(struct p
>  static void acpi_pci_propagate_wakeup_enable(struct pci_bus *bus,
> bool enable) {
>  	while (bus->parent) {
> -		struct pci_dev *bridge = bus->self;
> -		int ret;
> -
> -		ret = acpi_pm_device_sleep_wake(&bridge->dev,
> enable);
> -		if (!ret || pci_is_pcie(bridge))
> +		if (!acpi_pm_device_sleep_wake(&bus->self->dev,
> enable)) return;
>  		bus = bus->parent;
>  	}
> @@ -131,9 +127,7 @@ static int acpi_pci_sleep_wake(struct pc
>  	if (acpi_pci_can_wakeup(dev))
>  		return acpi_pm_device_sleep_wake(&dev->dev, enable);
>  
> -	if (!pci_is_pcie(dev))
> -		acpi_pci_propagate_wakeup_enable(dev->bus, enable);
> -
> +	acpi_pci_propagate_wakeup_enable(dev->bus, enable);
>  	return 0;
>  }

Seems ok to try it out, but as usual with this sort of thing, the real
question is, "What does Windows do?", since wakeup enable ACPI support
for PCIe devices is likely broken unless Windows uses it.

-- 
Jesse Barnes, Intel Open Source Technology Center
