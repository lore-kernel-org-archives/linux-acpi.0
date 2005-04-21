From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [ACPI] [RFC/PATCH 3/3] ACPI based I/O APIC hot-plug
Date: Thu, 21 Apr 2005 11:22:11 -0600
Message-ID: <1114104131.2784.43.camel@eeyore>
References: <4267AD21.7040006@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <4267AD21.7040006@jp.fujitsu.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>, Greg KH <greg@kroah.com>, acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

> +static struct pci_dev *get_apic_pci_info(acpi_handle handle)

Nitpick: follow function declaration style of file.

> +	struct acpi_pci_id id;
> +	struct pci_bus *bus;
> +	struct pci_dev *dev;
> +
> +	if (ACPI_FAILURE(acpi_get_pci_id(handle, &id)))
> +		return NULL;
> +
> +	bus = pci_find_bus(id.segment, id.bus);
> +	if (!bus)
> +		return NULL;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (dev->devfn != PCI_DEVFN(id.device, id.function))
> +			continue;

Use pci_get_slot() here rather than walking bus->devices yourself.

> +		if ((dev->class >> 8) != PCI_CLASS_SYSTEM_PIC)
> +			continue;
> +		if ((dev->class & 0xff) == 0x10 || (dev->class & 0xff) == 0x20)

What are 0x10 and 0x20?  Looks like they should be #defines in
include/linux/pci_ids.h.

> +static int get_gsi_base(acpi_handle handle, u32 *gsi_base)
> +{
> +	acpi_status status;
> +	int result = -1;
> +	unsigned long gsb;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object *obj;
> +	void *table;
> +
> +	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gsb);
> +	if (ACPI_SUCCESS(status)) {
> +		*gsi_base = (u32)gsb;
> +		return 0;
> +	}
> +
> +	status = acpi_evaluate_object(handle, "_MAT", NULL, &buffer);
> +	if (ACPI_FAILURE(status) || !buffer.length || !buffer.pointer)
> +		return result;

Nothing can modify result before this point, so it'd be clearer
to just "return -1" here.

