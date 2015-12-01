From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 1/2] ACPI / scan: Fix acpi_bus_id_list bookkeeping
Date: Tue, 1 Dec 2015 14:08:29 +0100
Message-ID: <20151201130829.GB28094@wunner.de>
References: <cover.1448480385.git.lukas@wunner.de>
 <994278b96189033970d0a2add95645110c716fbb.1448480385.git.lukas@wunner.de>
 <565BEC65.90409@huawei.com>
 <565C0568.90905@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:46893 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436AbbLANId (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 08:08:33 -0500
Content-Disposition: inline
In-Reply-To: <565C0568.90905@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, devel@acpica.org, Robert Moore <robert.moore@intel.com>, Mark Brown <broonie@kernel.org>, Hui Wang <hui.wang@canonical.com>, Darren Hart <dvhart@infradead.org>

Hi,

On Mon, Nov 30, 2015 at 04:14:32PM +0800, Hanjun Guo wrote:
> On 2015/11/30 14:27, Hanjun Guo wrote:
> > On 2015/11/26 4:19, Lukas Wunner wrote:
> >> acpi_device_add() allocates and adds an element to acpi_bus_id_list
> >> (or increments the instance count if the device's HID is already
> >> present in the list), but the element is never deleted from the list
> >> nor freed. Fix it.
> > Hmm, I didn't get it here. Seems the device's ID already freed in device core:
> >
> >  In acpi_add_single_object(), acpi_device_release() registered as a callback,
> > ...
> >   result = acpi_device_add(device, acpi_device_release);
> > ...
> >
> > And in acpi_device_release(), it will call acpi_free_pnp_ids() to free the
> > IDs, did I miss some something?
> 
> Sorry, I misread the code, I thought it was the pnn ids connect to the ACPI device,
> actually you are referring to HIDs connecting to acpi_bus_id_list, sorry for the noise.

Yes, I should have been more clear about this in the first place:

When the bus is scanned and acpi_device_add() is called for each device,
not only do we initialize a struct acpi_device and attach it to the
device tree, but we also add an element to acpi_bus_id_list.

Hence there are two ways to detect the presence of a HID: By traversing
the device tree or by iterating over the list. I chose the latter because
it is obviously cheaper and requires less code.

However elements only ever get added to the list, never deleted. I'm not
sure if hotpluggable ACPI devices exist but if they do, this is a bug
which is fixed by this patch.

The list was added with e49bd2dd5a50 ("ACPI: use PNPID:instance_no as
bus_id of ACPI device") 9 years ago and the author even mentioned that
the list elements are never freed:

   "NOTE:       Now I don't take the memory free work in charge.
        If necessary, I can add a reference count in
        struct acpi_device_bus_id, and check the reference and
        when unregister a device, i.e. memory is freed when
        the reference count of a given PNPID is 0."

Best regards,

Lukas
