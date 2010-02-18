From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 2/8] PCI PM: PCIe PME root port service driver (rev. 5)
Date: Thu, 18 Feb 2010 13:08:23 +0900
Message-ID: <4B7CBD37.9000706@jp.fujitsu.com>
References: <201002172335.47703.rjw@sisk.pl> <201002172339.08865.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201002172339.08865.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Oliver Neukum <oliver@neukum.org>, Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Gary Hade <garyhade@us.ibm.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm sorry for the delayed comments.

> +
> +/**
> + * pcie_pme_interrupt_enable - Enable/disable PCIe PME interrupt generation.
> + * @dev: PCIe root port or event collector.
> + * @enable: Enable or disable the interrupt.
> + */
> +static void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable)
> +{
> +	int rtctl_pos;
> +	u16 rtctl;
> +
> +	rtctl_pos = pci_find_capability(dev, PCI_CAP_ID_EXP) + PCI_EXP_RTCTL;

How about

	rtctl_pos = pci_pcie_cap(dev) + PCI_EXP_RTCTL;

?

The pci_pcie_cap() returns PCIe capability offset saved in struct pci_dev.
By using this, we can avoid redundant search in PCI configuration space.

> +
> +/**
> + * pcie_pme_clear_status - Clear root port PME interrupt status.
> + * @dev: PCIe root port or event collector.
> + */
> +static void pcie_pme_clear_status(struct pci_dev *dev)
> +{
> +	int rtsta_pos;
> +	u32 rtsta;
> +
> +	rtsta_pos = pci_find_capability(dev, PCI_CAP_ID_EXP) + PCI_EXP_RTSTA;

Ditto.


> +/**
> + * pcie_pme_work_fn - Work handler for PCIe PME interrupt.
> + * @work: Work structure giving access to service data.
> + */
> +static void pcie_pme_work_fn(struct work_struct *work)
> +{
> +	struct pcie_pme_service_data *data =
> +			container_of(work, struct pcie_pme_service_data, work);
> +	struct pci_dev *port = data->srv->port;
> +	int rtsta_pos;
> +	u32 rtsta;
> +
> +	rtsta_pos = pci_find_capability(port, PCI_CAP_ID_EXP) + PCI_EXP_RTSTA;

Ditto.


> +/**
> + * pcie_pme_irq - Interrupt handler for PCIe root port PME interrupt.
> + * @irq: Interrupt vector.
> + * @context: Interrupt context pointer.
> + */
> +static irqreturn_t pcie_pme_irq(int irq, void *context)
> +{
> +	struct pci_dev *port;
> +	struct pcie_pme_service_data *data;
> +	int rtsta_pos;
> +	u32 rtsta;
> +	unsigned long flags;
> +
> +	port = ((struct pcie_device *)context)->port;
> +	data = get_service_data((struct pcie_device *)context);
> +
> +	rtsta_pos = pci_find_capability(port, PCI_CAP_ID_EXP) + PCI_EXP_RTSTA;

Ditto.


Thanks,
Kenji Kaneshige
