From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: Add support for Dollar Cove TI power button
Date: Thu, 24 Aug 2017 12:20:04 +0300
Message-ID: <CAHp75Vfsn+7ZZCdis_iOHk36TnZp-354ncetE=R+h7piBMx9Qg@mail.gmail.com>
References: <20170824081141.5018-1-tiwai@suse.de> <20170824081141.5018-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824081141.5018-3-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 24, 2017 at 11:11 AM, Takashi Iwai <tiwai@suse.de> wrote:
> This provides a new input driver for supporting the power button on
> Dollar Cove TI PMIC, found on Cherrytrail-based devices.
> The patch is based on the original work by Intel, found at:
>   https://github.com/01org/ProductionKernelQuilts
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Are you going to submit it via MFD?

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
> v1->v2:
> * Move power-button driver to platform/x86, driver renames accordingly
> * Add missing wake-irq cleanup to power-button driver
>
>  drivers/platform/x86/Kconfig              |  8 +++
>  drivers/platform/x86/Makefile             |  1 +
>  drivers/platform/x86/intel_dc_ti_pwrbtn.c | 96 +++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/platform/x86/intel_dc_ti_pwrbtn.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 80b87954f6dd..25ab9f6ba533 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1139,6 +1139,14 @@ config SILEAD_DMI
>           with the OS-image for the device. This option supplies the missing
>           information. Enable this for x86 tablets with Silead touchscreens.
>
> +config INTEL_DC_TI_PWRBTN
> +       tristate "Dollar Cove TI power button driver"
> +       depends on INTEL_SOC_PMIC_DC_TI
> +       depends on INPUT
> +       help
> +         Say Y here fi you want to have a power button driver for
> +         Dollar Cove TI PMIC.
> +
>  endif # X86_PLATFORM_DEVICES
>
>  config PMC_ATOM
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 91cec1751461..1ce5c18d249e 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -83,3 +83,4 @@ obj-$(CONFIG_PMC_ATOM)                += pmc_atom.o
>  obj-$(CONFIG_MLX_PLATFORM)     += mlx-platform.o
>  obj-$(CONFIG_MLX_CPLD_PLATFORM)        += mlxcpld-hotplug.o
>  obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
> +obj-$(CONFIG_INTEL_DC_TI_PWRBTN)       += intel_dc_ti_pwrbtn.o
> diff --git a/drivers/platform/x86/intel_dc_ti_pwrbtn.c b/drivers/platform/x86/intel_dc_ti_pwrbtn.c
> new file mode 100644
> index 000000000000..1a40f55699fb
> --- /dev/null
> +++ b/drivers/platform/x86/intel_dc_ti_pwrbtn.c
> @@ -0,0 +1,96 @@
> +/*
> + * Power-button driver for Dollar Cove TI PMIC
> + * Copyright (C) 2014 Intel Corp
> + * Copyright (c) 2017 Takashi Iwai <tiwai@suse.de>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/slab.h>
> +
> +#define DC_TI_SIRQ_REG         0x3
> +#define SIRQ_PWRBTN_REL                (1 << 0)
> +
> +static irqreturn_t dc_ti_pwrbtn_interrupt(int irq, void *dev_id)
> +{
> +       struct input_dev *input = dev_id;
> +       struct device *dev = input->dev.parent;
> +       struct regmap *regmap = dev_get_drvdata(dev);
> +       int state;
> +
> +       if (!regmap_read(regmap, DC_TI_SIRQ_REG, &state)) {
> +               dev_dbg(dev, "SIRQ_REG=0x%x\n", state);
> +               state &= SIRQ_PWRBTN_REL;
> +               input_event(input, EV_KEY, KEY_POWER, !state);
> +               input_sync(input);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int dc_ti_pwrbtn_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
> +       struct input_dev *input;
> +       int irq;
> +       int ret;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return -EINVAL;
> +       input = devm_input_allocate_device(dev);
> +       if (!input)
> +               return -ENOMEM;
> +       input->name = pdev->name;
> +       input->phys = "power-button/input0";
> +       input->id.bustype = BUS_HOST;
> +       input->dev.parent = dev;
> +       input_set_capability(input, EV_KEY, KEY_POWER);
> +       ret = input_register_device(input);
> +       if (ret)
> +               return ret;
> +
> +       dev_set_drvdata(dev, pmic->regmap);
> +
> +       ret = devm_request_threaded_irq(dev, irq, NULL, dc_ti_pwrbtn_interrupt,
> +                                       0, KBUILD_MODNAME, input);
> +       if (ret)
> +               return ret;
> +
> +       device_init_wakeup(dev, true);
> +       dev_pm_set_wake_irq(dev, irq);
> +       return 0;
> +}
> +
> +static int dc_ti_pwrbtn_remove(struct platform_device *pdev)
> +{
> +       dev_pm_clear_wake_irq(&pdev->dev);
> +       device_init_wakeup(&pdev->dev, false);
> +       return 0;
> +}
> +
> +static struct platform_device_id dc_ti_pwrbtn_id_table[] = {
> +       { .name = "dc_ti_pwrbtn" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(platform, dc_ti_pwrbtn_id_table);
> +
> +static struct platform_driver dc_ti_pwrbtn_driver = {
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +       },
> +       .probe  = dc_ti_pwrbtn_probe,
> +       .remove = dc_ti_pwrbtn_remove,
> +       .id_table = dc_ti_pwrbtn_id_table,
> +};
> +module_platform_driver(dc_ti_pwrbtn_driver);
> +
> +MODULE_DESCRIPTION("Power-button driver for Dollar Cove TI PMIC");
> +MODULE_LICENSE("GPL v2");
> --
> 2.14.0
>



-- 
With Best Regards,
Andy Shevchenko
