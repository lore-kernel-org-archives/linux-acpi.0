From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v4 1/2] gpio: designware: switch device node to fwnode and
 add acpi binding
Date: Tue, 1 Mar 2016 14:41:42 +0800
Message-ID: <56D539A6.1080906@huawei.com>
References: <1456751596-98963-1-git-send-email-qiujiang@huawei.com>
 <1456751596-98963-2-git-send-email-qiujiang@huawei.com>
 <CAHp75Ves-+6pj_LZccxkKugXxJ9NJUwSotSCRf6=aOveBOx=Jg@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ves-+6pj_LZccxkKugXxJ9NJUwSotSCRf6=aOveBOx=Jg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2016/2/29 21:51, Andy Shevchenko =E5=86=99=E9=81=93:
> On Mon, Feb 29, 2016 at 3:13 PM, qiujiang <qiujiang@huawei.com> wrote=
:
>> This patch switches device node to fwnode and adds acpi
>> binding. As a result, DT and acpi bingdings are compatible
>> for this driver.
>=20
> I'm not sure it makes sense to add ACPI binding here. It more logical
> to me to add them in patch 2/2.
> And I see that it touches different subsystems.
>=20
>>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Due to above and Mika's Ack was only to ACPI parts, I think
> you may be split this also to two and we will have clearly logical se=
t:
> 1. Convert to fwnode
> 2. Add ACPI bindings
> 3. ACPI event support.
>=20
> Does it sound okay to you?
>=20
> If you do that I give my
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> to intel_quark_i2c_gpio.c part and
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> to the rest.
>=20
>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>> ---
>>  drivers/gpio/gpio-dwapb.c                | 62 +++++++++++++++++++--=
-----------
>>  drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
>>  include/linux/platform_data/gpio-dwapb.h |  2 +-
>>  3 files changed, 39 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
>> index 597de1e..7a37c65 100644
>> --- a/drivers/gpio/gpio-dwapb.c
>> +++ b/drivers/gpio/gpio-dwapb.c
>> @@ -7,6 +7,7 @@
>>   *
>>   * All enquiries to support@picochip.com
>>   */
>> +#include <linux/acpi.h>
>=20
> +#include <linux/property.h> instead (see above).
>=20
>>  #include <linux/gpio/driver.h>
>>  /* FIXME: for gpio_get_value(), replace this with direct register r=
ead */
>>  #include <linux/gpio.h>
>=20
>> @@ -496,18 +492,27 @@ dwapb_gpio_get_pdata_of(struct device *dev)
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
>> +                       of_property_read_bool(to_of_node(fwnode),
>> +                               "interrupt-controller")) {
>=20
>> +               if (has_acpi_companion(dev) && pp->idx =3D=3D 0)
>> +                       pp->irq =3D platform_get_irq(to_platform_dev=
ice(dev), 0);
>> +
>=20
> To patch 2.
>=20
>>                 pp->irq_shared  =3D false;
>>                 pp->gpio_base   =3D -1;
>=20
>> -               pp->name        =3D port_np->full_name;
>> +
>> +               if (dev->of_node)
>> +                       pp->name =3D to_of_node(fwnode)->full_name;
>> +
>=20
> And here you have to provide something in case of default / built-in
> device properties.
Sorry, I'm not very clear here about the case of default / built-in dev=
ice
properties, can you give a example about what will the code look like ?
>=20
>=20
>> +               if (has_acpi_companion(dev))
>> +                       pp->name =3D acpi_dev_name(to_acpi_device_no=
de(fwnode));
>=20
> To patch 2.
>=20
>>         }
>>
>>         return pdata;
>=20
>> @@ -580,6 +585,12 @@ static const struct of_device_id dwapb_of_match=
[] =3D {
>>  };
>>  MODULE_DEVICE_TABLE(of, dwapb_of_match);
>>
>> +static const struct acpi_device_id dwapb_acpi_match[] =3D {
>> +       {"HISI0181", 0},
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, dwapb_acpi_match);
>> +
>>  #ifdef CONFIG_PM_SLEEP
>>  static int dwapb_gpio_suspend(struct device *dev)
>>  {
>> @@ -674,6 +685,7 @@ static struct platform_driver dwapb_gpio_driver =
=3D {
>>                 .name   =3D "gpio-dwapb",
>>                 .pm     =3D &dwapb_gpio_pm_ops,
>>                 .of_match_table =3D of_match_ptr(dwapb_of_match),
>> +               .acpi_match_table =3D ACPI_PTR(dwapb_acpi_match),
>>         },
>>         .probe          =3D dwapb_gpio_probe,
>>         .remove         =3D dwapb_gpio_remove,
>=20
> Ditto to the above hunks.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
