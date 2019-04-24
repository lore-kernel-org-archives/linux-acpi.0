From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Wed, 24 Apr 2019 10:58:16 +0300
Message-ID: <20190424075816.GU2654@lahna.fi.intel.com>
References: <cover.1555579429.git.jan.kiszka@siemens.com>
 <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

+Rafael and linux-acpi.

On Thu, Apr 18, 2019 at 11:23:49AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Validated on the Quark platform, this adds interrupt support on rising
> and/or falling edges.

The irqchip parts look good to me but but the ACPI SCI handling seems
weird. This is typically handled by ACPI core based on the values read
from FADT ACPI table. What does it contain on this Quark platform?

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/gpio/gpio-sch.c | 142 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 135 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
> index fb143f28c386..9459f1920996 100644
> --- a/drivers/gpio/gpio-sch.c
> +++ b/drivers/gpio/gpio-sch.c
> @@ -18,12 +18,17 @@
>  #define GEN	0x00
>  #define GIO	0x04
>  #define GLV	0x08
> +#define GTPE	0x0c
> +#define GTNE	0x10
> +#define GGPE	0x14
> +#define GTS	0x1c
>  
>  struct sch_gpio {
>  	struct gpio_chip chip;
>  	spinlock_t lock;
>  	unsigned short iobase;
>  	unsigned short resume_base;
> +	int irq_base;
>  };
>  
>  static unsigned sch_gpio_offset(struct sch_gpio *sch, unsigned gpio,
> @@ -79,10 +84,11 @@ static void sch_gpio_reg_set(struct sch_gpio *sch, unsigned gpio, unsigned reg,
>  static int sch_gpio_direction_in(struct gpio_chip *gc, unsigned gpio_num)
>  {
>  	struct sch_gpio *sch = gpiochip_get_data(gc);
> +	unsigned long flags;
>  
> -	spin_lock(&sch->lock);
> +	spin_lock_irqsave(&sch->lock, flags);
>  	sch_gpio_reg_set(sch, gpio_num, GIO, 1);
> -	spin_unlock(&sch->lock);
> +	spin_unlock_irqrestore(&sch->lock, flags);
>  	return 0;
>  }
>  
> @@ -95,20 +101,22 @@ static int sch_gpio_get(struct gpio_chip *gc, unsigned gpio_num)
>  static void sch_gpio_set(struct gpio_chip *gc, unsigned gpio_num, int val)
>  {
>  	struct sch_gpio *sch = gpiochip_get_data(gc);
> +	unsigned long flags;
>  
> -	spin_lock(&sch->lock);
> +	spin_lock_irqsave(&sch->lock, flags);
>  	sch_gpio_reg_set(sch, gpio_num, GLV, val);
> -	spin_unlock(&sch->lock);
> +	spin_unlock_irqrestore(&sch->lock, flags);
>  }
>  
>  static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned gpio_num,
>  				  int val)
>  {
>  	struct sch_gpio *sch = gpiochip_get_data(gc);
> +	unsigned long flags;
>  
> -	spin_lock(&sch->lock);
> +	spin_lock_irqsave(&sch->lock, flags);
>  	sch_gpio_reg_set(sch, gpio_num, GIO, 0);
> -	spin_unlock(&sch->lock);
> +	spin_unlock_irqrestore(&sch->lock, flags);
>  
>  	/*
>  	 * according to the datasheet, writing to the level register has no
> @@ -130,6 +138,12 @@ static int sch_gpio_get_direction(struct gpio_chip *gc, unsigned gpio_num)
>  	return sch_gpio_reg_get(sch, gpio_num, GIO);
>  }
>  
> +static int sch_gpio_to_irq(struct gpio_chip *gpio, unsigned int offset)
> +{
> +	struct sch_gpio *sch = gpiochip_get_data(gpio);
> +	return sch->irq_base + offset;
> +}
> +
>  static const struct gpio_chip sch_gpio_chip = {
>  	.label			= "sch_gpio",
>  	.owner			= THIS_MODULE,
> @@ -138,12 +152,94 @@ static const struct gpio_chip sch_gpio_chip = {
>  	.direction_output	= sch_gpio_direction_out,
>  	.set			= sch_gpio_set,
>  	.get_direction		= sch_gpio_get_direction,
> +	.to_irq			= sch_gpio_to_irq,
>  };
>  
> +static u32 sch_sci_handler(void *context)
> +{
> +	struct sch_gpio *sch = context;
> +	unsigned long core_status, resume_status;
> +	unsigned int resume_gpios, offset;
> +
> +	core_status = inl(sch->iobase + GTS);
> +	resume_status = inl(sch->iobase + GTS + 0x20);
> +
> +	if (core_status == 0 && resume_status == 0)
> +		return ACPI_INTERRUPT_NOT_HANDLED;
> +
> +	for_each_set_bit(offset, &core_status, sch->resume_base)
> +		generic_handle_irq(sch->irq_base + offset);
> +
> +	resume_gpios = sch->chip.ngpio - sch->resume_base;
> +	for_each_set_bit(offset, &resume_status, resume_gpios)
> +		generic_handle_irq(sch->irq_base + sch->resume_base + offset);
> +
> +	outl(core_status, sch->iobase + GTS);
> +	outl(resume_status, sch->iobase + GTS + 0x20);
> +
> +	return ACPI_INTERRUPT_HANDLED;
> +}
> +
> +static int sch_irq_type(struct irq_data *d, unsigned int type)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct sch_gpio *sch = gc->private;
> +	unsigned int gpio_num = d->irq - sch->irq_base;
> +	int rising = 0;
> +	int falling = 0;
> +
> +	switch (type & IRQ_TYPE_SENSE_MASK) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		rising = 1;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		falling = 1;
> +		break;
> +	case IRQ_TYPE_EDGE_BOTH:
> +		rising = 1;
> +		falling = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	spin_lock(&sch->lock);
> +	sch_gpio_reg_set(sch, gpio_num, GTPE, rising);
> +	sch_gpio_reg_set(sch, gpio_num, GTNE, falling);
> +	spin_unlock(&sch->lock);
> +
> +	return 0;
> +}
> +
> +static void sch_irq_set_enable(struct irq_data *d, int val)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct sch_gpio *sch = gc->private;
> +	unsigned int gpio_num = d->irq - sch->irq_base;
> +
> +	spin_lock(&sch->lock);
> +	sch_gpio_reg_set(sch, gpio_num, GGPE, val);
> +	spin_unlock(&sch->lock);
> +}
> +
> +static void sch_irq_mask(struct irq_data *d)
> +{
> +	sch_irq_set_enable(d, 0);
> +}
> +
> +static void sch_irq_unmask(struct irq_data *d)
> +{
> +	sch_irq_set_enable(d, 1);
> +}
> +
>  static int sch_gpio_probe(struct platform_device *pdev)
>  {
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
>  	struct sch_gpio *sch;
>  	struct resource *res;
> +	acpi_status status;
> +	int irq_base, ret;
>  
>  	sch = devm_kzalloc(&pdev->dev, sizeof(*sch), GFP_KERNEL);
>  	if (!sch)
> @@ -203,7 +299,39 @@ static int sch_gpio_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sch);
>  
> -	return devm_gpiochip_add_data(&pdev->dev, &sch->chip, sch);
> +	ret = devm_gpiochip_add_data(&pdev->dev, &sch->chip, sch);
> +	if (ret)
> +		return ret;
> +
> +	irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, sch->chip.ngpio,
> +					NUMA_NO_NODE);
> +	if (irq_base < 0)
> +		return irq_base;
> +	sch->irq_base = irq_base;
> +
> +	gc = devm_irq_alloc_generic_chip(&pdev->dev, "sch_gpio", 1, irq_base,
> +					 NULL, handle_simple_irq);
> +	if (!gc)
> +		return -ENOMEM;
> +
> +	gc->private = sch;
> +	ct = gc->chip_types;
> +
> +	ct->chip.irq_mask = sch_irq_mask;
> +	ct->chip.irq_unmask = sch_irq_unmask;
> +	ct->chip.irq_set_type = sch_irq_type;
> +
> +	ret = devm_irq_setup_generic_chip(&pdev->dev, gc,
> +					  IRQ_MSK(sch->chip.ngpio),
> +					  0, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
> +	if (ret)
> +		return ret;
> +
> +	status = acpi_install_sci_handler(sch_sci_handler, sch);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static struct platform_driver sch_gpio_driver = {
> -- 
> 2.16.4
