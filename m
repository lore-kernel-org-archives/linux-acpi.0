Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B523B9D80
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293701; cv=none; b=p91w7Gav+N7n/LwBBbyT5lHFeBg0iKvsaYcxQG85ZeQpISJVTXDlF4iRYISEhlEv6nBGQr3lDj4ag8iOvc2uhTVo6ov4TzJ1xsCDgkaJsy9Cse7VICyG2A7+5XDw0pbxnoEss9RFkPduIcGLyqDMkd5+RaSw8DFIKuqFh7eUDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293701; c=relaxed/simple;
	bh=2vEY9g+jd2zsiuvJOyMZ3k5klcsAKucqskQWVdm7nIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axFYH9TP2YLudDJwYRR93URDxHCAWwOuv77grBC0a5QYgciid0+ESue7hQhejQJtoB6TXqXQwHrlwFpKm4SsnD/pFSTzwtNN7XjMEMwbF8RKpPWtmzQ0oS8zTJjaVKpq5K73buEtbXByQfpcNuPeVB2c4QMzd4qQZ8rrZ7unZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp5MbLO0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp5MbLO0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so87149565e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293698; x=1777898498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0ouDnSC+T9ZSB+2JJ/MTzlB9sk99toFQYA8zN4EEOs=;
        b=kp5MbLO0VCy1JbI5L+iD8oIg12pUFRmbJDNRhWo2QAQNpVOTvxC4Ot2RWO7Xlgu0xh
         T6FDg7KEk7zelFW7VbHD14cWrPLQJD8kMQpmmuA0TgDVMLdrbzFGOkdSUur1ZkM3lUA4
         f4i95SURw4yIS/i3kWmsqn7X5GY4yAh13k1hhaxbXMG0fn7+CN1+KV8oa8dTX9gdYrEM
         4r2JRfn+XN45JswjwQunEPGjXpNbjOw2mRC991ARn0HR7hcxpJE51LJCXO9PMiraMo/u
         PJdyXf0vytYPjK2T9Lnwlqh4jGL4Jh1xF42maNHIISl4KxkGg96ydhkNDAiYFZpaIW39
         RBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293698; x=1777898498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0ouDnSC+T9ZSB+2JJ/MTzlB9sk99toFQYA8zN4EEOs=;
        b=cfVua0aDbuF8bPhMXxOYNid0ZuQpbSQ0c49FUcs1jWuEoKCG8uhtYFI3i33SkO2nGi
         rwpFXsDAujggXJ/8VfmBqUJPBKiGHX3ngFKonL0W1HQZAuMJh9AO+xXVgIuoKODjtCu5
         5ccuNhqFT0JZVJs3PF7SYyvpoW5z+NoNEa8sQHS73N8OpfVD0V02sUt+dFfYbgufagDE
         nMS+1TM91WI8Mtv+gYOG4clcDL5e4y06ym0VjRGHFPe5d0C5GZhzZt3qP3QVaH69TW+p
         kG6tQiSHYxbLFDGyBMTsHDOzITiNs7aMDFGQ+4wleNX4vjraf47IQud3V27XNpG6P0QL
         R/KQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4hvf0B5GaGGHA5A9dTASMWF9yPykKHP41o6KJ+ifTBoeqDFr7iFkqDaf3ooz0s7he+F5xslFfWtrt@vger.kernel.org
X-Gm-Message-State: AOJu0YwInCzTDXwlB9+ZRxGO/FXfOIIKfiNJzrJLPmJCEkU6o/KRoPK1
	MICpzaaq1Xr2VY/lIF2vlqNh0zYT5hYnt68DADl2/4SzArzuCNGjx6/x
X-Gm-Gg: AeBDietYdBg0d/e4duMGL7BMDf1hQ+JW2eUt/+YwGMmyv7743JB59KS3+KqAAak9i+X
	M3F1KWVRUYNjcEUQTXvi2ceGpCWKxV1rHECoBn0RrPp1XlCN+19uKYrRNS5qqD0IpOkb36JQbE0
	Jf1wrtoyvdFkmEu6WNeDyY4YHpKWNpchrbP27wazSX7GRi1Erx6o9xOid4B4l33ySyiFBjuWJiZ
	QAGcQg+1Et/Y8ue7oaVa9pRP8n6CjrxO0jq/P2wDtxx+oJnr6Rg1ml03MdB8nhZGP9/PRw96XXE
	VTPRvn9xyu7xlmWc2MoRJLGiOxiSfrbdKehdc6PsU9uGf+0rNDgkEPt/ArmO7XDCAzgxcbljeXO
	wp4bPre3oXVwIguGHPTxv2GRY9brH+u4tf7CtTvgoPUM84ILBOY/271zGZez7LJGqeVaS/pT8Xl
	pNG3Qd1GWsvYbQziHBGViqLK0ewtVvt5GZFw26N6XVq9QLc/NWaAzPG3bqr04aRFYkvxO21TC9s
	5OaGWs=
X-Received: by 2002:a05:600c:3150:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-488fb79df09mr631479005e9.31.1777293698059;
        Mon, 27 Apr 2026 05:41:38 -0700 (PDT)
Received: from ?IPV6:2a01:e11:202b:40:a4dd:2777:84a8:bc7b? ([2a01:e11:202b:40:a4dd:2777:84a8:bc7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm948747075e9.6.2026.04.27.05.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 05:41:37 -0700 (PDT)
Message-ID: <edac84e9-93c0-4248-b28f-c121583b9f65@gmail.com>
Date: Mon, 27 Apr 2026 14:41:36 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
 Francesco Lauritano <francesco.lauritano1@protonmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "westeri@kernel.org" <westeri@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
References: <b57b44c3-ea96-4189-8b70-71bf4a80d29b@kernel.org>
 <20251218103831.GW2275908@black.igk.intel.com>
 <51f999d7-2064-47dc-8d9b-e262588bfbdb@gmail.com>
 <20260422090709.GB557136@black.igk.intel.com>
 <4e55e31e-a5e8-4098-8a7f-bb52476b882a@gmail.com>
 <20260422095558.GC557136@black.igk.intel.com>
 <5a36760d-5d1e-4eee-9006-3fed042aa2cd@gmail.com>
 <20260423044211.GD557136@black.igk.intel.com>
 <3d562963-9581-4e0f-b9a0-5f0fe28d2495@kernel.org>
 <c55b55ea-a8d5-481e-916f-eb92aeb2e06d@kernel.org>
 <20260427122806.GN557136@black.igk.intel.com>
Content-Language: en-US
From: Marco Scardovi <mscardovi95@gmail.com>
In-Reply-To: <20260427122806.GN557136@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Il 27/04/26 14:28, Mika Westerberg ha scritto:
> On Mon, Apr 27, 2026 at 01:46:03PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 23-Apr-26 07:15, Mario Limonciello wrote:
>>> On 4/22/26 23:42, Mika Westerberg wrote:
>>>> Hi,
>>>>
>>>> On Wed, Apr 22, 2026 at 02:08:29PM +0200, Marco Scardovi wrote:
>>>>>>> Assuming all the variants suffer the same problem would it be ok to use a
>>>>>>> wildcard for it?
>>>>>> Yeah, we could expand it to all "ROG Strix G16" I think:
>>>>>>
>>>>>> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
>>>>>> index a0116f004975..e3a6111854e8 100644
>>>>>> --- a/drivers/gpio/gpiolib-acpi-quirks.c
>>>>>> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
>>>>>> @@ -392,6 +392,23 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>>>>>>                 .ignore_wake = "VEN_0488:00@355",
>>>>>>             },
>>>>>>         },
>>>>>> +    {
>>>>>> +        /*
>>>>>> +         * The ASUS ROG Strix G16 (2025) ACPI GPIO configuration
>>>>>> +         * causes acpi_gpio_handle_deferred_request_irqs() to
>>>>>> +         * stall for ~36 seconds during boot so ignore the two
>>>>>> +         * interrupts involved.
>>>>>> +         *
>>>>>> +         * Found in BIOS G614PP.307.
>>>>>> +         */
>>>>>> +        .matches = {
>>>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>>>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "ROG Strix G16"),
>>>>>> +        },
>>>>>> +        .driver_data = &(struct acpi_gpiolib_dmi_quirk) {
>>>>>> +            .ignore_interrupt = "AMDI0030:00@21,AMDI0030:00@24",
>>>>>> +        },
>>>>>> +    },
>>>>>>         {} /* Terminating entry */
>>>>>>     };
>>>>> As for now it seems working. I've reverted it on my kernel as I prefer
>>>>> remain as much as possible close to the CachyOS' one but hopefully it will
>>>>> be implemented on 7.1, if someone propose the patch and it is accepted. It
>>>>> would be amazing to see Asus more interested on Linux and more strict with
>>>>> their BIOS but in the end I understand it's like asking for the moon.
>>>> Okay thanks for checking. I guess this is what we have to live with for now
>>>> until someone finds a better way of dealing with these.
>>>>
>>>> @Francesco, would you like to submit a new version of the patch similar to
>>>> above or you want me to do that?
>>> Hans suggested that we might want to look at ripping out this edge triggered events at boot earlier in the thread.
>>>
>>> https://lore.kernel.org/platform-driver-x86/20260423044211.GD557136@black.igk.intel.com/T/#mdca882e6606d3a894ec7499d3b742d040933dbdb
>>>
>>> Hans - as you pointed out that the Surface lid state is the only real issue left and you happen to have one do you think you could work up some patches?
>> Right, so I read further in the thread that Armin has a maybe better suggestion,
>> after that has been merged I can check a bunch of the current devices with
>> .no_edge_events_on_boot which I still have and see if those quirks can be
>> dropped now.
>>
>> But the above quirk for the ASUS ROG Strix G16 (2025) does not use
>> .no_edge_events_on_boot which just disables the initial run of
>> the ACPI event handler at boot. Instead it uses:
>>
>>              .ignore_interrupt = "AMDI0030:00@21,AMDI0030:00@24",
>>
>> which *completely* disables the ACPI event handlers for the mentioned pins.
> Oh, I've completely lost track of all the quirks that were added after I
> did anything with the ACPI GPIO stuff :(. Sorry about missing this. I will
> stay silent from now on ;-)

Hi Everyone,

@hans, I tried it and can confirm it does the trick as well.


Best regards,

Marco

