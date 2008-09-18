From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 4/11]makeing dock driver supports bay and battery hotplug
Date: Thu, 18 Sep 2008 19:10:02 +0200
Message-ID: <200809181910.03573.trenn@suse.de>
References: <1219889038.29375.29.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:53151 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbYIRRKG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Sep 2008 13:10:06 -0400
In-Reply-To: <1219889038.29375.29.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

Sorry for the late reply...


On Thursday 28 August 2008 04:03:58 Shaohua Li wrote:
> Making dock driver supports bay and battery hotplug. They are all
> regarded as dock, and unified handled.
>
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
...
> +
> +static int is_battery(acpi_handle handle)
> +{
> +	struct acpi_device_info *info;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	int ret = 1;
> +
> +	if (!ACPI_SUCCESS(acpi_get_object_info(handle, &buffer)))
> +		return 0;
> +	info = buffer.pointer;
> +	if (!(info->valid & ACPI_VALID_HID))
> +		ret = 0;
> +	else
> +		ret = !strcmp("PNP0C0A", info->hardware_id.value);
> +
> +	kfree(buffer.pointer);
Better get the device and then use:
const struct acpi_device_id battery_device_ids[] = {
        {"PNP0C0A", 0},
        {"", 0},
};
acpi_match_device_ids(struct acpi_device *device, battery_device_ids);
No need to allocate memory. This also matches batteries where the ID might be 
hidden in the CID list.
...

Something general:
I do not like the idea of this approach.
Battery and ATA device do get an eject notification?
Why can't they handle things themselves?
What is the gain to make battery and ata "dock" capable devices?
What if a PCI(e) device or whatever other device is also connected to the 
docking station. Do we want to add all devices attached to a dock station 
statically?

Would it make sense to add (if notifications are sent to these even this 
should not be needed):
  .eject
  .dock
functions. The dock driver can then go down the tree and call all children's 
eject functions.

I wonder how this can be solved in a more generic way.

Also this patchset mixes up sever fixes and dock design changes patches.
It would be great if the fixes can just go into test, not sure about the 
design change...

    Thomas
