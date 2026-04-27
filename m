Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E59366074;
	Mon, 27 Apr 2026 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290410; cv=none; b=Ktymz1GLOfoIM8eYWsIgUSzlEFXqNb3S3D1FhGDCVVlWElWG1dK4Vk/xHNfrMzUtJf/NXCzkzLzsWhN0IDCw1F6jaGrLzg0lXFJEQThFPx0AviN9gyp0ODao/AX2O3FWDwOpp9KkesqFjcF6bZJqTlsSGbiRbi9vqkwRn48JZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290410; c=relaxed/simple;
	bh=iaiunDXe+2QoarPcUUnp2UcRQo47FqdkPGg1oMdnwYE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EpzFuhfxMo7oVwthreFW6vY0ifVosqkoCVNZLhKJA/cwbdnexSxvcMNsu4VzBlKawIxwFhaC0WO+BrFiYiY9j7KIkjQWNP5Ku4CG8TGVB9KOMh9dDF5DSXKYWToSDR6fsi5azqr0q9fgbJ71/Hfgqi9nfsnyX5X8/WTQPXcPzdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZYr1a/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZYr1a/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8E5C19425;
	Mon, 27 Apr 2026 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777290410;
	bh=iaiunDXe+2QoarPcUUnp2UcRQo47FqdkPGg1oMdnwYE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=KZYr1a/c04yY9eWs+1aZPesUJh7ZmmTNxJnUmdk3v8PfOfQGCkPt9u3uQaepSnC8+
	 o0/tkfKrH8jUwcOElBu1TgRobFyW+uxUZy7DmCJ9ooHHgQIA59UsdEtdZMdzcF/Zt0
	 Ebirvltg4vmNkfIyxYGG9y8mmG2VMtXd6VnrDVwfZvK8T4XWLgnogj8etLvKCQ4+Ko
	 VKZHoMggTGeIiGlcP+xY9qoUFjh+4gc68BXaxV10DyklLSmPDJBEShGKwsYZRdWTOz
	 VIwf5BgacIXoVypcmY1F96EpXNqjZdgkX9KkEZQuqbiqIoTXc7hE1NadDKHtowFAjw
	 MAUE6EpEmIr+Q==
Message-ID: <ea9d6361-451f-4055-bb78-c9b2ad48c8b5@kernel.org>
Date: Mon, 27 Apr 2026 13:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
From: Hans de Goede <hansg@kernel.org>
To: Mario Limonciello <superm1@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Marco Scardovi <mscardovi95@gmail.com>
Cc: Francesco Lauritano <francesco.lauritano1@protonmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "westeri@kernel.org" <westeri@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
References: <e8ed4d4e-37e1-4577-bf80-62fcefbef7dc@kernel.org>
 <ReQS8sQSGy3UTuG6tyPvoOb8_037sC6A2yXsSFNuXY1PlTFtCcDHnjf8vufEsk8avBSIL46U0qE-ZjTJD1xsbVYZ6_d2-wlTOZ2NJ2coTsc=@protonmail.com>
 <20251218063954.GT2275908@black.igk.intel.com>
 <b57b44c3-ea96-4189-8b70-71bf4a80d29b@kernel.org>
 <20251218103831.GW2275908@black.igk.intel.com>
 <51f999d7-2064-47dc-8d9b-e262588bfbdb@gmail.com>
 <20260422090709.GB557136@black.igk.intel.com>
 <4e55e31e-a5e8-4098-8a7f-bb52476b882a@gmail.com>
 <20260422095558.GC557136@black.igk.intel.com>
 <5a36760d-5d1e-4eee-9006-3fed042aa2cd@gmail.com>
 <20260423044211.GD557136@black.igk.intel.com>
 <3d562963-9581-4e0f-b9a0-5f0fe28d2495@kernel.org>
 <c55b55ea-a8d5-481e-916f-eb92aeb2e06d@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <c55b55ea-a8d5-481e-916f-eb92aeb2e06d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 27-Apr-26 13:46, Hans de Goede wrote:
> Hi,
> 
> On 23-Apr-26 07:15, Mario Limonciello wrote:
>> On 4/22/26 23:42, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Wed, Apr 22, 2026 at 02:08:29PM +0200, Marco Scardovi wrote:
>>>>>> Assuming all the variants suffer the same problem would it be ok to use a
>>>>>> wildcard for it?
>>>>> Yeah, we could expand it to all "ROG Strix G16" I think:
>>>>>
>>>>> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
>>>>> index a0116f004975..e3a6111854e8 100644
>>>>> --- a/drivers/gpio/gpiolib-acpi-quirks.c
>>>>> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
>>>>> @@ -392,6 +392,23 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>>>>>                .ignore_wake = "VEN_0488:00@355",
>>>>>            },
>>>>>        },
>>>>> +    {
>>>>> +        /*
>>>>> +         * The ASUS ROG Strix G16 (2025) ACPI GPIO configuration
>>>>> +         * causes acpi_gpio_handle_deferred_request_irqs() to
>>>>> +         * stall for ~36 seconds during boot so ignore the two
>>>>> +         * interrupts involved.
>>>>> +         *
>>>>> +         * Found in BIOS G614PP.307.
>>>>> +         */
>>>>> +        .matches = {
>>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "ROG Strix G16"),
>>>>> +        },
>>>>> +        .driver_data = &(struct acpi_gpiolib_dmi_quirk) {
>>>>> +            .ignore_interrupt = "AMDI0030:00@21,AMDI0030:00@24",
>>>>> +        },
>>>>> +    },
>>>>>        {} /* Terminating entry */
>>>>>    };
>>>> As for now it seems working. I've reverted it on my kernel as I prefer
>>>> remain as much as possible close to the CachyOS' one but hopefully it will
>>>> be implemented on 7.1, if someone propose the patch and it is accepted. It
>>>> would be amazing to see Asus more interested on Linux and more strict with
>>>> their BIOS but in the end I understand it's like asking for the moon.
>>>
>>> Okay thanks for checking. I guess this is what we have to live with for now
>>> until someone finds a better way of dealing with these.
>>>
>>> @Francesco, would you like to submit a new version of the patch similar to
>>> above or you want me to do that?
>>
>> Hans suggested that we might want to look at ripping out this edge triggered events at boot earlier in the thread.
>>
>> https://lore.kernel.org/platform-driver-x86/20260423044211.GD557136@black.igk.intel.com/T/#mdca882e6606d3a894ec7499d3b742d040933dbdb
>>
>> Hans - as you pointed out that the Surface lid state is the only real issue left and you happen to have one do you think you could work up some patches?
> 
> Right, so I read further in the thread that Armin has a maybe better suggestion,
> after that has been merged I can check a bunch of the current devices with
> .no_edge_events_on_boot which I still have and see if those quirks can be
> dropped now.
> 
> But the above quirk for the ASUS ROG Strix G16 (2025) does not use
> .no_edge_events_on_boot which just disables the initial run of
> the ACPI event handler at boot. Instead it uses:
> 
>             .ignore_interrupt = "AMDI0030:00@21,AMDI0030:00@24",
> 
> which *completely* disables the ACPI event handlers for the mentioned pins.
> 
> So for the 36-second boot delay issue we first need to see if
> switching to ".no_edge_events_on_boot = true" helps.
> 
> Marco (Scardovi) can you test if passing gpiolib_acpi.run_edge_events_on_boot=-1
> also fixes the 36 second boot delay ?

Hit send too soon, that should be:

gpiolib_acpi.run_edge_events_on_boot=0

Regards,

Hans


