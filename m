Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7949169AD2;
	Wed, 29 Apr 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460470; cv=none; b=PFZcVIf4bZg1BkEBzwec+cbuyCyqOFXGajOuwPcUSUHP3NUclHj+fVcpwvCS2tslTjpD9jRbFUiNKsGjAKgipT/dg3H1/25BriHPCyDUqF0MRU0dzj3l2oyCZ9IAN0r9CnyM+3eQu29LGIksALGiVlFniAeOUHTHzyiA+Dl/krU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460470; c=relaxed/simple;
	bh=sYigKbe3Uchrembf2DdmifESkPcthSKXKUcqY+xs+1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCW1yuvhFMAIKavJKsqPPMqGn4vAWLq+ulQWP6p8BNISZXEeXfU++Tb5dderfeRZbVfOwPTR1j3GQ//3KVobuRfNmCM9pkF8IvW0rwUnxZUxVk5d+0QHqFinPO8gkoGU2M1HhQRIeX1XciTBY//Phuf/SyRWiQL97XjYkwlIyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR/Qh3xN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR/Qh3xN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A75C2BCB3;
	Wed, 29 Apr 2026 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777460469;
	bh=sYigKbe3Uchrembf2DdmifESkPcthSKXKUcqY+xs+1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PR/Qh3xNrZFiItrbP5/odyeNmp0rBJidDSkpr3Y8TgoOrvOgN7IAfegqlSOkpy++/
	 oh8v86jcrNO57XCujfvv3r26dk+Cqe4ly8y9O4UjAgemfCQOZ4NAcvK467RhsJRlQx
	 R+/7hwh8O2vyZF/8zZU5ihD7rEFTZunno9UwkMYVYkM6kbhpHxF/Feof4eICokqD4N
	 4NAnhJcX8ZK8lqW3VFrrbD0Kc6ahyGGLGNztTbNDnWYqxKs5T1m8p1jSMWDrVcDxPw
	 h5hzzAMfOgSOa3wVELAbFo7nsAnEudh66jHIPi7BEUApPzuL9Q7LzbyaMeCYbhsViE
	 Wr9DH4o6mn6xA==
Message-ID: <c7fb45be-f53f-461f-b7a2-8298e5c7df05@kernel.org>
Date: Wed, 29 Apr 2026 13:01:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Only trigger ActiveBoth interrupts on boot
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, westeri@kernel.org,
 linusw@kernel.org, brgl@kernel.org, bentiss@kernel.org,
 Francesco Lauritano <francesco.lauritano1@protonmail.com>,
 Marco Scardovi <mscardovi95@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 mika.westerberg@linux.intel.com, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20260429025247.1372984-1-mario.limonciello@amd.com>
 <6f359bec-2525-40e9-9994-15b16fb82f12@kernel.org>
 <afHcUTi5QNq8LlIb@ashevche-desk.local>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <afHcUTi5QNq8LlIb@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 29-Apr-26 12:24, Andy Shevchenko wrote:
> On Wed, Apr 29, 2026 at 11:48:13AM +0200, Hans de Goede wrote:
>> On 29-Apr-26 04:52, Mario Limonciello wrote:
> 
> ...
> 
>>> +	/*
>>> +	 * Make sure we trigger the initial state of ActiveBoth IRQs.
>>> +	 *
>>> +	 * According to the Microsoft GPIO documentation, triggering GPIO
>>> +	 * interrupts marked as ActiveBoth during initialization is correct
>>> +	 * as long as the associated GPIO line is already "asserted"
>>> +	 * (logic level low). We should not trigger edge-based GPIO
>>> +	 * interrupts not marked as ActiveBoth.
>>> +	 *
>>> +	 * See: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/general-purpose-i-o--gpio-
>>> +	 * Section: "GPIO controllers and ActiveBoth interrupts"
>>> +	 */
>>>  	if (acpi_gpio_need_run_edge_events_on_boot() &&
>>> -	    (event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
>>> +	    ((event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) ==
>>> +	     (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
>>>  		value = gpiod_get_raw_value_cansleep(event->desc);
>>> -		if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
>>> -		    ((event->irqflags & IRQF_TRIGGER_FALLING) && value == 0))
>>> +		if (value == 0)
>>>  			event->handler(event->irq, event);
>>>  	}
>>>  }
>>
>> One nitpick, which can be a follow-up patch since Andy has already picked this
>> one up.
>>
>> I think that now that the second if condition has been simplified to just
>> value == 0, it can be added to the first if as " && value == 0" dropping
>> the nested if.
> 
> But we need to get that value first (unconditionally!). I think it wouldn't
> be desirable change.

Ah right, I read over the line getting the value I thought this was already
done, never mind:

FWIW:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans


