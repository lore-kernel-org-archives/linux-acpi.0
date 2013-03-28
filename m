From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Thu, 28 Mar 2013 13:57:07 +0100
Message-ID: <2289048.zbdFnrKsCA@vostro.rjw.lan>
References: <2282655.IicBMMa6jN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45558 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004Ab3C1Mtk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:40 -0400
In-Reply-To: <2282655.IicBMMa6jN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

Hi Bjorn,

I wonder what you think about the patch below?

Rafael


On Saturday, March 23, 2013 03:33:03 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It turns out that _Lxx control methods provided by some BIOSes clear
> the PME Status bit of PCI devices they handle, which means that
> pci_acpi_wake_dev() cannot really use that bit to check whether or
> not the device has signalled wakeup.
> 
> For this reason, make pci_acpi_wake_dev() always attempt to resume
> the device it is called for regardless of the device's PME Status bit
> value (that bit still has to be cleared if set at this point,
> though).
> 
> Reported-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci-acpi.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -53,14 +53,15 @@ static void pci_acpi_wake_dev(acpi_handl
>  		return;
>  	}
>  
> -	if (!pci_dev->pm_cap || !pci_dev->pme_support
> -	     || pci_check_pme_status(pci_dev)) {
> -		if (pci_dev->pme_poll)
> -			pci_dev->pme_poll = false;
> +	/* Clear PME Status if set. */
> +	if (pci_dev->pme_support)
> +		pci_check_pme_status(pci_dev);
>  
> -		pci_wakeup_event(pci_dev);
> -		pm_runtime_resume(&pci_dev->dev);
> -	}
> +	if (pci_dev->pme_poll)
> +		pci_dev->pme_poll = false;
> +
> +	pci_wakeup_event(pci_dev);
> +	pm_runtime_resume(&pci_dev->dev);
>  
>  	if (pci_dev->subordinate)
>  		pci_pme_wakeup_bus(pci_dev->subordinate);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
