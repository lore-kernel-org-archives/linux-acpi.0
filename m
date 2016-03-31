From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v6 2/2] gpio: dwapb: add gpio-signaled acpi event support
Date: Thu, 31 Mar 2016 08:59:02 +0800
Message-ID: <56FC7656.1020900@huawei.com>
References: <1458959496-57455-1-git-send-email-qiujiang@huawei.com>
 <1458959496-57455-3-git-send-email-qiujiang@huawei.com>
 <CAHp75VcRkwDm60b7PTJmYmPVX7iNoLFL_pcx5qUK8=E7zMyKtw@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcRkwDm60b7PTJmYmPVX7iNoLFL_pcx5qUK8=E7zMyKtw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2016/3/30 19:41, Andy Shevchenko =E5=86=99=E9=81=93:
> On Sat, Mar 26, 2016 at 4:31 AM, qiujiang <qiujiang@huawei.com> wrote=
:
>> This patch adds gpio-signaled acpi event support. It is used for
>> power button on hisilicon D02 board, an arm64 platform.
>=20
> Yes, looks good, my tag stays.
>=20
>> @@ -502,10 +509,17 @@ dwapb_gpio_get_pdata(struct device *dev)
>>                         }
>>                 }
>>
>> +               if (has_acpi_companion(dev) && pp->idx =3D=3D 0)
>> +                       pp->irq =3D platform_get_irq(to_platform_dev=
ice(dev), 0);
>> +
>=20
>>                 pp->irq_shared  =3D false;
>>                 pp->gpio_base   =3D -1;
>=20
>=20
>> +
>>                 if (dev->of_node)
>>                         pp->name =3D to_of_node(fwnode)->full_name;
>=20
> This change doesn't belong the patch, though it should gone with the
> two lines of pp->name assignment as per Alan's suggestion to get rid
> of pp->name completely.

Agree, I plan to take Alan's suggestion, thank you.

>=20
>> +
>> +               if (has_acpi_companion(dev))
>> +                       pp->name =3D acpi_dev_name(to_acpi_device_no=
de(fwnode));
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
