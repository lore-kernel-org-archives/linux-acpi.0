From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v3 2/2] gpio: designware: add gpio-signaled acpi events
 support for power button
Date: Thu, 25 Feb 2016 20:13:44 +0800
Message-ID: <56CEEFF8.6080304@huawei.com>
References: <1456317210-42742-1-git-send-email-qiujiang@huawei.com>
 <1456317210-42742-3-git-send-email-qiujiang@huawei.com>
 <CAHp75VeFydKKc6GmWbLJ2uSBmxG2ObGX51i-NrNBAdaR57nXCA@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeFydKKc6GmWbLJ2uSBmxG2ObGX51i-NrNBAdaR57nXCA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org



=E5=9C=A8 2016/2/24 21:49, Andy Shevchenko =E5=86=99=E9=81=93:
> On Wed, Feb 24, 2016 at 2:33 PM, qiujiang <qiujiang@huawei.com> wrote=
:
>> This patch modifies the designware gpio controller driver to
>> support the gpio-signaled acpi events. This is used for power
>> button on hisilicon D02 board(an arm64 platform).
>=20
>> @@ -434,6 +436,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpi=
o *gpio,
>>         else
>>                 port->is_registered =3D true;
>>
>> +       /* Add GPIO-signaled ACPI event support */
>> +       if (pp->irq)
>> +               acpi_gpiochip_request_interrupts(&(port->gc));
>=20
> Redundant parens.
OK, fixed it in next version, thank you.
>=20
>> @@ -447,7 +453,7 @@ static void dwapb_gpio_unregister(struct dwapb_g=
pio *gpio)
>>  }
>>
>>  static struct dwapb_platform_data *
>> -dwapb_gpio_get_pdata_of(struct device *dev)
>> +dwapb_gpio_get_pdata(struct device *dev)
>>  {
>>         struct fwnode_handle *fwnode;
>>         struct dwapb_platform_data *pdata;
>> @@ -455,9 +461,6 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>         int nports;
>>         int i;
>>
>=20
>> -       if (!IS_ENABLED(CONFIG_OF_GPIO) || !(dev->of_node))
>> -               return ERR_PTR(-ENODEV);
>> -
>=20
> I think it belongs to patch 1.
If these code remove to patch1, it will contain ACPI support and patch2
implement GPIO-signaled acpi events support only.

Maybe this patchset partition looks more clearly, I think.
>=20
>> @@ -479,15 +482,13 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>
>>                 if (fwnode_property_read_u32(fwnode, "reg", &pp->idx=
) ||
>>                     pp->idx >=3D DWAPB_MAX_PORTS) {
>> -                       dev_err(dev, "missing/invalid port index for=
 %s\n",
>> -                               to_of_node(fwnode)->full_name);
>> +                       dev_err(dev, "missing/invalid port index\n")=
;
>=20
> Ditto.
>=20
>> -                       dev_info(dev, "failed to get number of gpios=
 for %s\n",
>> -                                to_of_node(fwnode)->full_name);
>> +                       dev_info(dev, "failed to get number of gpios=
\n");
>=20
> Ditto.
>=20
>> @@ -495,7 +496,7 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>                  * Only port A can provide interrupts in all configu=
rations of
>>                  * the IP.
>>                  */
>> -               if (pp->idx =3D=3D 0 &&
>> +               if (dev->of_node && pp->idx =3D=3D 0 &&
>=20
> Why is it needed?
Different APIs was used to parse interrupt resource for DT and ACPI, a =
unified way
platform_get_irq looks like more resonable, I will fixed it in the next=
 version.
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
