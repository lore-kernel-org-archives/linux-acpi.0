From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] gpio: acpi: Call enable_irq_wake for _IAE GpioInts
 with Wake set
Date: Tue, 21 Mar 2017 13:36:15 +0100
Message-ID: <CAJZ5v0jrq_AUysuLuyhUqWXOYm8X-koq8ra=rgrjUo+bFMyw9w@mail.gmail.com>
References: <20170320173221.3397-1-hdegoede@redhat.com> <1490099423.19767.124.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36806 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbdCUMgR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Mar 2017 08:36:17 -0400
In-Reply-To: <1490099423.19767.124.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-gpio@vger.kernel.org

On Tue, Mar 21, 2017 at 1:30 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2017-03-20 at 18:32 +0100, Hans de Goede wrote:
>> On Bay Trail / Cherry Trail systems with a LID switch, the LID switch
>> is
>> often connect to a gpioint handled by an _IAE event handler.
>> Before this commit such systems would not wake up when opening the
>> lid,
>> requiring the powerbutton to be pressed after opening the lid to
>> wakeup.
>>
>> Note that Bay Trail / Cherry Trail systems use suspend-to-idle, so
>> the interrupts are generated anyway on those lines on lid switch
>> changes,
>> but they are treated by the IRQ subsystem as spurious while suspended
>> if
>> not marked as wakeup IRQs.
>>
>> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
>> event handler which have their Wake flag set. This fixes such systems
>> not waking up when opening the lid.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>
>> +     bool irq_wake_enabled;
>>
>
>> +             if (event->irq_wake_enabled)
>>
>
> Same (new) comment as in v1.

Why not just check for agpio->wake_capable == ACPI_WAKE_CAPABLE
instead as I said?

Thanks,
Rafael
