From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Always rescan the slot for new
 devices
Date: Wed, 30 Oct 2013 07:57:46 -0600
Message-ID: <1383141466.4097.163.camel@ul30vt.home>
References: <1383136836-15306-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1383136836-15306-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2013-10-30 at 14:40 +0200, Mika Westerberg wrote:
> Commit 2dc4128 (ACPI / hotplug / PCI: Avoid doing too much for spurious
> notifies) changed the enable_slot() to check return value of pci_scan_slot()
> and if it is zero return early from the function. It means that there were
> no new devices in this particular slot.
> 
> However, if a device appeared deeper in the hierarchy the code now ignores
> it causing things like Thunderbolt chaining fail to recognize new devices.
> 
> The problem with Alex Williamson's machine was solved with commit
> a47d8c8 (ACPI / hotplug / PCI: Avoid parent bus rescans on spurious device
> checks) and hence we should be able to restore the original functionality
> that we always rescan on bus check notification.
> 
> On a device check notification we still check what acpiphp_rescan_slot()
> returns and on zero bail out early.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Alex,
> 
> Are you able to check if your machine still works and doesn't slow down
> during boot after this patch is applied?

Looks ok to me, no new console output or boot delay.  Thanks,

Alex

>  drivers/pci/hotplug/acpiphp_glue.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index be12fbf..1ea7523 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -552,9 +552,8 @@ static void __ref enable_slot(struct acpiphp_slot *slot)
>  	struct acpiphp_func *func;
>  	int max, pass;
>  	LIST_HEAD(add_list);
> -	int nr_found;
>  
> -	nr_found = acpiphp_rescan_slot(slot);
> +	acpiphp_rescan_slot(slot);
>  	max = acpiphp_max_busnr(bus);
>  	for (pass = 0; pass < 2; pass++) {
>  		list_for_each_entry(dev, &bus->devices, bus_list) {
> @@ -574,9 +573,6 @@ static void __ref enable_slot(struct acpiphp_slot *slot)
>  		}
>  	}
>  	__pci_bus_assign_resources(bus, &add_list, NULL);
> -	/* Nothing more to do here if there are no new devices on this bus. */
> -	if (!nr_found && (slot->flags & SLOT_ENABLED))
> -		return;
>  
>  	acpiphp_sanitize_bus(bus);
>  	acpiphp_set_hpp_values(bus);
