From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] gpio: acpi: Call enable_irq_wake for _IAE GpioInts with
 Wake set
Date: Mon, 20 Mar 2017 18:20:26 +0100
Message-ID: <c9801c6a-b773-b5fd-25dc-6e19053512ac@redhat.com>
References: <20170318233524.5047-1-hdegoede@redhat.com>
 <1489937116.19767.92.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752346AbdCTRU3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Mar 2017 13:20:29 -0400
In-Reply-To: <1489937116.19767.92.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org

Hi,

On 19-03-17 16:25, Andy Shevchenko wrote:
> On Sun, 2017-03-19 at 00:35 +0100, Hans de Goede wrote:
>> On baytrail / cherrytrail systems with a LID switch the LID switch is
>> often connect to a gpioint handled by an _IAE event handler.
>> Before this commit such systems would not wake up when opening the
>> lid,
>> requiring the powerbutton to be pressed after opening the lid to
>> wakeup.
>>
>> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
>> event handler which have their Wake flag set. This fixes such systems
>> not waking up when opening the lid.
>
> I perhaps give up on my nits against Capital Letters :-), though for
> consistency, please, use Baytrail, Cherry Trail.

Will fix for v2.

>
>> +		if (event->irq_wake_enabled)
>
> You may use irqd_is_wakeup_set() instead. IRQ framework keeps this state
> already.

That requires having irq_data which is only (normally) available to
irq_chip drivers, so that is not going to work here.

Regards,

Hans
