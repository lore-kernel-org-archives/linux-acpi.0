From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2 1/2] ACPI / scan: Fix acpi_bus_id_list bookkeeping
Date: Mon, 30 Nov 2015 16:14:32 +0800
Message-ID: <565C0568.90905@huawei.com>
References: <cover.1448480385.git.lukas@wunner.de> <994278b96189033970d0a2add95645110c716fbb.1448480385.git.lukas@wunner.de> <565BEC65.90409@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:2420 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbbK3IPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 03:15:53 -0500
In-Reply-To: <565BEC65.90409@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: devel@acpica.org, Robert Moore <robert.moore@intel.com>, Mark Brown <broonie@kernel.org>, Hui Wang <hui.wang@canonical.com>, Darren Hart <dvhart@infradead.org>

On 2015/11/30 14:27, Hanjun Guo wrote:
> Hi Lucas,
>
> Sorry for the late reply, please see comments below.
>
> On 2015/11/26 4:19, Lukas Wunner wrote:
>> acpi_device_add() allocates and adds an element to acpi_bus_id_list
>> (or increments the instance count if the device's HID is already
>> present in the list), but the element is never deleted from the list
>> nor freed. Fix it.
> Hmm, I didn't get it here. Seems the device's ID already freed in device core:
>
>  In acpi_add_single_object(), acpi_device_release() registered as a callback,
> ...
>   result = acpi_device_add(device, acpi_device_release);
> ...
>
> And in acpi_device_release(), it will call acpi_free_pnp_ids() to free the
> IDs, did I miss some something?

Sorry, I misread the code, I thought it was the pnn ids connect to the ACPI device,
actually you are referring to HIDs connecting to acpi_bus_id_list, sorry for the noise.

Hanjun

