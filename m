From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3] gpio: acpi: Call enable_irq_wake for _IAE GpioInts
 with Wake set
Date: Tue, 28 Mar 2017 19:24:58 +0200
Message-ID: <ad47fe0f-cfde-c4c6-d566-8f62a5ac443d@redhat.com>
References: <20170324100847.25434-1-hdegoede@redhat.com>
 <CACRpkdb22Bofjk1dXCwyi_cWjmw6C1DgQ-NwEPcuR8cti63OPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753554AbdC1RZD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 13:25:03 -0400
In-Reply-To: <CACRpkdb22Bofjk1dXCwyi_cWjmw6C1DgQ-NwEPcuR8cti63OPw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi,

On 03/28/2017 03:23 PM, Linus Walleij wrote:
> On Fri, Mar 24, 2017 at 11:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>
>> On Bay Trail / Cherry Trail systems with a LID switch, the LID switch is
>> often connect to a gpioint handled by an _IAE event handler.
>> Before this commit such systems would not wake up when opening the lid,
>> requiring the powerbutton to be pressed after opening the lid to wakeup.
>>
>> Note that Bay Trail / Cherry Trail systems use suspend-to-idle, so
>> the interrupts are generated anyway on those lines on lid switch changes,
>> but they are treated by the IRQ subsystem as spurious while suspended if
>> not marked as wakeup IRQs.
>>
>> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
>> event handler which have their Wake flag set. This fixes such systems
>> not waking up when opening the lid.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> ---
>> Changes in v2:
>> -Improve commit msg
>> -Add Mika's Acked-by
>> Changes in v3:
>> -Use irqd_is_wakeup_set rather then tracking this ourselves
>
> This looks like it should be applied for fixes and tagged for stable.

In theory this is a fix, but I'm afraid it may have undesirable
side-effects on some systems (I hope not but you never know) so I'm
not sure it should get tagged for stable, going into 4.11-rc# as
fix seems fine to me.

> Patch applied.

Thank you.

Regards,

Hans
