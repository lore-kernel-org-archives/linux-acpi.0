From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v7 1/3] gpio: dwapb: remove name from dwapb_port_property
Date: Thu, 7 Apr 2016 19:45:30 +0800
Message-ID: <5706485A.1000802@huawei.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
 <1459926480-32966-2-git-send-email-qiujiang@huawei.com>
 <CAHp75Vc4OxOtA1jseX+BOP9zRzsV98z4VKiY=rdpLdi7K2umNg@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc4OxOtA1jseX+BOP9zRzsV98z4VKiY=rdpLdi7K2umNg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

Thanks for your reply. See my comments inline.

Thanks
Jiang

=E5=9C=A8 2016/4/6 20:57, Andy Shevchenko =E5=86=99=E9=81=93:
> On Wed, Apr 6, 2016 at 10:07 AM, qiujiang <qiujiang@huawei.com> wrote=
:
>> This patch removed the name property from dwapb_port_property.
>> The name property is redundant because we can get those info
>> from dwapb_gpio dev and pp->idx property.
>=20
> Where idx is used in such replacements?
Actually, it is not used so far. As Alan mentioned, the only additional
info from the pp->name against dev is the port index. I present here to
prevent anyone from missing it.

If it is inappropriate, I will remove it.

>=20
>> --- a/drivers/gpio/gpio-dwapb.c
>> +++ b/drivers/gpio/gpio-dwapb.c
>> @@ -409,8 +409,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio=
 *gpio,
>>         err =3D bgpio_init(&port->gc, gpio->dev, 4, dat, set, NULL, =
dirout,
>>                          NULL, false);
>>         if (err) {
>> -               dev_err(gpio->dev, "failed to init gpio chip for %s\=
n",
>> -                       pp->name);
>> +               dev_err(gpio->dev, "failed to init gpio chip\n");
>=20
> Do we have any port index here available (expected value I suppose)?

The 3rd parameter 'offs' can be used, I will add it.
>=20
>> @@ -429,8 +428,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio=
 *gpio,
>>
>>         err =3D gpiochip_add_data(&port->gc, port);
>>         if (err)
>> -               dev_err(gpio->dev, "failed to register gpiochip for =
%s\n",
>> -                       pp->name);
>> +               dev_err(gpio->dev, "failed to register gpiochip\n");
>=20
> Ditto.
>=20
>=20
>> @@ -499,15 +498,12 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>                 if (pp->idx =3D=3D 0 &&
>>                     of_property_read_bool(port_np, "interrupt-contro=
ller")) {
>>                         pp->irq =3D irq_of_parse_and_map(port_np, 0)=
;
>> -                       if (!pp->irq) {
>> -                               dev_warn(dev, "no irq for bank %s\n"=
,
>> -                                        port_np->full_name);
>> -                       }
>> +                       if (!pp->irq)
>> +                               dev_warn(dev, "no irq for this bank\=
n");
>=20
> pp->idx here?
>=20
> dev_warn(dev, "no irq for port%d\n", pp->idx);

Here, pp->idx should always be zero, means portA, because only portA ca=
n be a
interrupt controller as dwapb gpio IP defined. So, I omited it.

>=20
>> --- a/drivers/mfd/intel_quark_i2c_gpio.c
>> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
>> @@ -220,7 +220,6 @@ static int intel_quark_gpio_setup(struct pci_dev=
 *pdev, struct mfd_cell *cell)
>>
>>         /* Set the properties for portA */
>>         pdata->properties->node         =3D NULL;
>> -       pdata->properties->name         =3D "intel-quark-x1000-gpio-=
portA";
>>         pdata->properties->idx          =3D 0;
>>         pdata->properties->ngpio        =3D INTEL_QUARK_MFD_NGPIO;
>>         pdata->properties->gpio_base    =3D INTEL_QUARK_MFD_GPIO_BAS=
E;
>=20
> For Quark part:
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
