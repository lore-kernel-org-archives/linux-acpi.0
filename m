From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] drivers/platform/x86: Add driver for INT0002 ACPI device
Date: Fri, 21 Apr 2017 11:27:32 +0300
Message-ID: <CAHp75Vd=ZgXe9rWHC8U5HANtDso7kqv-WN7R2L5Bt5c7r==dSw@mail.gmail.com>
References: <20170421074157.19159-1-hdegoede@redhat.com> <s5hfuh2mayi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33967 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036432AbdDUI1d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2017 04:27:33 -0400
In-Reply-To: <s5hfuh2mayi.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Fri, Apr 21, 2017 at 11:17 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 21 Apr 2017 09:41:57 +0200,
> Hans de Goede wrote:
>>
>> Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
>> PMC to wakeup the system. When this happens software needs to clear the
>> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
>>
>> This is modelled in ACPI through the INT0002 ACPI device.
>>
>> This commit adds a driver which will bind to that device, call the
>> ACPI event handler for the wakeup and clear the interrupt source
>> avoiding the irq storm.

>> +     char ev_name[5];
>
> Are 5 bytes enough?  I see the code below:
>
>> +             snprintf(data->ev_name, sizeof(data->ev_name), "_%c%02X",
>> +                     res->data.gpio.triggering ? 'E' : 'L',
>> +                     res->data.gpio.pin_table[0]);
>
> So it counts 6 including NUL.

How? 4 + NUL = 5.

OTOH it looks like code duplication with existing drivers (GPIO ACPI
library IIRC) which might make sense to make generic.

>> +     data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +     if (!data) {
>> +             dev_err(dev, "can't allocate memory for int0002\n");
>
> The error message is mostly superfluous.
>
>> +static int int0002_runtime_suspend(struct device *dev)
>> +{
>> +     return 0;
>> +}
>> +
>> +static int int0002_runtime_resume(struct device *dev)
>> +{
>> +     return 0;
>> +}
>> +
>> +static const struct dev_pm_ops int0002_pm_ops = {
>> +     .runtime_suspend = int0002_runtime_suspend,
>> +     .runtime_resume = int0002_runtime_resume,
>> +};
>
> Do we need these runtime PM?  If not, we can remove the header
> inclusion, too.

Yeah, and it needs attention when built with !CONFIG_PM.


-- 
With Best Regards,
Andy Shevchenko
