From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v9 2/3] gpio: dwapb: convert device node to fwnode
Date: Thu, 21 Apr 2016 19:33:21 +0800
Message-ID: <5718BA81.2070704@huawei.com>
References: <1461136429-85114-1-git-send-email-qiujiang@huawei.com>
 <1461136429-85114-3-git-send-email-qiujiang@huawei.com>
 <CAHp75Vd7eNH546ZUhzkt30Xi_jFpHMn+seLQXLhuvbwC+g7bsA@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd7eNH546ZUhzkt30Xi_jFpHMn+seLQXLhuvbwC+g7bsA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2016/4/20 21:04, Andy Shevchenko =E5=86=99=E9=81=93:
> On Wed, Apr 20, 2016 at 10:13 AM, Jiang Qiu <qiujiang@huawei.com> wro=
te:
>> This patch converts device node to fwnode for dwapb driver, so
>> as to provide a unified fwnode for DT and ACPI bindings.
>>
>> Tested-by: Alan Tull <delicious.quinoa@gmail.com>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Jiang Qiu <qiujiang@huawei.com>
>> ---
>>  drivers/gpio/gpio-dwapb.c                | 37 ++++++++++++++++-----=
-----------
>>  drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
>>  include/linux/platform_data/gpio-dwapb.h |  2 +-
>>  3 files changed, 20 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
>> index 772d743..92bc204 100644
>> --- a/drivers/gpio/gpio-dwapb.c
>> +++ b/drivers/gpio/gpio-dwapb.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/property.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/platform_data/gpio-dwapb.h>
>>  #include <linux/slab.h>
>> @@ -290,14 +291,14 @@ static void dwapb_configure_irqs(struct dwapb_=
gpio *gpio,
>>                                  struct dwapb_port_property *pp)
>>  {
>>         struct gpio_chip *gc =3D &port->gc;
>> -       struct device_node *node =3D pp->node;
>> +       struct fwnode_handle  *fwnode =3D pp->fwnode;
>>         struct irq_chip_generic *irq_gc =3D NULL;
>>         unsigned int hwirq, ngpio =3D gc->ngpio;
>>         struct irq_chip_type *ct;
>>         int err, i;
>>
>> -       gpio->domain =3D irq_domain_add_linear(node, ngpio,
>> -                                            &irq_generic_chip_ops, =
gpio);
>> +       gpio->domain =3D irq_domain_create_linear(fwnode, ngpio,
>> +                                                &irq_generic_chip_o=
ps, gpio);
>>         if (!gpio->domain)
>>                 return;
>>
>> @@ -415,7 +416,8 @@ static int dwapb_gpio_add_port(struct dwapb_gpio=
 *gpio,
>>         }
>>
>>  #ifdef CONFIG_OF_GPIO
>> -       port->gc.of_node =3D pp->node;
>> +       port->gc.of_node =3D is_of_node(pp->fwnode) ?
>> +               to_of_node(pp->fwnode) : NULL;
>=20
> Someone commented on this that it's simple
> =E2=80=A6of_node =3D to_of_node(=E2=80=A6);
>
Yes, the to_of_node() function has checked as like above, as follow:

static inline struct device_node *to_of_node(struct fwnode_handle *fwno=
de)
{
	return is_of_node(fwnode) ?
		container_of(fwnode, struct device_node, fwnode) : NULL;
}

Next version, I will fixed it.

>>  #endif
>>         port->gc.ngpio =3D pp->ngpio;
>>         port->gc.base =3D pp->gpio_base;
>> @@ -447,19 +449,15 @@ static void dwapb_gpio_unregister(struct dwapb=
_gpio *gpio)
>>  }
>>
>>  static struct dwapb_platform_data *
>> -dwapb_gpio_get_pdata_of(struct device *dev)
>> +dwapb_gpio_get_pdata(struct device *dev)
>>  {
>> -       struct device_node *node, *port_np;
>> +       struct fwnode_handle *fwnode;
>>         struct dwapb_platform_data *pdata;
>>         struct dwapb_port_property *pp;
>>         int nports;
>>         int i;
>>
>> -       node =3D dev->of_node;
>> -       if (!IS_ENABLED(CONFIG_OF_GPIO) || !node)
>> -               return ERR_PTR(-ENODEV);
>> -
>> -       nports =3D of_get_child_count(node);
>> +       nports =3D device_get_child_node_count(dev);
>>         if (nports =3D=3D 0)
>>                 return ERR_PTR(-ENODEV);
>>
>> @@ -474,18 +472,18 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>         pdata->nports =3D nports;
>>
>>         i =3D 0;
>> -       for_each_child_of_node(node, port_np) {
>> +       device_for_each_child_node(dev, fwnode)  {
>>                 pp =3D &pdata->properties[i++];
>> -               pp->node =3D port_np;
>> +               pp->fwnode =3D fwnode;
>>
>> -               if (of_property_read_u32(port_np, "reg", &pp->idx) |=
|
>> +               if (fwnode_property_read_u32(fwnode, "reg", &pp->idx=
) ||
>>                     pp->idx >=3D DWAPB_MAX_PORTS) {
>>                         dev_err(dev,
>>                                 "missing/invalid port index for port=
%d\n", i);
>>                         return ERR_PTR(-EINVAL);
>>                 }
>>
>> -               if (of_property_read_u32(port_np, "snps,nr-gpios",
>> +               if (fwnode_property_read_u32(fwnode, "snps,nr-gpios"=
,
>>                                          &pp->ngpio)) {
>>                         dev_info(dev,
>>                                  "failed to get number of gpios for =
port%d\n",
>> @@ -497,9 +495,10 @@ dwapb_gpio_get_pdata_of(struct device *dev)
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
>> +                       fwnode_property_read_bool(fwnode,
>> +                                                 "interrupt-control=
ler")) {
>> +                       pp->irq =3D irq_of_parse_and_map(to_of_node(=
fwnode), 0);
>>                         if (!pp->irq)
>>                                 dev_warn(dev, "no irq for port%d\n",=
 pp->idx);
>>                 }
>> @@ -521,7 +520,7 @@ static int dwapb_gpio_probe(struct platform_devi=
ce *pdev)
>>         struct dwapb_platform_data *pdata =3D dev_get_platdata(dev);
>>
>>         if (!pdata) {
>> -               pdata =3D dwapb_gpio_get_pdata_of(dev);
>> +               pdata =3D dwapb_gpio_get_pdata(dev);
>>                 if (IS_ERR(pdata))
>>                         return PTR_ERR(pdata);
>>         }
>> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_=
quark_i2c_gpio.c
>> index a4ef99b..a24b35f 100644
>> --- a/drivers/mfd/intel_quark_i2c_gpio.c
>> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
>> @@ -219,7 +219,7 @@ static int intel_quark_gpio_setup(struct pci_dev=
 *pdev, struct mfd_cell *cell)
>>                 return -ENOMEM;
>>
>>         /* Set the properties for portA */
>> -       pdata->properties->node         =3D NULL;
>> +       pdata->properties->fwnode       =3D NULL;
>>         pdata->properties->idx          =3D 0;
>>         pdata->properties->ngpio        =3D INTEL_QUARK_MFD_NGPIO;
>>         pdata->properties->gpio_base    =3D INTEL_QUARK_MFD_GPIO_BAS=
E;
>> diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linu=
x/platform_data/gpio-dwapb.h
>> index 955b579..2dc7f4a 100644
>> --- a/include/linux/platform_data/gpio-dwapb.h
>> +++ b/include/linux/platform_data/gpio-dwapb.h
>> @@ -15,7 +15,7 @@
>>  #define GPIO_DW_APB_H
>>
>>  struct dwapb_port_property {
>> -       struct device_node *node;
>> +       struct fwnode_handle *fwnode;
>>         unsigned int    idx;
>>         unsigned int    ngpio;
>>         unsigned int    gpio_base;
>> --
>> 1.9.1
>>
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
