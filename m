From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [RFC PATCH] GPIO/ACPI: DesignWare: Add GPIO-signaled ACPI events
 support for power button
Date: Tue, 16 Feb 2016 20:43:06 +0800
Message-ID: <56C3195A.7050001@huawei.com>
References: <1454653542-122055-1-git-send-email-qiujiang@huawei.com>
 <20160216092449.GE1742@lahna.fi.intel.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160216092449.GE1742@lahna.fi.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2016/2/16 17:24, Mika Westerberg =E5=86=99=E9=81=93:
> On Fri, Feb 05, 2016 at 02:25:42PM +0800, qiujiang wrote:
>> This patch modifies the DesignWare GPIO controller driver to
>> support the GPIO-signaled ACPI Events. This is used for power
>> button function on ARM server.
>>
>> To make it work, the _AEI and _EVT object must be defined in
>> the corresponding GPIO driver's dsdt table in UEFI. At the same
>> time, ACPI daemon component is also necessary.
>=20
> In general ACPI parts look ok to me. I would like to see ACPI DSDT ta=
ble
> entry for this device though.
>=20
Thanks for review, the DSDT table for this driver is as follow:
Device(GPI0) {
        Name(_HID, "HISI0181")
	Name(_ADR, 0) // _ADR: Address
        Name(_UID, 0)
	=09
	Name (_CRS, ResourceTemplate ()  {
		Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
		Interrupt (ResourceConsumer, Level, ActiveHigh,
		Exclusive,,,) {344}
	})
	=09
	Device(PRTa) {
		Name (_DSD, Package () {
			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
			Package () {
				Package () {"reg",0},
				Package () {"snps,nr-gpios",32},
			}
		})
	}
	=09
	Name (_AEI, ResourceTemplate () {=09
		GpioInt(Edge, ActiveLow, ExclusiveAndWake, PullUp, ,
		" \\_SB.GPI0") {8}
	})
	=09
	Method (_E08, 0x0, NotSerialized) {
		Notify (\_SB.PWRB, 0x80)
	}
}
> There are few minor comments below.
>=20
>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>> ---
>>  drivers/gpio/gpio-dwapb.c                | 75 ++++++++++++++++++++-=
-----------
>>  include/linux/platform_data/gpio-dwapb.h |  2 +-
>>  2 files changed, 49 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
>> index fcd5b0a..bfed2e9 100644
>> --- a/drivers/gpio/gpio-dwapb.c
>> +++ b/drivers/gpio/gpio-dwapb.c
>> @@ -23,6 +23,11 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/platform_data/gpio-dwapb.h>
>>  #include <linux/slab.h>
>> +#include <linux/acpi.h>
>> +#include <linux/gpio.h>
>> +
>> +#include "gpiolib.h"
>> +
>> =20
>>  #define GPIO_SWPORTA_DR		0x00
>>  #define GPIO_SWPORTA_DDR	0x04
>> @@ -296,14 +301,14 @@ static void dwapb_configure_irqs(struct dwapb_=
gpio *gpio,
>>  				 struct dwapb_port_property *pp)
>>  {
>>  	struct gpio_chip *gc =3D &port->bgc.gc;
>> -	struct device_node *node =3D pp->node;
>> +	struct fwnode_handle  *fwnode =3D pp->fwnode;
>>  	struct irq_chip_generic	*irq_gc =3D NULL;
>>  	unsigned int hwirq, ngpio =3D gc->ngpio;
>>  	struct irq_chip_type *ct;
>>  	int err, i;
>> =20
>> -	gpio->domain =3D irq_domain_add_linear(node, ngpio,
>> -					     &irq_generic_chip_ops, gpio);
>> +	gpio->domain =3D irq_domain_create_linear(fwnode,
>> +				ngpio, &irq_generic_chip_ops, gpio);
>>  	if (!gpio->domain)
>>  		return;
>> =20
>> @@ -421,7 +426,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio=
 *gpio,
>>  	}
>> =20
>>  #ifdef CONFIG_OF_GPIO
>> -	port->bgc.gc.of_node =3D pp->node;
>> +	port->bgc.gc.of_node =3D to_of_node(pp->fwnode);
>>  #endif
>>  	port->bgc.gc.ngpio =3D pp->ngpio;
>>  	port->bgc.gc.base =3D pp->gpio_base;
>> @@ -440,6 +445,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpi=
o *gpio,
>>  	else
>>  		port->is_registered =3D true;
>> =20
>> +	/* Add GPIO-signaled ACPI event support */
>> +	if (pp->irq)
>> +		acpi_gpiochip_request_interrupts(&(port->bgc.gc));
>> +
>>  	return err;
>>  }
>> =20
>> @@ -453,19 +462,15 @@ static void dwapb_gpio_unregister(struct dwapb=
_gpio *gpio)
>>  }
>> =20
>>  static struct dwapb_platform_data *
>> -dwapb_gpio_get_pdata_of(struct device *dev)
>> +dwapb_gpio_get_pdata(struct device *dev)
>>  {
>> -	struct device_node *node, *port_np;
>> +	struct fwnode_handle *fwnode;
>>  	struct dwapb_platform_data *pdata;
>>  	struct dwapb_port_property *pp;
>>  	int nports;
>>  	int i;
>> =20
>> -	node =3D dev->of_node;
>> -	if (!IS_ENABLED(CONFIG_OF_GPIO) || !node)
>> -		return ERR_PTR(-ENODEV);
>> -
>> -	nports =3D of_get_child_count(node);
>> +	nports =3D device_get_child_node_count(dev);
>>  	if (nports =3D=3D 0)
>>  		return ERR_PTR(-ENODEV);
>> =20
>> @@ -480,21 +485,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>  	pdata->nports =3D nports;
>> =20
>>  	i =3D 0;
>> -	for_each_child_of_node(node, port_np) {
>> -		pp =3D &pdata->properties[i++];
>> -		pp->node =3D port_np;
>> +	device_for_each_child_node(dev, fwnode) {
>> +		pp =3D &pdata->properties[i];
>> +		pp->fwnode =3D fwnode;
>> =20
>> -		if (of_property_read_u32(port_np, "reg", &pp->idx) ||
>> +		if (fwnode_property_read_u32(fwnode, "reg", &pp->idx) ||
>>  		    pp->idx >=3D DWAPB_MAX_PORTS) {
>> -			dev_err(dev, "missing/invalid port index for %s\n",
>> -				port_np->full_name);
>> +			dev_err(dev, "missing/invalid port index\n");
>>  			return ERR_PTR(-EINVAL);
>>  		}
>> =20
>> -		if (of_property_read_u32(port_np, "snps,nr-gpios",
>> +		if (fwnode_property_read_u32(fwnode, "snps,nr-gpios",
>>  					 &pp->ngpio)) {
>> -			dev_info(dev, "failed to get number of gpios for %s\n",
>> -				 port_np->full_name);
>> +			dev_info(dev, "failed to get number of gpios\n");
>>  			pp->ngpio =3D 32;
>>  		}
>> =20
>> @@ -502,18 +505,27 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>  		 * Only port A can provide interrupts in all configurations of
>>  		 * the IP.
>>  		 */
>> -		if (pp->idx =3D=3D 0 &&
>> -		    of_property_read_bool(port_np, "interrupt-controller")) {
>> -			pp->irq =3D irq_of_parse_and_map(port_np, 0);
>> +		 if (dev->of_node && pp->idx =3D=3D 0 &&
>> +			 of_property_read_bool(to_of_node(fwnode),
>> +			 "interrupt-controller")) {
>> +			pp->irq =3D irq_of_parse_and_map(to_of_node(fwnode), 0);
>>  			if (!pp->irq) {
>> -				dev_warn(dev, "no irq for bank %s\n",
>> -					 port_np->full_name);
>> +			dev_warn(dev, "no irq for bank %s\n",
>> +				  to_of_node(fwnode)->full_name);
>>  			}
>>  		}
>> =20
>> +		if (ACPI_COMPANION(dev) && pp->idx =3D=3D 0)
>=20
> You can also use has_acpi_companion(dev) here.
OK, I will fix it, thank you.
>=20
>> +			pp->irq =3D platform_get_irq(to_platform_device(dev), 0);
>> +
>>  		pp->irq_shared	=3D false;
>>  		pp->gpio_base	=3D -1;
>> -		pp->name	=3D port_np->full_name;
>> +
>> +		if (dev->of_node)
>> +			pp->name =3D to_of_node(fwnode)->full_name;
>> +
>> +		if (ACPI_COMPANION(dev))
>> +			pp->name =3D acpi_dev_name(to_acpi_device_node(fwnode));
>>  	}
>> =20
>>  	return pdata;
>> @@ -529,7 +541,7 @@ static int dwapb_gpio_probe(struct platform_devi=
ce *pdev)
>>  	struct dwapb_platform_data *pdata =3D dev_get_platdata(dev);
>> =20
>>  	if (!pdata) {
>> -		pdata =3D dwapb_gpio_get_pdata_of(dev);
>> +		pdata =3D dwapb_gpio_get_pdata(dev);
>>  		if (IS_ERR(pdata))
>>  			return PTR_ERR(pdata);
>>  	}
>> @@ -559,6 +571,7 @@ static int dwapb_gpio_probe(struct platform_devi=
ce *pdev)
>>  		if (err)
>>  			goto out_unregister;
>>  	}
>> +
>=20
> Unrelated whitespace change.
=46ine, I will fix it.
>=20
>>  	platform_set_drvdata(pdev, gpio);
>> =20
>>  	return 0;
>> @@ -586,6 +599,13 @@ static const struct of_device_id dwapb_of_match=
[] =3D {
>>  };
>>  MODULE_DEVICE_TABLE(of, dwapb_of_match);
>> =20
>> +static const struct acpi_device_id dwapb_acpi_match[] =3D {
>> +		{"HISI0181", 0},
>=20
> Too many tabs.
>=20
Yes, here is my fault to this redundant tab, thanks for reminder.
>> +		{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, dwapb_acpi_match);
>> +
>> +
>>  #ifdef CONFIG_PM_SLEEP
>>  static int dwapb_gpio_suspend(struct device *dev)
>>  {
>> @@ -680,6 +700,7 @@ static struct platform_driver dwapb_gpio_driver =
=3D {
>>  		.name	=3D "gpio-dwapb",
>>  		.pm	=3D &dwapb_gpio_pm_ops,
>>  		.of_match_table =3D of_match_ptr(dwapb_of_match),
>> +		.acpi_match_table =3D ACPI_PTR(dwapb_acpi_match),
>>  	},
>>  	.probe		=3D dwapb_gpio_probe,
>>  	.remove		=3D dwapb_gpio_remove,
>> diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linu=
x/platform_data/gpio-dwapb.h
>> index 28702c8..c5bd1f2 100644
>> --- a/include/linux/platform_data/gpio-dwapb.h
>> +++ b/include/linux/platform_data/gpio-dwapb.h
>> @@ -15,7 +15,7 @@
>>  #define GPIO_DW_APB_H
>> =20
>>  struct dwapb_port_property {
>> -	struct device_node *node;
>> +	struct fwnode_handle *fwnode;
>>  	const char	*name;
>>  	unsigned int	idx;
>>  	unsigned int	ngpio;
>> --=20
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> .
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
