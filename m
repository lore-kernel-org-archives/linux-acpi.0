From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] gpio: acpi: Call enable_irq_wake for _IAE GpioInts with
 Wake set
Date: Sun, 19 Mar 2017 20:48:19 +0100
Message-ID: <CAJZ5v0jvbChRQvm2n+7droAoC+1Dn6Z_QjeBfmr2KDAkJ9533g@mail.gmail.com>
References: <20170318233524.5047-1-hdegoede@redhat.com> <1489937116.19767.92.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1489937116.19767.92.camel@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Mar 19, 2017 at 4:25 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
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
>
>> +             if (event->irq_wake_enabled)
>
> You may use irqd_is_wakeup_set() instead. IRQ framework keeps this state
> already.
>
>> +                     disable_irq_wake(event->irq);

Good point!

Thanks,
Rafael
