From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v7 2/3] gpio: dwapb: convert device node to fwnode
Date: Fri, 15 Apr 2016 10:29:53 +0800
Message-ID: <57105221.2030202@huawei.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
 <1459926480-32966-3-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1459926480-32966-3-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>, linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-acpi@vger.kernel.org, charles.chenxin@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, linux-gpio@vger.kernel.org, andy.shevchenko@gmail.com, jamie@jamieiles.com, mika.westerberg@linux.intel.com, delicious.quinoa@gmail.com
List-Id: linux-acpi@vger.kernel.org



On 2016/4/6 15:07, qiujiang wrote:
> This patch converts device node to fwnode for dwapb driver, so
> as to provide a unified fwnode for DT and ACPI bindings.
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: qiujiang <qiujiang@huawei.com>
> ---
>  drivers/gpio/gpio-dwapb.c                | 37 ++++++++++++++++----------------
>  drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
>  include/linux/platform_data/gpio-dwapb.h |  2 +-
>  3 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 91afec8..3c4d8e6 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/spinlock.h>
>  #include <linux/platform_data/gpio-dwapb.h>
>  #include <linux/slab.h>
> @@ -290,14 +291,14 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
>  				 struct dwapb_port_property *pp)
>  {
>  	struct gpio_chip *gc = &port->gc;
> -	struct device_node *node = pp->node;
> +	struct fwnode_handle  *fwnode = pp->fwnode;
>  	struct irq_chip_generic	*irq_gc = NULL;
>  	unsigned int hwirq, ngpio = gc->ngpio;
>  	struct irq_chip_type *ct;
>  	int err, i;
>  
> -	gpio->domain = irq_domain_add_linear(node, ngpio,
> -					     &irq_generic_chip_ops, gpio);
> +	gpio->domain = irq_domain_create_linear(fwnode, ngpio,
> +						 &irq_generic_chip_ops, gpio);
>  	if (!gpio->domain)
>  		return;
>  
> @@ -414,7 +415,8 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>  	}
>  
>  #ifdef CONFIG_OF_GPIO
> -	port->gc.of_node = pp->node;
> +	port->gc.of_node = is_of_node(pp->fwnode) ?
> +		to_of_node(pp->fwnode) : NULL;

It is enough to use port->gc.of_node = to_of_node(pp->fwnode);


