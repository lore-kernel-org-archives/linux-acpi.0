From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/5] ACPICA: Add acpi_dev_present
Date: Tue, 24 Nov 2015 22:54:35 +0800
Message-ID: <56547A2B.8030401@linaro.org>
References: <cover.1448282995.git.lukas@wunner.de> <20151123233234.GA26361@wunner.de> <5653EA53.8040909@huawei.com> <2460979.tXaWt9xg5Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36717 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbbKXOyn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2015 09:54:43 -0500
Received: by pacdm15 with SMTP id dm15so24555677pac.3
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2015 06:54:43 -0800 (PST)
In-Reply-To: <2460979.tXaWt9xg5Q@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <guohanjun@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>, Mark Brown <broonie@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, David Box <david.e.box@linux.intel.com>

On 11/24/2015 10:22 PM, Rafael J. Wysocki wrote:
> On Tuesday, November 24, 2015 12:40:51 PM Hanjun Guo wrote:
>> On 2015/11/24 7:32, Lukas Wunner wrote:
>>> Hi Robert,
>>>
>>> On Mon, Nov 23, 2015 at 10:22:27PM +0000, Moore, Robert wrote:
>>>>>> acpi_dev_present
>>>> Do you really want to be walking the ACPICA namespace for every call?
>>> That's what the drivers currently do. Typically this is called only once
>>> on initialization by the driver's ->probe callback.
>>>
>>> What did you have in mind instead, cache the result? Or store the HIDs
>>> in the namespace in a hash that can be queried faster?
>>
>> Will those drivers be loaded before the acpi namespace is scanned? if not, I think
>> those IDs already cached, in acpi_init_device_object(),
>>
>> INIT_LIST_HEAD(&device->pnp.ids);
>> ...
>> acpi_set_pnp_ids(handle, &device->pnp, type);
>>
>> please see API acpi_device_hid(), so I think you can introduce a API with
>> acpi_device and HID passed as arguments in scan.c
>
> I'd prefer that to go to utils.c to be honest, even if the namespace needs to
> be walked.

I agree, utils.c is the better place to go.

Thanks
Hanjun
