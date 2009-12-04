From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 10/12] PCI / ACPI PM: Platform support for PCI PME
	wake-up (rev. 4)
Date: Fri, 4 Dec 2009 16:21:07 +0000
Message-ID: <20091204162107.GA13371@srcf.ucam.org>
References: <200911160047.46299.rjw@sisk.pl> <200911291632.44763.rjw@sisk.pl> <200911291642.20172.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200911291642.20172.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oliver Neukum <oliver@neukum.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Francois Romieu <romieu@fr.zoreil.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Nov 29, 2009 at 04:42:20PM +0100, Rafael J. Wysocki wrote:

> +	if (event == ACPI_NOTIFY_DEVICE_WAKE) {
> +		if (nb->dev->wakeup.run_wake_count > 0) {
> +			if (nb->pci_bus)
> +				pci_pme_wakeup_bus(nb->pci_bus);
> +			if (nb->pci_dev)
> +				pci_pme_wakeup(nb->pci_dev);

We may receive wakeup events on devices that aren't PME capable, which 
is the case for uhci on my test box. In that case we probably want to 
wake them up unconditionally.

+                       if (nb->pci_dev) {
+                               if (nb->pci_dev->pm_cap)
+                                       pci_pme_wakeup(nb->pci_dev);
+                               else
+                                       pm_request_resume(&nb->pci_dev->dev);

seems to work, though possibly we should assume that the firmware knows 
best and always schedule a wake in respose to a resume request?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
