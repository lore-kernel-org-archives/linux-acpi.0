From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v6 1/2] gpio: dwapb: convert device node to fwnode
Date: Thu, 31 Mar 2016 08:51:29 +0800
Message-ID: <56FC7491.5050000@huawei.com>
References: <1458959496-57455-1-git-send-email-qiujiang@huawei.com>
 <1458959496-57455-2-git-send-email-qiujiang@huawei.com>
 <CANk1AXT5yHMwPJ7=0kSZKr+eHHdC1QXQVgstQ6QhFbUPSKuD+A@mail.gmail.com>
 <CAHp75VcDAg_aXt7ej-_zXxHMXJohRM9ErQkJQS_ryekD-7V=zw@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:65056 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbcCaAzC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2016 20:55:02 -0400
In-Reply-To: <CAHp75VcDAg_aXt7ej-_zXxHMXJohRM9ErQkJQS_ryekD-7V=zw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, atull <atull@opensource.altera.com>

=E5=9C=A8 2016/3/30 19:38, Andy Shevchenko =E5=86=99=E9=81=93:
> On Tue, Mar 29, 2016 at 7:30 PM, Alan Tull <delicious.quinoa@gmail.co=
m> wrote:
>> On Fri, Mar 25, 2016 at 9:31 PM, qiujiang <qiujiang@huawei.com> wrot=
e:
>>
>>> -               if (pp->idx =3D=3D 0 &&
>>> -                   of_property_read_bool(port_np, "interrupt-contr=
oller")) {
>>> -                       pp->irq =3D irq_of_parse_and_map(port_np, 0=
);
>>> +               if (dev->of_node && pp->idx =3D=3D 0 &&
>>> +                       fwnode_property_read_bool(fwnode,
>>> +                                                 "interrupt-contro=
ller")) {
>>> +                       pp->irq =3D irq_of_parse_and_map(to_of_node=
(fwnode), 0);
>>>                         if (!pp->irq) {
>>>                                 dev_warn(dev, "no irq for bank %s\n=
",
>>> -                                        port_np->full_name);
>>> +                                        to_of_node(fwnode)->full_n=
ame);
>>>                         }
>>>                 }
>>>
>>>                 pp->irq_shared  =3D false;
>>>                 pp->gpio_base   =3D -1;
>>> -               pp->name        =3D port_np->full_name;
>>> +               if (dev->of_node)
>>> +                       pp->name =3D to_of_node(fwnode)->full_name;
>>
>> Hi Jiang,
>>
>> I tested lightly on a CycloneV and it worked fine (with device tree)=
=2E
>>
>> One suggestion for both patches: you could remove name from struct
>> dwapb_port_property and get rid of pp->name and nobody would miss it=
=2E
>> All it is used for is some dev_err's so the device info gets printed
>> anyway.  For example (if I leave the irq out of the DT)
>>
>> gpio-dwapb ff708000.gpio: no irq for bank /soc/gpio@ff708000/gpio-co=
ntroller@0
>>
>> is redundant.  The only additional info here from the name is the po=
rt
>> index.  That could be added to the messages without having to get th=
e
>> name through the two property/of methods.
>>
>=20
> Good suggestion! That'll make patches and code cleaner.
>=20
> Perhaps separate prepended  patch?
>=20
Hi Alan/Andy,

It sounds good, I will follow this suggestion and do a test. But, what'=
s the
"separate prepended patch" mean?

Thanks, Jiang

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
