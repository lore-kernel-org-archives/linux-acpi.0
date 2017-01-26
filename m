From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V11 2/3] ACPI: Add support for ResourceSource/IRQ domain mapping
Date: Thu, 26 Jan 2017 12:38:49 +0200
Message-ID: <CAHp75Vd7wBq7saVj_+1Zh8Dt8v59HWc6S-PdWWT84zuwO0VWTw@mail.gmail.com>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
 <1484879660-1960-3-git-send-email-agustinv@codeaurora.org>
 <CAHp75VeYxfuMuaZCMk+MYdxLTs7cCa6j6M7Ot3XnwMmeHP7kBA@mail.gmail.com> <20170126101521.GA10324@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35616 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbdAZKiu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2017 05:38:50 -0500
In-Reply-To: <20170126101521.GA10324@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, harba@codeaurora.org, Jon Masters <jcm@redhat.com>, msalter@redhat.com, mlangsdo@redhat.com, Al Stone <ahs3@redhat.com>, astone@redhat.com, Graeme Gregory <graeme.gregory@linaro.org>, guohanjun@huawei.com, Charles Garcia-Tobin <charles.garc>

On Thu, Jan 26, 2017 at 12:15 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jan 26, 2017 at 03:01:18AM +0200, Andy Shevchenko wrote:
>> On Fri, Jan 20, 2017 at 4:34 AM, Agustin Vega-Frias
>> <agustinv@codeaurora.org> wrote:
>> > ACPI extended IRQ resources may contain a ResourceSource to specify
>> > an alternate interrupt controller. Introduce acpi_irq_get and use it
>> > to implement ResourceSource/IRQ domain mapping.
>> >
>> > The new API is similar to of_irq_get and allows re-initialization
>> > of a platform resource from the ACPI extended IRQ resource, and
>> > provides proper behavior for probe deferral when the domain is not
>> > yet present when called.

>> > +       list_for_each_entry(hwid, &device->pnp.ids, list) {
>>
>> > +               for (devid = &__dsdt_irqchip_acpi_probe_table;
>> > +                    devid < &__dsdt_irqchip_acpi_probe_table_end; devid++) {
>> > +                       if (devid->id && !strcmp(devid->id, hwid->id)) {
>> > +                               result = &device->fwnode;
>> > +                               break;
>> > +                       }
>> > +               }
>>
>> Looks like a candidate for linker table API. (I recommend to Cc Luis
>> for this part)
>
> This linker table entry scheme is just an optimization and should
> not gate the series.

That's correct. Though Luis might give some advice regarding to this
piece of code.

>> > +#ifdef CONFIG_ACPI_GENERIC_GSI
>>
>> #if IS_ENABLED()

>> > +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
>> > +#else
>> > +static inline int acpi_irq_get(acpi_handle handle, unsigned int index,
>> > +                              struct resource *res)
>>
>> Perhaps
>>
>> static inline
>> int ...
>
> It is late -rc5 and notwithstanding cosmetics changes, can we make
> progress with this patch series or not please ?

I agree for the second case from what's left above, first one might be
useful to amend.
At the end it's a Rafael's word, I'm not insisting on cosmetic
changes. So, what about the rest?

-- 
With Best Regards,
Andy Shevchenko
