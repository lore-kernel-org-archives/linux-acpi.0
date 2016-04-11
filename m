From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v7 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Mon, 11 Apr 2016 20:33:26 +0800
Message-ID: <570B9996.10402@huawei.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
 <1459926480-32966-4-git-send-email-qiujiang@huawei.com>
 <CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:45247 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbcDKMhR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Apr 2016 08:37:17 -0400
In-Reply-To: <CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>

=E5=9C=A8 2016/4/8 16:26, Linus Walleij =E5=86=99=E9=81=93:
> On Wed, Apr 6, 2016 at 9:08 AM, qiujiang <qiujiang@huawei.com> wrote:
>
>> This patch adds gpio-signaled acpi event support. It is used for
>> power button on hisilicon D02 board, an arm64 platform.
>>
>> The corresponding DSDT file is defined as follows:
>>  Device(GPI0) {
>>         Name(_HID, "HISI0181")
>>         Name(_ADR, 0)
>>         Name(_UID, 0)
>>
>>         Name (_CRS, ResourceTemplate ()  {
>>                 Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
>>                 Interrupt (ResourceConsumer, Level, ActiveHigh,
>>                 Exclusive,,,)  {344}
>>         })
>>
>>         Device(PRTa) {
>>                 Name (_DSD, Package () {
>>                 Package () {
>>                         Package () {"reg",0},
>>                         Package () {"snps,nr-gpios",32},
>>                         }
>>                 })
>>         }
>>
>>         Name (_AEI, ResourceTemplate () {
>>                 GpioInt(Edge, ActiveLow, ExclusiveAndWake,
>>                 PullUp, , " \\_SB.GPI0") {8}
>>         })
>>
>>         Method (_E08, 0x0, NotSerialized) {
>>                 Notify (\_SB.PWRB, 0x80)
>>         }
>> }
>>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: qiujiang <qiujiang@huawei.com>
> Admittedly I'm an ACPI novice and need help with deciding
> about ACPI, but I mostly trust Mika to know these things right.
>
> About this:
>
>> +       /* Add GPIO-signaled ACPI event support */
>> +       if (pp->irq)
>> +               acpi_gpiochip_request_interrupts(&port->gc);
> It's weird to me that the driver already has a requested IRQ and
> everything, now it has to request it again from ACPI.
>
> When I look into the acpi_gpiochip_request_interrupts()
> I find it weird that it is void given how much can go wrong
> inside it. Should it not return an errorcode?
Just as Mika said, these are two different things:

platform_get_irq() requestedIRQ resource from interrupt subsystem and
create irq mapping, then gose ready for device, but dose not request
a handler immediately.

acpi_gpiochip_request_interrupts() parse the _AEI and _EVT object and=20
result awareness of what GPIO pin is used.Then, install a event handler
for each pin by request this pp->irq.

If something gose wrong when acpi_gpiochip_request_interrupts() process=
,
GPIO itself can still works fine.

>> +               if (has_acpi_companion(dev) && pp->idx =3D=3D 0)
>> +                       pp->irq =3D platform_get_irq(to_platform_dev=
ice(dev), 0);
> As it was already fetched here and then later requested,
> we still have to call acpi_gpiochip_request_interrupts()
> further down the road? That is confusing to me, can you
> explain what is going on?
>
> Yours,
> Linus Walleij
>
> .
>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
