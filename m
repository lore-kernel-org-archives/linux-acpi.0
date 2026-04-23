Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D31E5724;
	Thu, 23 Apr 2026 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776921362; cv=none; b=LWVraEeos/7zThXhp7KX2slDFilzQmNIDnx/9qisiFtbPA22LqeGtvT2XJ/9Fkif5QwwBHvxAd/OLohqquD8SKhC1QVyGPvGRPFxJ1Xjlocb/tVJqKnAzZr7EwAZ+Q0W6RHBVR481V857RjQdvVmg/rxWsLAmqtqUmgr0qKu/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776921362; c=relaxed/simple;
	bh=WBlJC2xQ6vXNDpAD4NMjUofuCEcyUB1qLXll+KoCQ5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIluMx0FpVrCJewxOCd7PRm9hn88D9uTNQWd/Td7tewUqH422PJsawK9zP5AygBEs9E2A44eZ8aNUz+ZQLV3jRU09aNiOcp7KnYrHpjQm/4u9iV3pMksDRp63bTcfOQzEvSrtAEIF5fHge3rkqSk/wuQicnrKSTtS6u4fbvC3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRlvFOO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRlvFOO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594D8C2BCB2;
	Thu, 23 Apr 2026 05:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776921362;
	bh=WBlJC2xQ6vXNDpAD4NMjUofuCEcyUB1qLXll+KoCQ5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IRlvFOO1bMNHBMIGrlyAT47NE/YJHDzM+7gF8LbHOmafwOllZfQZSOqOPWnEIvTC8
	 y1sxpApBZIGiyaOxEZiNKWRePhS1pqTTs7yTMaKa9+Jlhk3x8259gmEr1zdyiI7lQn
	 hGggR9s+2Zwy1ie8/pUcHGiOWUa1dM8M4A2xfjsEnBhBiih6qOGApCpr3NgzVjjdnF
	 dWtstpgK6lI/C407fyk2omqskuXMFixFr/6h/BLGVVFj2GhdGM6UHqT6AnPV3I8j2M
	 tT+GTGMTFEZcNWJnvpXEeviTEPkpt5CxJZHHLDEzidWjFogpi1QZAWOxPreyBrsLtH
	 Md63Dv6EbO4+g==
Message-ID: <3d562963-9581-4e0f-b9a0-5f0fe28d2495@kernel.org>
Date: Thu, 23 Apr 2026 00:15:59 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Marco Scardovi <mscardovi95@gmail.com>, Hans de Goede <hansg@kernel.org>
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
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260423044211.GD557136@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/26 23:42, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Apr 22, 2026 at 02:08:29PM +0200, Marco Scardovi wrote:
>>>> Assuming all the variants suffer the same problem would it be ok to use a
>>>> wildcard for it?
>>> Yeah, we could expand it to all "ROG Strix G16" I think:
>>>
>>> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
>>> index a0116f004975..e3a6111854e8 100644
>>> --- a/drivers/gpio/gpiolib-acpi-quirks.c
>>> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
>>> @@ -392,6 +392,23 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>>>    			.ignore_wake = "VEN_0488:00@355",
>>>    		},
>>>    	},
>>> +	{
>>> +		/*
>>> +		 * The ASUS ROG Strix G16 (2025) ACPI GPIO configuration
>>> +		 * causes acpi_gpio_handle_deferred_request_irqs() to
>>> +		 * stall for ~36 seconds during boot so ignore the two
>>> +		 * interrupts involved.
>>> +		 *
>>> +		 * Found in BIOS G614PP.307.
>>> +		 */
>>> +		.matches = {
>>> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>> +			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Strix G16"),
>>> +		},
>>> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
>>> +			.ignore_interrupt = "AMDI0030:00@21,AMDI0030:00@24",
>>> +		},
>>> +	},
>>>    	{} /* Terminating entry */
>>>    };
>> As for now it seems working. I've reverted it on my kernel as I prefer
>> remain as much as possible close to the CachyOS' one but hopefully it will
>> be implemented on 7.1, if someone propose the patch and it is accepted. It
>> would be amazing to see Asus more interested on Linux and more strict with
>> their BIOS but in the end I understand it's like asking for the moon.
> 
> Okay thanks for checking. I guess this is what we have to live with for now
> until someone finds a better way of dealing with these.
> 
> @Francesco, would you like to submit a new version of the patch similar to
> above or you want me to do that?

Hans suggested that we might want to look at ripping out this edge 
triggered events at boot earlier in the thread.

https://lore.kernel.org/platform-driver-x86/20260423044211.GD557136@black.igk.intel.com/T/#mdca882e6606d3a894ec7499d3b742d040933dbdb

Hans - as you pointed out that the Surface lid state is the only real 
issue left and you happen to have one do you think you could work up 
some patches?

