Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8936DA15
	for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966399; cv=none; b=hC8ELkRyW21cx7uW5u0PZKYeSDpXABlFz8iqujADNVrcJlEzA/rfSmzJLLIOId6YSw3ddgoeUxXanqAIxFvlc3SZjoQwXcTBeLC5YLSb+M7QXbKwqiGFIy4SRUlQSTscnH+k1uk4lsKfIRVMCVU3aUHmZ3rzpL8ktZeWkUaUriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966399; c=relaxed/simple;
	bh=Q/08wWQ4SfuMhfDVP9sXEtWA2o3HnwK33N7dXefJmWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3Kczjqkh2mEaEaMlrNqLom12V1hO7EjWU3HWKFZEvVdHzBsRW0cquNemPRAxtkJmrImCQPLEkZz0Mm1lmZg9wmHBslNM0xv6e5a/WnCsNLH3f/ZKko6aH3r9Cf9Y5+LeoXQOYd36MsSPiFM8Vg7vmn+4XRaxZVZAUpE1dErj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgxG5Rf0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgxG5Rf0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so68418885e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776966396; x=1777571196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKO0ZSfKpXY8aQTH5b7X8YGTTyGiXXEYMnXwkBPcBbk=;
        b=TgxG5Rf0D6+XEDnDW9xBvzpnyRDZDrymF543ek4kkzR+gYRk8/nffD/by7kRisi3D2
         q71qvkSVSdP2YG71S1mxZg3tKApvpAA4piUNIKDddPY/9hAbspQ3m6OjYu96sto8HlKx
         ucKLoK5148Y3oRXEjOBSpGKxlj11ApiqLapCdSPpMLp2PnVRuIdzvuyEgYn4Uq7Gg7MM
         WcGWWpU2dSAwB7UW1bAEFVw4RT1XafzBUa8k1/AswBlzt+l20RrLClMnUyjoor93ZVqY
         L618uq6XvNkDcvNIce5c+d9AOoDy1gDZCrRrElOtWC6W0VUu1QoxNcRjicwp864/ae0T
         zZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966396; x=1777571196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKO0ZSfKpXY8aQTH5b7X8YGTTyGiXXEYMnXwkBPcBbk=;
        b=ofMqv6zPYT1t2HpRldsh3MTTww1Gm3KptVL9tI06ylsaTsVKFrdE0JvU42DIOaTvya
         qFPLTKmB8rqJLXkaDYsbvIGMjBPiL1wrk2iNFp0x4CjRz2KZFBp3bTJcRUGUQ/KDNqeb
         LuAP0zoucGYgvv/MJMxS58p6nptukXA1EXfSul3HxYTaAzYaTENwjBosJf8bRnuw2m1K
         nZpAtq6qOP8IgHCKZwd4UCt3xZ53cymtBnB/MTWCE2fx9FGhCVddPLnV2LEGRxXrtExH
         esOAbCI8M57s/5fxr184SodFPk0ZtAPUA8WsQ6QCVkcFyvgtquFJVRYakFyr6+KDO3DY
         hYqg==
X-Forwarded-Encrypted: i=1; AFNElJ8W5p+PGCrkFKUz+mE2fz9TQi4w1Ni3He2cblZPGT8NsPmIjS4OgeWXfx31/pwZ/DtJwkiet4XyKyxF@vger.kernel.org
X-Gm-Message-State: AOJu0YxMm4cyTcNCSY/yms3hKbnWQRWYisV9JzaP0nHfI8PkpJ4HXXwD
	nDBhOSnq90E23jJ7jvXVQhrSuRg8BDo1aa+FbZlz9l8Ru9z0tJuKNZnw
X-Gm-Gg: AeBDies6q82nZUpK0ds6hggATYeRimPbptH+E4h647dHOq+fn4ySfLmmub7PZHASSkI
	sfgbzVA4t6jCQH8oYofH8z3+HdIZJwqP2YwZ4L6pR3lQFReo4/gXux7C/uwtLZgh0Sm2laG3cen
	lxgBJV9zXbzCjujcfT67Jltv762gryQWqfD0jPxOV8ntgAAhGG8cimKFVfIfn9uId2X+lFS2mwb
	WNO96kVREkSwrrYnA00eValLmZZehW0jBhmlJsUOp3XZ9k8xMhU6ex9uTwB0+pzM5KB/O4+Nddw
	6m/8TF4qcfsib2lO+gLyH2wZwV6pQqbpdPQjrAREEJ5viHshbyyUdHGD8WXhV98zfZ3LFDrxqgY
	+Kd0HvpzdFtsjvZRu18/JWE77EAZ3lrUEJYUreNX2meZ92ivQWCCr2gXoyOk7NGs8XFiS+qtPai
	4AihNnLZbYKZYJR8xTs2vKFlPueXpj+/U4wuue3lO5zKzzPkQ7cSEL1t/QGGk12Cz2/kZE/9GVm
	b9US0E=
X-Received: by 2002:a05:600c:6085:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488fb782618mr367619265e9.21.1776966395897;
        Thu, 23 Apr 2026 10:46:35 -0700 (PDT)
Received: from ?IPV6:2a01:e11:202b:40:3c42:f121:865e:1066? ([2a01:e11:202b:40:3c42:f121:865e:1066])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm916283675e9.3.2026.04.23.10.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 10:46:34 -0700 (PDT)
Message-ID: <f72a1da5-2cc1-4e08-9441-ea252062b4e5@gmail.com>
Date: Thu, 23 Apr 2026 19:46:33 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
To: Mario Limonciello <superm1@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
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
Content-Language: en-US
From: Marco Scardovi <mscardovi95@gmail.com>
In-Reply-To: <3d562963-9581-4e0f-b9a0-5f0fe28d2495@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/23/26 07:15, Mario Limonciello wrote:
> On 4/22/26 23:42, Mika Westerberg wrote:
>> Hi,
>>
>> On Wed, Apr 22, 2026 at 02:08:29PM +0200, Marco Scardovi wrote:
>>>>> Assuming all the variants suffer the same problem would it be ok 
>>>>> to use a
>>>>> wildcard for it?
>>>> Yeah, we could expand it to all "ROG Strix G16" I think:
>>>>
>>>> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c 
>>>> b/drivers/gpio/gpiolib-acpi-quirks.c
>>>> index a0116f004975..e3a6111854e8 100644
>>>> --- a/drivers/gpio/gpiolib-acpi-quirks.c
>>>> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
>>>> @@ -392,6 +392,23 @@ static const struct dmi_system_id 
>>>> gpiolib_acpi_quirks[] __initconst = {
>>>>                .ignore_wake = "VEN_0488:00@355",
>>>>            },
>>>>        },
>>>> +    {
>>>> +        /*
>>>> +         * The ASUS ROG Strix G16 (2025) ACPI GPIO configuration
>>>> +         * causes acpi_gpio_handle_deferred_request_irqs() to
>>>> +         * stall for ~36 seconds during boot so ignore the two
>>>> +         * interrupts involved.
>>>> +         *
>>>> +         * Found in BIOS G614PP.307.
>>>> +         */
>>>> +        .matches = {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "ROG Strix G16"),
>>>> +        },
>>>> +        .driver_data = &(struct acpi_gpiolib_dmi_quirk) {
>>>> +            .ignore_interrupt = "AMDI0030:00@21,AMDI0030:00@24",
>>>> +        },
>>>> +    },
>>>>        {} /* Terminating entry */
>>>>    };
>>> As for now it seems working. I've reverted it on my kernel as I prefer
>>> remain as much as possible close to the CachyOS' one but hopefully 
>>> it will
>>> be implemented on 7.1, if someone propose the patch and it is 
>>> accepted. It
>>> would be amazing to see Asus more interested on Linux and more 
>>> strict with
>>> their BIOS but in the end I understand it's like asking for the moon.
>>
>> Okay thanks for checking. I guess this is what we have to live with 
>> for now
>> until someone finds a better way of dealing with these.
>>
>> @Francesco, would you like to submit a new version of the patch 
>> similar to
>> above or you want me to do that?
>
> Hans suggested that we might want to look at ripping out this edge 
> triggered events at boot earlier in the thread.
>
> https://lore.kernel.org/platform-driver-x86/20260423044211.GD557136@black.igk.intel.com/T/#mdca882e6606d3a894ec7499d3b742d040933dbdb 
>
>
> Hans - as you pointed out that the Surface lid state is the only real 
> issue left and you happen to have one do you think you could work up 
> some patches?
>
I see. Well, that makes totally sense
