Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC53C8700
	for <linux-acpi@vger.kernel.org>; Sun,  3 May 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777817942; cv=none; b=oOtpbTrd7kIrDSUHSwCnv1pJpbw2OtYIvSrOQxBcrHsrimGeqyQOfg2qRYJxIJ5KVa3Lr1XvnWtvOJ+H7lLNLY0VTccPMkGmTh7vAJEhAtYCkTX5e843WjfhJf1quPKVBuJ1sRm6MYac03NbJ3DDiT6BSPC0rslieBjwaroXoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777817942; c=relaxed/simple;
	bh=k2g4JV1KUrs12s7qAM9odomL0DLieqxgng3pruwzcJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4A+Ndun65db2HXSna4EP+s23PuzS+CmaFEJY3daUQk66jU9wu3RlklUyAY8vJ2eyTod3LLlHMvqFoqohk10dQcSp0ajutBfnbvaELyc2okJl9TI+Jd75J7fu5cC2yMNIJDr/wsOJwE2hDw9zvRKQV5jSSeN3fJwkle2HzR15LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxCxleWV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxCxleWV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891b0786beso22442765e9.1
        for <linux-acpi@vger.kernel.org>; Sun, 03 May 2026 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777817939; x=1778422739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D31Kjx5p4Zz0J/9eHZzNKvFTByn7RU7HP4MuPEMcbXY=;
        b=FxCxleWVN7MUblEkz+DTBFfykM3uOd4ljZpkD8n02Xxh0N21/QcqUoIxh1P7lNZSVP
         S4bUEfUp8j7DmN2JpD8x0EKYLqDZG+CjqgvRtNACbTrI8caK2156xKy1pk3YLbO2xoWL
         n+WDd36/Bwhqk8tyFP7VzWLEt8q3HmolSgzTixH4Btwbz5FtU6wcoO/Bv4Vonm9EPeYx
         9AxLBrW0RsrigQCXe47Nj9IdgH4WpJR90fQhmvkHqVo38IRNur2bcQd66hAWdr9sojOm
         FJyJaFOAdzyyYcuIfTmGeTB4IwcFEeKJsiwbXFyHz9Cnk6pDGMhPzm3dla29nD6qESZB
         agNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777817939; x=1778422739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D31Kjx5p4Zz0J/9eHZzNKvFTByn7RU7HP4MuPEMcbXY=;
        b=LU0mrrYABNvbiP2L1T//1c+cYx6cASjGPYmwr9/pNfHEGHJxpfL52Hw8uHfboCfLhB
         048b6IMJVvEyv0YFmIg9gBKvZjUvgv6ZSbn1fiUMv3DL6jA8oQj35zZIOVMwSk7H9lkM
         GtB+jdhQA3MKdjB8cC2rsHx2u85ejTijENBc947PeFLH6fYnzInrtUMMSiiPdRgNv+qU
         Ds3ffOHtZa3pyE6GT/lULIcm9gCPl5QqmDXnzaMUzod5yX0JaVQiW+/quPE29zHGfbEP
         IELGBU1hYGUlQtY962qGzI49ACdP812jiU+hHnSZ6x2sfliOQHGPrqy8MQVkvGYFTJf5
         pgdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+y7Ga4bvzrNm+qCahNX6mI4yBGWqXaanKuC/HcHFJsn5uGdIWTqOXFQ8DRli+GdWPyMp9jbFdr5oZV@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVy3xdQCQjZBRbAbh514l7H7gr7jOh9SHw7hMHZgqnbTfqXDk
	o9x1fIDQ2Lf3STqCxHIDe5Oj3G9LF3FIKaaruyrYziUCeARCie25Ha2B
X-Gm-Gg: AeBDievZf0uMWMgzktJbFE4BAQ+L2yW1Wc5LApekvceQCky6i8982I+sXZn6LuBKtXW
	VUJ7ppsi8odNv+hnLeGwNyqXrLIqQcPNH/dh2yBbPLPF8E1ARt9TzwBZMd+XPSCAcvAL/t2RpH9
	ZSsSPR+gFGcv4DfA8KsKPkSXs1JDY8+QpCAya+WC0zm7vS8bRX7ke6v3cwOtCiITZQLLjN/RPk8
	WhOMePXgKHUAtVot33EiNLQo2Vw29bzgaBoNgE8DzcbwAjCkuX5PYnvlxwO2evmTu6z+3t8F7Ai
	T9GccNIMG2I2MbG6Nz8schJujEo+2SBCl/nDUZfvVatrwOUIeVsUMUJLN7jwGqglSmUKWscn68b
	Aey156BiJuXgPNJJmxTZbc6Ugf+GPAgJGNtAVGbi825gzdfCLWDX0NVeuFVWHZCrEQyy72uiaYB
	VukeGC4jwUptSRPz1gN0D5RZMdywJrlxhyopVWkZgj/9BA2LHPyQGOPGy6ER5MOjyDhvXNGP/Q3
	gN3hzo=
X-Received: by 2002:a05:600c:698d:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-48a9852f4b9mr100217425e9.6.1777817939042;
        Sun, 03 May 2026 07:18:59 -0700 (PDT)
Received: from ?IPV6:2a01:e11:202b:40:68b1:8d59:e348:c16e? ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm209044485e9.7.2026.05.03.07.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 07:18:58 -0700 (PDT)
Message-ID: <a42767b8-7a0c-4202-9132-be8fa65baabc@gmail.com>
Date: Sun, 3 May 2026 16:18:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Only trigger ActiveBoth interrupts on boot
To: Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, westeri@kernel.org,
 linusw@kernel.org, brgl@kernel.org, bentiss@kernel.org,
 Francesco Lauritano <francesco.lauritano1@protonmail.com>,
 Armin Wolf <W_Armin@gmx.de>, mika.westerberg@linux.intel.com,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20260429025247.1372984-1-mario.limonciello@amd.com>
 <6f359bec-2525-40e9-9994-15b16fb82f12@kernel.org>
 <afHcUTi5QNq8LlIb@ashevche-desk.local>
 <c7fb45be-f53f-461f-b7a2-8298e5c7df05@kernel.org>
Content-Language: en-US
From: Marco Scardovi <mscardovi95@gmail.com>
In-Reply-To: <c7fb45be-f53f-461f-b7a2-8298e5c7df05@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/29/26 13:01, Hans de Goede wrote:
> Hi,
>
> On 29-Apr-26 12:24, Andy Shevchenko wrote:
>> On Wed, Apr 29, 2026 at 11:48:13AM +0200, Hans de Goede wrote:
>>> On 29-Apr-26 04:52, Mario Limonciello wrote:
>> ...
>>
>>>> +	/*
>>>> +	 * Make sure we trigger the initial state of ActiveBoth IRQs.
>>>> +	 *
>>>> +	 * According to the Microsoft GPIO documentation, triggering GPIO
>>>> +	 * interrupts marked as ActiveBoth during initialization is correct
>>>> +	 * as long as the associated GPIO line is already "asserted"
>>>> +	 * (logic level low). We should not trigger edge-based GPIO
>>>> +	 * interrupts not marked as ActiveBoth.
>>>> +	 *
>>>> +	 * See: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/general-purpose-i-o--gpio-
>>>> +	 * Section: "GPIO controllers and ActiveBoth interrupts"
>>>> +	 */
>>>>   	if (acpi_gpio_need_run_edge_events_on_boot() &&
>>>> -	    (event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
>>>> +	    ((event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) ==
>>>> +	     (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
>>>>   		value = gpiod_get_raw_value_cansleep(event->desc);
>>>> -		if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
>>>> -		    ((event->irqflags & IRQF_TRIGGER_FALLING) && value == 0))
>>>> +		if (value == 0)
>>>>   			event->handler(event->irq, event);
>>>>   	}
>>>>   }
>>> One nitpick, which can be a follow-up patch since Andy has already picked this
>>> one up.
>>>
>>> I think that now that the second if condition has been simplified to just
>>> value == 0, it can be added to the first if as " && value == 0" dropping
>>> the nested if.
>> But we need to get that value first (unconditionally!). I think it wouldn't
>> be desirable change.
> Ah right, I read over the line getting the value I thought this was already
> done, never mind:
>
> FWIW:
>
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>
> Regards,
>
> Hans

Hi everyone,

I tested it personally against both kernel 7.0 and 7.1 and can say it works.

Are there any news on how it is proceeding? Somewhere I can check the 
progress?

Best regards,

Marco "scardracs" Scardovi

