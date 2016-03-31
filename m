From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: dwapb: convert device node to fwnode
Date: Thu, 31 Mar 2016 16:25:22 +0300
Message-ID: <CAHp75VcJ92vB-b7daMpd2i9hP4MPU2CAQf7JoiBx5rKFvB1RVw@mail.gmail.com>
References: <1458959496-57455-1-git-send-email-qiujiang@huawei.com>
	<1458959496-57455-2-git-send-email-qiujiang@huawei.com>
	<CANk1AXT5yHMwPJ7=0kSZKr+eHHdC1QXQVgstQ6QhFbUPSKuD+A@mail.gmail.com>
	<CAHp75VcDAg_aXt7ej-_zXxHMXJohRM9ErQkJQS_ryekD-7V=zw@mail.gmail.com>
	<56FC7491.5050000@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <56FC7491.5050000@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Alan Tull <delicious.quinoa@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, atull <atull@opensource.altera.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 31, 2016 at 3:51 AM, Jiang Qiu <qiujiang@huawei.com> wrote:
> =E5=9C=A8 2016/3/30 19:38, Andy Shevchenko =E5=86=99=E9=81=93:

>>> One suggestion for both patches: you could remove name from struct
>>> dwapb_port_property and get rid of pp->name and nobody would miss i=
t.
>>> All it is used for is some dev_err's so the device info gets printe=
d
>>> anyway.  For example (if I leave the irq out of the DT)
>>>
>>> gpio-dwapb ff708000.gpio: no irq for bank /soc/gpio@ff708000/gpio-c=
ontroller@0
>>>
>>> is redundant.  The only additional info here from the name is the p=
ort
>>> index.  That could be added to the messages without having to get t=
he
>>> name through the two property/of methods.
>>>
>>
>> Good suggestion! That'll make patches and code cleaner.
>>
>> Perhaps separate prepended  patch?
>>
> Hi Alan/Andy,
>
> It sounds good, I will follow this suggestion and do a test. But, wha=
t's the
> "separate prepended patch" mean?

Preparatory patch which goes first in the series.

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
