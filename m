From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 6/9] PCI ACPI: Introduce acpi_pm_device_sleep_wake
 function
Date: Thu, 26 Jun 2008 10:12:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806261008230.2811-100000@iolanthe.rowland.org>
References: <200806252331.02963.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57655 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752116AbYFZOM7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2008 10:12:59 -0400
In-Reply-To: <200806252331.02963.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Wed, 25 Jun 2008, Rafael J. Wysocki wrote:

> Index: linux-2.6/drivers/pci/pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.c
> +++ linux-2.6/drivers/pci/pci.c

> +/**
> + * pci_pme_active - enable or disable PCI device's PME# function
> + * @dev: PCI device to handle.
> + * @pm: PCI PM capability offset of the device.
> + * @enable: 'true' to enable PME# generation; 'false' to disable it.
> + *
> + * The caller must verify that the device is capable of generating PME# before
> + * calling this function with @enable equal to 'true'.
> + */
> +static void pci_pme_active(struct pci_dev *dev, int pm, bool enable)
> +{
> +	u16 pmcsr;
> +
> +	if (!pm)
> +		return;
> +
> +	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
> +	/* Clear PME_Status by writing 1 to it and enable PME# */
> +	pmcsr |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
> +	if (!enable)
> +		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
> +
> +	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
> +}

Question: Does the PME Status ever get cleared at any other times?  For 
instance, suppose a PCI device does use PME# to wake up the system.  
Does its status get cleared?

Or suppose a PCI device is runtime-suspended and it generates a wakeup
request?  This will turn on PME# at a time when the system isn't asleep
-- what happens then?  Does it get lost somewhere in the bowels of
ACPI?  Does the PCI core need new code to handle such things?

Alan Stern

