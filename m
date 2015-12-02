From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2 1/2] ACPI / scan: Fix acpi_bus_id_list bookkeeping
Date: Wed, 2 Dec 2015 16:56:47 +0800
Message-ID: <565EB24F.8070005@huawei.com>
References: <cover.1448480385.git.lukas@wunner.de> <994278b96189033970d0a2add95645110c716fbb.1448480385.git.lukas@wunner.de> <565BEC65.90409@huawei.com> <565C0568.90905@huawei.com> <20151201130829.GB28094@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:5642 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563AbbLBI6X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 03:58:23 -0500
In-Reply-To: <20151201130829.GB28094@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, devel@acpica.org, Robert Moore <robert.moore@intel.com>, Mark Brown <broonie@kernel.org>, Hui Wang <hui.wang@canonical.com>, Darren Hart <dvhart@infradead.org>

On 2015/12/1 21:08, Lukas Wunner wrote:
> Hi,
>
> On Mon, Nov 30, 2015 at 04:14:32PM +0800, Hanjun Guo wrote:
>> On 2015/11/30 14:27, Hanjun Guo wrote:
>>> On 2015/11/26 4:19, Lukas Wunner wrote:
>>>> acpi_device_add() allocates and adds an element to acpi_bus_id_list
>>>> (or increments the instance count if the device's HID is already
>>>> present in the list), but the element is never deleted from the list
>>>> nor freed. Fix it.
>>> Hmm, I didn't get it here. Seems the device's ID already freed in device core:
>>>
>>>  In acpi_add_single_object(), acpi_device_release() registered as a callback,
>>> ...
>>>   result = acpi_device_add(device, acpi_device_release);
>>> ...
>>>
>>> And in acpi_device_release(), it will call acpi_free_pnp_ids() to free the
>>> IDs, did I miss some something?
>> Sorry, I misread the code, I thought it was the pnn ids connect to the ACPI device,
>> actually you are referring to HIDs connecting to acpi_bus_id_list, sorry for the noise.
> Yes, I should have been more clear about this in the first place:
>
> When the bus is scanned and acpi_device_add() is called for each device,
> not only do we initialize a struct acpi_device and attach it to the
> device tree, but we also add an element to acpi_bus_id_list.
>
> Hence there are two ways to detect the presence of a HID: By traversing
> the device tree or by iterating over the list. I chose the latter because
> it is obviously cheaper and requires less code.
>
> However elements only ever get added to the list, never deleted. I'm not
> sure if hotpluggable ACPI devices exist but if they do, this is a bug
> which is fixed by this patch.

ACPI devices can be hotpluggable :) , but it will have no memory leak I think, it
only increase the instance number for ACPI devices removed and hot-added later,
I don't know if it make sense to do that, for example, if you remove device A and
B with same HID (such as ACPI0007) with your patch added:

remove processor 0, the sysfs for device A /sys/bus/acpi/devices/ACPI0007:00 will be
removed;

remove processer 1, the sysfs for device B /sys/bus/acpi/devices/ACPI0007:01 will be
removed;

But if we add it in reverse with your patch:

Add dprocesser 1, the sysfs /sys/bus/acpi/devices/ACPI0007:00 will be created,

add processor 0...

I'm not sure it will confuse user space or not.

Rafael, what's your opinion here?

Thanks
Hanjun

