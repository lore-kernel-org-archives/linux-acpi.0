From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Thu, 25 May 2017 01:10:22 +0200
Message-ID: <CAJZ5v0izgRfxbUVLLQ1jzAVorRc5-71u-cqCNM28sgYFEkLyCw@mail.gmail.com>
References: <20170523201241.27520-1-hdegoede@redhat.com> <1568110.8i5Lk7glZA@aspire.rjw.lan>
 <5d207e0b-72d1-ee46-9e90-a98744768ced@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5d207e0b-72d1-ee46-9e90-a98744768ced@redhat.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Wed, May 24, 2017 at 9:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>

[cut]

>>> +static irqreturn_t int0002_irq(int irq, void *data)
>>> +{
>>> +       struct gpio_chip *chip = data;
>>> +       u32 gpe_sts_reg;
>>> +
>>> +       gpe_sts_reg = inl(GPE0A_STS_PORT);
>>> +       if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
>>> +               return IRQ_NONE;
>>> +
>>> +       generic_handle_irq(irq_find_mapping(chip->irqdomain,
>>> +                                           GPE0A_PME_B0_VIRT_GPIO_PIN));
>>> +
>>> +       pm_wakeup_hard_event(chip->parent);
>>
>>
>> It may be better to just do pm_system_wakeup() here and drop the
>> device_init_wakeup() from _probe().
>
>
> Ok, I've given this a try and it works fine, so I will send a v4 with
> this changed.

OK

>> The reason why is that device_init_wakeup() allows user space to disable
>> this wakeup source via sysfs which probably never is a good idea, because
>> this thing is just for clearing PME status which should be done regardless
>> and the actual wakeup is triggered by something else.
>
>
> Ack.
>
>> Also in theory pm_system_wakeup() should not really be necessary for
>> wakeup via USB keyboard to work, because that should be signaled via
>> acpi_pm_notify_handler(), at least in principle.
>
>
> Earlier versions of the int0002 driver did not call any wakeup() function
> at all and with 4.11 that worked fine, my initial testing with 4.12-rc1 also
> did not include a wakeup() call but that resulted in USB-keyboard wakeup
> not working and the system not responding to other wakeup sources like
> the power-button after the attempted USB-keyb wakeup. To be sure I've
> retried my current int0002 code with the wakeup call commented out, that
> leads to the same result (unwakeable system) so it seems we really need
> to do the pm_system_wakeup() call.

That's fine, it doesn't hurt to put it in there ATM anyway.

Thanks,
Rafael
