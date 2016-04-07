From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v7 2/3] gpio: dwapb: convert device node to fwnode
Date: Thu, 7 Apr 2016 19:14:27 +0800
Message-ID: <57064113.2040603@huawei.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
 <1459926480-32966-3-git-send-email-qiujiang@huawei.com>
 <CAHp75Vc-Pd4swDq5gVKtwmOGD9fALkmDpyt1qah0JGQo2+422w@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:5263 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbcDGLPC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2016 07:15:02 -0400
In-Reply-To: <CAHp75Vc-Pd4swDq5gVKtwmOGD9fALkmDpyt1qah0JGQo2+422w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com



=E5=9C=A8 2016/4/6 21:01, Andy Shevchenko =E5=86=99=E9=81=93:
> On Wed, Apr 6, 2016 at 10:07 AM, qiujiang <qiujiang@huawei.com> wrote=
:
>> This patch converts device node to fwnode for dwapb driver, so
>> as to provide a unified fwnode for DT and ACPI bindings.
>>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>=20
>>  static struct dwapb_platform_data *
>> -dwapb_gpio_get_pdata_of(struct device *dev)
>> +dwapb_gpio_get_pdata(struct device *dev)
>=20
> I don't remember if I had asked already
> does it fit now one row?
Hi Andy,

It dose not fit one row yet, checkpatch.pl will report a warning.
>=20
>> @@ -495,9 +493,10 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>                  * Only port A can provide interrupts in all configu=
rations of
>>                  * the IP.
>>                  */
>> -               if (pp->idx =3D=3D 0 &&
>> -                   of_property_read_bool(port_np, "interrupt-contro=
ller")) {
>> -                       pp->irq =3D irq_of_parse_and_map(port_np, 0)=
;
>> +               if (dev->of_node && pp->idx =3D=3D 0 &&
>=20
> is_of_fwnode() && ?
>=20
>> +                       fwnode_property_read_bool(fwnode,
>> +                                                 "interrupt-control=
ler")) {
>> +                       pp->irq =3D irq_of_parse_and_map(to_of_node(=
fwnode), 0);
>>                         if (!pp->irq)
>>                                 dev_warn(dev, "no irq for this bank\=
n");
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
