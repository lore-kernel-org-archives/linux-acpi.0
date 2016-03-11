From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v5 1/3] gpio: designware: convert device node to fwnode
Date: Fri, 11 Mar 2016 08:44:38 +0800
Message-ID: <56E214F6.3070607@huawei.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
 <1457077474-124064-2-git-send-email-qiujiang@huawei.com>
 <CANk1AXRTvSRZkWMQf03Ty+ouxcJDpD-hJ9tjXSqh5Z0OzOhk+w@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:3805 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbcCKApn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 19:45:43 -0500
In-Reply-To: <CANk1AXRTvSRZkWMQf03Ty+ouxcJDpD-hJ9tjXSqh5Z0OzOhk+w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Tull <delicious.quinoa@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

=E5=9C=A8 2016/3/11 3:09, Alan Tull =E5=86=99=E9=81=93:
> On Fri, Mar 4, 2016 at 1:44 AM, qiujiang <qiujiang@huawei.com> wrote:
>> This patch converts device node to fwnode in
>> dwapb_port_property for designware gpio driver,
>> so as to provide a unified data structure for DT
>> and ACPI bindings.
>>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>> ---
>>  drivers/gpio/gpio-dwapb.c                | 43 +++++++++++++++------=
-----------
>>  drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
>>  include/linux/platform_data/gpio-dwapb.h |  2 +-
>>  3 files changed, 22 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
>> index 597de1e..49f6e5d 100644
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
>>  #endif
>>         port->gc.ngpio =3D pp->ngpio;
>>         port->gc.base =3D pp->gpio_base;
>> @@ -449,17 +451,13 @@ static void dwapb_gpio_unregister(struct dwapb=
_gpio *gpio)
>>  static struct dwapb_platform_data *
>>  dwapb_gpio_get_pdata_of(struct device *dev)
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
>> @@ -474,21 +472,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
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
>> -                       dev_err(dev, "missing/invalid port index for=
 %s\n",
>> -                               port_np->full_name);
>> +                       dev_err(dev, "missing/invalid port index\n")=
;
>>                         return ERR_PTR(-EINVAL);
>>                 }
>>
>> -               if (of_property_read_u32(port_np, "snps,nr-gpios",
>> +               if (fwnode_property_read_u32(fwnode, "snps,nr-gpios"=
,
>>                                          &pp->ngpio)) {
>> -                       dev_info(dev, "failed to get number of gpios=
 for %s\n",
>> -                                port_np->full_name);
>> +                       dev_info(dev, "failed to get number of gpios=
\n");
>>                         pp->ngpio =3D 32;
>>                 }
>>
>> @@ -496,18 +492,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
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
> Hi Qiujiang,
>
> Is there a reason to use "of_property_read_bool" here instead of
> "device_property_read_bool" or similar?
>
> Alan
Agree, "to_of_node" should be never used since it coverted to fwnode.

I will give a more reasonable solution in the next version.

Thanks, Jiang
>
>> +                       pp->irq =3D irq_of_parse_and_map(to_of_node(=
fwnode), 0);
>>                         if (!pp->irq) {
>>                                 dev_warn(dev, "no irq for bank %s\n"=
,
>> -                                        port_np->full_name);
>> +                                        to_of_node(fwnode)->full_na=
me);
>>                         }
>>                 }
>>
>>                 pp->irq_shared  =3D false;
>>                 pp->gpio_base   =3D -1;
>> -               pp->name        =3D port_np->full_name;
>> +               pp->name        =3D to_of_node(fwnode)->full_name;
>>         }
>>
>>         return pdata;
>> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_=
quark_i2c_gpio.c
>> index 0421374..265bd3c 100644
>> --- a/drivers/mfd/intel_quark_i2c_gpio.c
>> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
>> @@ -227,7 +227,7 @@ static int intel_quark_gpio_setup(struct pci_dev=
 *pdev, struct mfd_cell *cell)
>>                 return -ENOMEM;
>>
>>         /* Set the properties for portA */
>> -       pdata->properties->node         =3D NULL;
>> +       pdata->properties->fwnode       =3D NULL;
>>         pdata->properties->name         =3D "intel-quark-x1000-gpio-=
portA";
>>         pdata->properties->idx          =3D 0;
>>         pdata->properties->ngpio        =3D INTEL_QUARK_MFD_NGPIO;
>> diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linu=
x/platform_data/gpio-dwapb.h
>> index 28702c8..c5bd1f2 100644
>> --- a/include/linux/platform_data/gpio-dwapb.h
>> +++ b/include/linux/platform_data/gpio-dwapb.h
>> @@ -15,7 +15,7 @@
>>  #define GPIO_DW_APB_H
>>
>>  struct dwapb_port_property {
>> -       struct device_node *node;
>> +       struct fwnode_handle *fwnode;
>>         const char      *name;
>>         unsigned int    idx;
>>         unsigned int    ngpio;
>> --
>> 1.9.1
>>
> .
>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
