From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [RFC PATCH] GPIO/ACPI: DesignWare: Add GPIO-signaled ACPI events
 support for power button
Date: Tue, 16 Feb 2016 20:32:40 +0800
Message-ID: <56C316E8.4090002@huawei.com>
References: <1454653542-122055-1-git-send-email-qiujiang@huawei.com>
 <CACRpkdZNCt_TtA6SR86dVCR7vq5cpVmbzxeTguc7go6vVRkuTg@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:33835 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbcBPMeM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 07:34:12 -0500
In-Reply-To: <CACRpkdZNCt_TtA6SR86dVCR7vq5cpVmbzxeTguc7go6vVRkuTg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

=E5=9C=A8 2016/2/16 2:25, Linus Walleij =E5=86=99=E9=81=93:
> Mika can you help out looking at this patch. Tell me if you need a co=
py
> of the whole patch, I'm not smart with ACPI.
>=20
> On Fri, Feb 5, 2016 at 7:25 AM, qiujiang <qiujiang@huawei.com> wrote:
>=20
>> This patch modifies the DesignWare GPIO controller driver to
>> support the GPIO-signaled ACPI Events. This is used for power
>> button function on ARM server.
>>
>> To make it work, the _AEI and _EVT object must be defined in
>> the corresponding GPIO driver's dsdt table in UEFI. At the same
>> time, ACPI daemon component is also necessary.
>>
>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>=20
> (...)
>> --- a/drivers/gpio/gpio-dwapb.c
>> +++ b/drivers/gpio/gpio-dwapb.c
>> @@ -23,6 +23,11 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/platform_data/gpio-dwapb.h>
>>  #include <linux/slab.h>
>> +#include <linux/acpi.h>
>> +#include <linux/gpio.h>
>=20
> You should only need <linux/driver.h>
Here, I don't understand well. I used driver.h instead acpi.h and
gpio.h, but it came to compile failed.
>=20
>> +#include "gpiolib.h"
>=20
> I guess this is for some acpi_gpiochip* functions that ACPI GPIO
> drivers need like this:
>=20
Yes, this is for function the following acpi_gpiochip* function.
These functions were declared in the gpiolib.h but gpiolib-acpi.h.
>> +       /* Add GPIO-signaled ACPI event support */
>> +       if (pp->irq)
>> +               acpi_gpiochip_request_interrupts(&(port->bgc.gc));
>=20
> Hm, maybe these should be in "gpiolib-acpi.h" or so.
>=20
> Overall the patch looks sane to me, but I need some ACPI
> person to tell.
>=20
> Yours,
> Linus Walleij
>=20
> .
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
