From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH] GPIO/ACPI: DesignWare: Add GPIO-signaled ACPI events
 support for power button
Date: Tue, 16 Feb 2016 11:24:49 +0200
Message-ID: <20160216092449.GE1742@lahna.fi.intel.com>
References: <1454653542-122055-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454653542-122055-1-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 05, 2016 at 02:25:42PM +0800, qiujiang wrote:
> This patch modifies the DesignWare GPIO controller driver to
> support the GPIO-signaled ACPI Events. This is used for power
> button function on ARM server.
> 
> To make it work, the _AEI and _EVT object must be defined in
> the corresponding GPIO driver's dsdt table in UEFI. At the same
> time, ACPI daemon component is also necessary.

In general ACPI parts look ok to me. I would like to see ACPI DSDT table
entry for this device though.

There are few minor comments below.

> Signed-off-by: qiujiang <qiujiang@huawei.com>
> ---
>  drivers/gpio/gpio-dwapb.c                | 75 ++++++++++++++++++++------------
>  include/linux/platform_data/gpio-dwapb.h |  2 +-
>  2 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index fcd5b0a..bfed2e9 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -23,6 +23,11 @@
>  #include <linux/spinlock.h>
>  #include <linux/platform_data/gpio-dwapb.h>
>  #include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/gpio.h>
> +
> +#include "gpiolib.h"
> +
>  
>  #define GPIO_SWPORTA_DR		0x00
>  #define GPIO_SWPORTA_DDR	0x04
> @@ -296,14 +301,14 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
>  				 struct dwapb_port_property *pp)
>  {
>  	struct gpio_chip *gc = &port->bgc.gc;
> -	struct device_node *node = pp->node;
> +	struct fwnode_handle  *fwnode = pp->fwnode;
>  	struct irq_chip_generic	*irq_gc = NULL;
>  	unsigned int hwirq, ngpio = gc->ngpio;
>  	struct irq_chip_type *ct;
>  	int err, i;
>  
> -	gpio->domain = irq_domain_add_linear(node, ngpio,
> -					     &irq_generic_chip_ops, gpio);
> +	gpio->domain = irq_domain_create_linear(fwnode,
> +				ngpio, &irq_generic_chip_ops, gpio);
>  	if (!gpio->domain)
>  		return;
>  
> @@ -421,7 +426,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>  	}
>  
>  #ifdef CONFIG_OF_GPIO
> -	port->bgc.gc.of_node = pp->node;
> +	port->bgc.gc.of_node = to_of_node(pp->fwnode);
>  #endif
>  	port->bgc.gc.ngpio = pp->ngpio;
>  	port->bgc.gc.base = pp->gpio_base;
> @@ -440,6 +445,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>  	else
>  		port->is_registered = true;
>  
> +	/* Add GPIO-signaled ACPI event support */
> +	if (pp->irq)
> +		acpi_gpiochip_request_interrupts(&(port->bgc.gc));
> +
>  	return err;
>  }
>  
> @@ -453,19 +462,15 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
>  }
>  
>  static struct dwapb_platform_data *
> -dwapb_gpio_get_pdata_of(struct device *dev)
> +dwapb_gpio_get_pdata(struct device *dev)
>  {
> -	struct device_node *node, *port_np;
> +	struct fwnode_handle *fwnode;
>  	struct dwapb_platform_data *pdata;
>  	struct dwapb_port_property *pp;
>  	int nports;
>  	int i;
>  
> -	node = dev->of_node;
> -	if (!IS_ENABLED(CONFIG_OF_GPIO) || !node)
> -		return ERR_PTR(-ENODEV);
> -
> -	nports = of_get_child_count(node);
> +	nports = device_get_child_node_count(dev);
>  	if (nports == 0)
>  		return ERR_PTR(-ENODEV);
>  
> @@ -480,21 +485,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>  	pdata->nports = nports;
>  
>  	i = 0;
> -	for_each_child_of_node(node, port_np) {
> -		pp = &pdata->properties[i++];
> -		pp->node = port_np;
> +	device_for_each_child_node(dev, fwnode) {
> +		pp = &pdata->properties[i];
> +		pp->fwnode = fwnode;
>  
> -		if (of_property_read_u32(port_np, "reg", &pp->idx) ||
> +		if (fwnode_property_read_u32(fwnode, "reg", &pp->idx) ||
>  		    pp->idx >= DWAPB_MAX_PORTS) {
> -			dev_err(dev, "missing/invalid port index for %s\n",
> -				port_np->full_name);
> +			dev_err(dev, "missing/invalid port index\n");
>  			return ERR_PTR(-EINVAL);
>  		}
>  
> -		if (of_property_read_u32(port_np, "snps,nr-gpios",
> +		if (fwnode_property_read_u32(fwnode, "snps,nr-gpios",
>  					 &pp->ngpio)) {
> -			dev_info(dev, "failed to get number of gpios for %s\n",
> -				 port_np->full_name);
> +			dev_info(dev, "failed to get number of gpios\n");
>  			pp->ngpio = 32;
>  		}
>  
> @@ -502,18 +505,27 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>  		 * Only port A can provide interrupts in all configurations of
>  		 * the IP.
>  		 */
> -		if (pp->idx == 0 &&
> -		    of_property_read_bool(port_np, "interrupt-controller")) {
> -			pp->irq = irq_of_parse_and_map(port_np, 0);
> +		 if (dev->of_node && pp->idx == 0 &&
> +			 of_property_read_bool(to_of_node(fwnode),
> +			 "interrupt-controller")) {
> +			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
>  			if (!pp->irq) {
> -				dev_warn(dev, "no irq for bank %s\n",
> -					 port_np->full_name);
> +			dev_warn(dev, "no irq for bank %s\n",
> +				  to_of_node(fwnode)->full_name);
>  			}
>  		}
>  
> +		if (ACPI_COMPANION(dev) && pp->idx == 0)

You can also use has_acpi_companion(dev) here.

> +			pp->irq = platform_get_irq(to_platform_device(dev), 0);
> +
>  		pp->irq_shared	= false;
>  		pp->gpio_base	= -1;
> -		pp->name	= port_np->full_name;
> +
> +		if (dev->of_node)
> +			pp->name = to_of_node(fwnode)->full_name;
> +
> +		if (ACPI_COMPANION(dev))
> +			pp->name = acpi_dev_name(to_acpi_device_node(fwnode));
>  	}
>  
>  	return pdata;
> @@ -529,7 +541,7 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
>  	struct dwapb_platform_data *pdata = dev_get_platdata(dev);
>  
>  	if (!pdata) {
> -		pdata = dwapb_gpio_get_pdata_of(dev);
> +		pdata = dwapb_gpio_get_pdata(dev);
>  		if (IS_ERR(pdata))
>  			return PTR_ERR(pdata);
>  	}
> @@ -559,6 +571,7 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
>  		if (err)
>  			goto out_unregister;
>  	}
> +

Unrelated whitespace change.

>  	platform_set_drvdata(pdev, gpio);
>  
>  	return 0;
> @@ -586,6 +599,13 @@ static const struct of_device_id dwapb_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, dwapb_of_match);
>  
> +static const struct acpi_device_id dwapb_acpi_match[] = {
> +		{"HISI0181", 0},

Too many tabs.

> +		{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, dwapb_acpi_match);
> +
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int dwapb_gpio_suspend(struct device *dev)
>  {
> @@ -680,6 +700,7 @@ static struct platform_driver dwapb_gpio_driver = {
>  		.name	= "gpio-dwapb",
>  		.pm	= &dwapb_gpio_pm_ops,
>  		.of_match_table = of_match_ptr(dwapb_of_match),
> +		.acpi_match_table = ACPI_PTR(dwapb_acpi_match),
>  	},
>  	.probe		= dwapb_gpio_probe,
>  	.remove		= dwapb_gpio_remove,
> diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
> index 28702c8..c5bd1f2 100644
> --- a/include/linux/platform_data/gpio-dwapb.h
> +++ b/include/linux/platform_data/gpio-dwapb.h
> @@ -15,7 +15,7 @@
>  #define GPIO_DW_APB_H
>  
>  struct dwapb_port_property {
> -	struct device_node *node;
> +	struct fwnode_handle *fwnode;
>  	const char	*name;
>  	unsigned int	idx;
>  	unsigned int	ngpio;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
