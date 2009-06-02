From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 08/10] ACPI: simplify acpi_pci_irq_add_prt() API
Date: Tue, 2 Jun 2009 11:30:15 -0600
Message-ID: <200906021130.15951.bjorn.helgaas@hp.com>
References: <20090602152351.7346.48697.stgit@bob.kio> <20090602152516.7346.24236.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090602152516.7346.24236.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 02 June 2009 09:25:16 am Alex Chiang wrote:
> A PCI domain cannot change as you descend down subordinate buses, which
> makes the 'segment' argument to acpi_pci_irq_add_prt() useless.
> 
> Change the interface to take a struct pci_bus *, from whence we can derive
> the bus number and segment. Reducing the number of arguments makes life
> simpler for callers.

Nice patch.

> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 25ddbb6..aa67f72 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -537,8 +537,9 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>  	 */
>  	status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
>  	if (ACPI_SUCCESS(status))
> -		result = acpi_pci_irq_add_prt(device->handle, root->id.segment,
> -					      root->id.bus);
> +		result = acpi_pci_irq_add_prt(device->handle,
> +					      pci_find_bus(root->id.segment,
> +							   root->id.bus));

I think you can just do this:

	acpi_pci_irq_add_prt(device->handle, root->bus);

Bjorn
