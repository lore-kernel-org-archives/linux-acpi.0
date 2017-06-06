From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation region driver
Date: Tue, 6 Jun 2017 17:23:56 +0300
Message-ID: <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com> <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35809 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdFFOYD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2017 10:24:03 -0400
In-Reply-To: <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

+Cc Hans (that's why didn't delete anything from original mail, just
adding my comments).

Hans, if you have few minutes it would be appreciated to glance on the
below for some issues if any since you did pass quite a good quest
with other PMIC drivers.

On Tue, Jun 6, 2017 at 2:55 PM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:
> The Kabylake platform coreboot (Chrome OS equivalent of
> BIOS) has defined 4 operation regions for the TI TPS68470 PMIC.
> These operation regions are to enable/disable voltage
> regulators, configure voltage regulators, enable/disable
> clocks and to configure clocks.
>
> This config adds ACPI operation region support for TI TPS68470 PMIC.
> TPS68470 device is an advanced power management unit that powers
> a Compact Camera Module (CCM), generates clocks for image sensors,
> drives a dual LED for flash and incorporates two LED drivers for
> general purpose indicators.
> This driver enables ACPI operation region support to control voltage
> regulators and clocks for the TPS68470 PMIC.
>
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> ---
>  drivers/acpi/Kconfig              |  12 +
>  drivers/acpi/Makefile             |   2 +

>  drivers/acpi/pmic/pmic_tps68470.c | 454 ++++++++++++++++++++++++++++++++++++++

Follow the pattern, please, I suppose
ti_pmic_tps68470.c

>  3 files changed, 468 insertions(+)
>  create mode 100644 drivers/acpi/pmic/pmic_tps68470.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1ce52f8..218d22d 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -535,4 +535,16 @@ if ARM64
>  source "drivers/acpi/arm64/Kconfig"
>  endif
>
> +config TPS68470_PMIC_OPREGION
> +       bool "ACPI operation region support for TPS68470 PMIC"
> +       help
> +         This config adds ACPI operation region support for TI TPS68470 PMIC.
> +         TPS68470 device is an advanced power management unit that powers
> +         a Compact Camera Module (CCM), generates clocks for image sensors,
> +         drives a dual LED for flash and incorporates two LED drivers for
> +         general purpose indicators.
> +         This driver enables ACPI operation region support control voltage
> +         regulators and clocks.
> +

> +

Extra line, remove.

>  endif  # ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index b1aacfc..7113d05 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -106,6 +106,8 @@ obj-$(CONFIG_CHT_WC_PMIC_OPREGION) += pmic/intel_pmic_chtwc.o
>
>  obj-$(CONFIG_ACPI_CONFIGFS)    += acpi_configfs.o
>
> +obj-$(CONFIG_TPS68470_PMIC_OPREGION)   += pmic/pmic_tps68470.o
> +
>  video-objs                     += acpi_video.o video_detect.o
>  obj-y                          += dptf/
>
> diff --git a/drivers/acpi/pmic/pmic_tps68470.c b/drivers/acpi/pmic/pmic_tps68470.c
> new file mode 100644
> index 0000000..b2d608b
> --- /dev/null
> +++ b/drivers/acpi/pmic/pmic_tps68470.c
> @@ -0,0 +1,454 @@
> +/*
> + * TI TPS68470 PMIC operation region driver
> + *
> + * Copyright (C) 2017 Intel Corporation. All rights reserved.
> + * Author: Rajmohan Mani <rajmohan.mani@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Based on drivers/acpi/pmic/intel_pmic* drivers
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/mfd/tps68470.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +struct ti_pmic_table {
> +       u32 address;            /* operation region address */
> +       u32 reg;                /* corresponding register */
> +       u32 bitmask;            /* bit mask for power, clock */
> +};
> +
> +#define TI_PMIC_POWER_OPREGION_ID              0xB0
> +#define TI_PMIC_VR_VAL_OPREGION_ID             0xB1
> +#define TI_PMIC_CLOCK_OPREGION_ID              0xB2
> +#define TI_PMIC_CLKFREQ_OPREGION_ID            0xB3
> +
> +struct ti_pmic_opregion {
> +       struct mutex lock;
> +       struct regmap *regmap;
> +};
> +
> +#define S_IO_I2C_EN    (BIT(0) | BIT(1))
> +
> +static const struct ti_pmic_table power_table[] = {
> +       {
> +               .address = 0x00,
> +               .reg = TPS68470_REG_S_I2C_CTL,
> +               .bitmask = S_IO_I2C_EN,
> +               /* S_I2C_CTL */
> +       },
> +       {
> +               .address = 0x04,
> +               .reg = TPS68470_REG_VCMCTL,
> +               .bitmask = BIT(0),
> +               /* VCMCTL */
> +       },
> +       {
> +               .address = 0x08,
> +               .reg = TPS68470_REG_VAUX1CTL,
> +               .bitmask = BIT(0),
> +               /* VAUX1_CTL */
> +       },
> +       {
> +               .address = 0x0C,
> +               .reg = TPS68470_REG_VAUX2CTL,
> +               .bitmask = BIT(0),
> +               /* VAUX2CTL */
> +       },
> +       {
> +               .address = 0x10,
> +               .reg = TPS68470_REG_VACTL,
> +               .bitmask = BIT(0),
> +               /* VACTL */
> +       },
> +       {
> +               .address = 0x14,
> +               .reg = TPS68470_REG_VDCTL,
> +               .bitmask = BIT(0),
> +               /* VDCTL */
> +       },
> +};
> +
> +/* Table to set voltage regulator value */
> +static const struct ti_pmic_table vr_val_table[] = {
> +       {
> +               .address = 0x00,
> +               .reg = TPS68470_REG_VSIOVAL,
> +               .bitmask = TPS68470_VSIOVAL_IOVOLT_MASK,
> +               /* TPS68470_REG_VSIOVAL */
> +       },
> +       {
> +               .address = 0x04,
> +               .reg = TPS68470_REG_VIOVAL,
> +               .bitmask = TPS68470_VIOVAL_IOVOLT_MASK,
> +               /* TPS68470_REG_VIOVAL */
> +       },
> +       {
> +               .address = 0x08,
> +               .reg = TPS68470_REG_VCMVAL,
> +               .bitmask = TPS68470_VCMVAL_VCVOLT_MASK,
> +               /* TPS68470_REG_VCMVAL */
> +       },
> +       {
> +               .address = 0x0C,
> +               .reg = TPS68470_REG_VAUX1VAL,
> +               .bitmask = TPS68470_VAUX1VAL_AUX1VOLT_MASK,
> +               /* TPS68470_REG_VAUX1VAL */
> +       },
> +       {
> +               .address = 0x10,
> +               .reg = TPS68470_REG_VAUX2VAL,
> +               .bitmask = TPS68470_VAUX2VAL_AUX2VOLT_MASK,
> +               /* TPS68470_REG_VAUX2VAL */
> +       },
> +       {
> +               .address = 0x14,
> +               .reg = TPS68470_REG_VAVAL,
> +               .bitmask = TPS68470_VAVAL_AVOLT_MASK,
> +               /* TPS68470_REG_VAVAL */
> +       },
> +       {
> +               .address = 0x18,
> +               .reg = TPS68470_REG_VDVAL,
> +               .bitmask = TPS68470_VDVAL_DVOLT_MASK,
> +               /* TPS68470_REG_VDVAL */
> +       },
> +};
> +
> +/* Table to configure clock frequency */
> +static const struct ti_pmic_table clk_freq_table[] = {
> +       {
> +               .address = 0x00,
> +               .reg = TPS68470_REG_POSTDIV2,
> +               .bitmask = BIT(0) | BIT(1),
> +               /* TPS68470_REG_POSTDIV2 */
> +       },
> +       {
> +               .address = 0x04,
> +               .reg = TPS68470_REG_BOOSTDIV,
> +               .bitmask = 0x1F,
> +               /* TPS68470_REG_BOOSTDIV */
> +       },
> +       {
> +               .address = 0x08,
> +               .reg = TPS68470_REG_BUCKDIV,
> +               .bitmask = 0x0F,
> +               /* TPS68470_REG_BUCKDIV */
> +       },
> +       {
> +               .address = 0x0C,
> +               .reg = TPS68470_REG_PLLSWR,
> +               .bitmask = 0x13,
> +               /* TPS68470_REG_PLLSWR */
> +       },
> +       {
> +               .address = 0x10,
> +               .reg = TPS68470_REG_XTALDIV,
> +               .bitmask = 0xFF,
> +               /* TPS68470_REG_XTALDIV */
> +       },
> +       {
> +               .address = 0x14,
> +               .reg = TPS68470_REG_PLLDIV,
> +               .bitmask = 0xFF,
> +               /* TPS68470_REG_PLLDIV */
> +       },
> +       {
> +               .address = 0x18,
> +               .reg = TPS68470_REG_POSTDIV,
> +               .bitmask = 0x83,
> +               /* TPS68470_REG_POSTDIV */
> +       },
> +};
> +
> +/* Table to configure and enable clocks */
> +static const struct ti_pmic_table clk_table[] = {
> +       {
> +               .address = 0x00,
> +               .reg = TPS68470_REG_PLLCTL,
> +               .bitmask = 0xF5,
> +               /* TPS68470_REG_PLLCTL */
> +       },
> +       {
> +               .address = 0x04,
> +               .reg = TPS68470_REG_PLLCTL2,
> +               .bitmask = BIT(0),
> +               /* TPS68470_REG_PLLCTL2 */
> +       },
> +       {
> +               .address = 0x08,
> +               .reg = TPS68470_REG_CLKCFG1,
> +               .bitmask = TPS68470_CLKCFG1_MODE_A_MASK |
> +                       TPS68470_CLKCFG1_MODE_B_MASK,
> +               /* TPS68470_REG_CLKCFG1 */
> +       },
> +       {
> +               .address = 0x0C,
> +               .reg = TPS68470_REG_CLKCFG2,
> +               .bitmask = TPS68470_CLKCFG1_MODE_A_MASK |
> +                       TPS68470_CLKCFG1_MODE_B_MASK,
> +               /* TPS68470_REG_CLKCFG2 */
> +       },
> +};
> +
> +static int pmic_get_reg_bit(u64 address, struct ti_pmic_table *table,
> +                           int count, int *reg, int *bitmask)
> +{
> +       u64 i;
> +

> +       i = address / 4;


> +

Remove this line.

> +       if (i >= count)
> +               return -ENOENT;
> +
> +       if (!reg || !bitmask)
> +               return -EINVAL;
> +
> +       *reg = table[i].reg;
> +       *bitmask = table[i].bitmask;
> +
> +       return 0;
> +}
> +
> +static int ti_tps68470_pmic_get_power(struct regmap *regmap, int reg,
> +                                      int bitmask, u64 *value)
> +{
> +       int data;
> +
> +       if (regmap_read(regmap, reg, &data))
> +               return -EIO;
> +
> +       *value = (data & bitmask) ? 1 : 0;
> +       return 0;
> +}
> +
> +static int ti_tps68470_pmic_get_vr_val(struct regmap *regmap, int reg,
> +                                      int bitmask, u64 *value)
> +{
> +       int data;
> +
> +       if (regmap_read(regmap, reg, &data))
> +               return -EIO;
> +
> +       *value = data & bitmask;
> +       return 0;
> +}
> +
> +static int ti_tps68470_pmic_get_clk(struct regmap *regmap, int reg,
> +                                      int bitmask, u64 *value)
> +{
> +       int data;
> +
> +       if (regmap_read(regmap, reg, &data))
> +               return -EIO;
> +
> +       *value = (data & bitmask) ? 1 : 0;
> +       return 0;
> +}
> +
> +static int ti_tps68470_pmic_get_clk_freq(struct regmap *regmap, int reg,
> +                                      int bitmask, u64 *value)
> +{
> +       int data;
> +
> +       if (regmap_read(regmap, reg, &data))
> +               return -EIO;
> +
> +       *value = data & bitmask;
> +       return 0;
> +}
> +
> +static int ti_tps68470_regmap_update_bits(struct regmap *regmap, int reg,
> +                                       int bitmask, u64 value)
> +{
> +       return regmap_update_bits(regmap, reg, bitmask, value);
> +}
> +
> +static acpi_status ti_pmic_common_handler(u32 function,
> +                                         acpi_physical_address address,
> +                                         u32 bits, u64 *value,
> +                                         void *handler_context,
> +                                         void *region_context,
> +                                         int (*get)(struct regmap *,
> +                                                    int, int, u64 *),
> +                                         int (*update)(struct regmap *,
> +                                                       int, int, u64),
> +                                         struct ti_pmic_table *table,
> +                                         int table_size)
> +{
> +       struct ti_pmic_opregion *opregion = region_context;
> +       struct regmap *regmap = opregion->regmap;
> +       int reg, ret, bitmask;
> +
> +       if (bits != 32)
> +               return AE_BAD_PARAMETER;
> +
> +       ret = pmic_get_reg_bit(address, table,
> +                                 table_size, &reg, &bitmask);
> +       if (ret < 0)
> +               return AE_BAD_PARAMETER;
> +
> +       if (function == ACPI_WRITE && (*value > bitmask))
> +               return AE_BAD_PARAMETER;
> +
> +       mutex_lock(&opregion->lock);
> +
> +       ret = (function == ACPI_READ) ?
> +               get(regmap, reg, bitmask, value) :
> +               update(regmap, reg, bitmask, *value);
> +
> +       mutex_unlock(&opregion->lock);
> +
> +       return ret ? AE_ERROR : AE_OK;
> +}
> +
> +static acpi_status ti_pmic_clk_freq_handler(u32 function,
> +                                           acpi_physical_address address,
> +                                           u32 bits, u64 *value,
> +                                           void *handler_context,
> +                                           void *region_context)
> +{
> +       return ti_pmic_common_handler(function, address, bits, value,
> +                               handler_context, region_context,
> +                               ti_tps68470_pmic_get_clk_freq,
> +                               ti_tps68470_regmap_update_bits,
> +                               (struct ti_pmic_table *) &clk_freq_table,
> +                               ARRAY_SIZE(clk_freq_table));
> +}
> +
> +static acpi_status ti_pmic_clk_handler(u32 function,
> +                                      acpi_physical_address address, u32 bits,
> +                                      u64 *value, void *handler_context,
> +                                      void *region_context)
> +{
> +       return ti_pmic_common_handler(function, address, bits, value,
> +                               handler_context, region_context,
> +                               ti_tps68470_pmic_get_clk,
> +                               ti_tps68470_regmap_update_bits,
> +                               (struct ti_pmic_table *) &clk_table,
> +                                ARRAY_SIZE(clk_table));
> +}
> +
> +static acpi_status ti_pmic_vr_val_handler(u32 function,
> +                                         acpi_physical_address address,
> +                                         u32 bits, u64 *value,
> +                                         void *handler_context,
> +                                         void *region_context)
> +{
> +       return ti_pmic_common_handler(function, address, bits, value,
> +                               handler_context, region_context,
> +                               ti_tps68470_pmic_get_vr_val,
> +                               ti_tps68470_regmap_update_bits,
> +                               (struct ti_pmic_table *) &vr_val_table,
> +                               ARRAY_SIZE(vr_val_table));
> +}
> +
> +static acpi_status ti_pmic_power_handler(u32 function,
> +                                        acpi_physical_address address,
> +                                        u32 bits, u64 *value,
> +                                        void *handler_context,
> +                                        void *region_context)
> +{
> +       if (bits != 32)
> +               return AE_BAD_PARAMETER;
> +
> +       /* set/clear for bit 0, bits 0 and 1 together */
> +       if (function == ACPI_WRITE &&
> +           !(*value == 0 || *value == 1 || *value == 3)) {
> +               return AE_BAD_PARAMETER;
> +       }
> +
> +       return ti_pmic_common_handler(function, address, bits, value,
> +                               handler_context, region_context,
> +                               ti_tps68470_pmic_get_power,
> +                               ti_tps68470_regmap_update_bits,
> +                               (struct ti_pmic_table *) &power_table,
> +                               ARRAY_SIZE(power_table));
> +}
> +
> +static int ti_tps68470_pmic_opregion_probe(struct platform_device *pdev)
> +{
> +       struct tps68470 *pmic = dev_get_drvdata(pdev->dev.parent);
> +       acpi_handle handle = ACPI_HANDLE(pdev->dev.parent);
> +       struct device *dev = &pdev->dev;
> +       struct ti_pmic_opregion *opregion;
> +       acpi_status status;
> +

> +       if (!dev || !pmic->regmap) {
> +               WARN(1, "dev or regmap is NULL\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!handle) {
> +               WARN(1, "acpi handle is NULL\n");
> +               return -ENODEV;
> +       }

I dunno if WARNs make user experience any better.
Besides that I would double check you may have such cases.

> +
> +       opregion = devm_kzalloc(dev, sizeof(*opregion), GFP_KERNEL);
> +       if (!opregion)
> +               return -ENOMEM;
> +
> +       mutex_init(&opregion->lock);
> +       opregion->regmap = pmic->regmap;
> +
> +       status = acpi_install_address_space_handler(handle,
> +                                                   TI_PMIC_POWER_OPREGION_ID,
> +                                                   ti_pmic_power_handler,
> +                                                   NULL, opregion);
> +       if (ACPI_FAILURE(status))
> +               return -ENODEV;
> +
> +       status = acpi_install_address_space_handler(handle,
> +                                                   TI_PMIC_VR_VAL_OPREGION_ID,
> +                                                   ti_pmic_vr_val_handler,
> +                                                   NULL, opregion);
> +       if (ACPI_FAILURE(status))
> +               goto out_remove_power_handler;
> +
> +       status = acpi_install_address_space_handler(handle,
> +                                                   TI_PMIC_CLOCK_OPREGION_ID,
> +                                                   ti_pmic_clk_handler,
> +                                                   NULL, opregion);
> +       if (ACPI_FAILURE(status))
> +               goto out_remove_vr_val_handler;
> +
> +       status = acpi_install_address_space_handler(handle,
> +                                                   TI_PMIC_CLKFREQ_OPREGION_ID,
> +                                                   ti_pmic_clk_freq_handler,
> +                                                   NULL, opregion);
> +       if (ACPI_FAILURE(status))
> +               goto out_remove_clk_handler;
> +
> +       return 0;
> +
> +out_remove_clk_handler:
> +       acpi_remove_address_space_handler(handle, TI_PMIC_CLOCK_OPREGION_ID,
> +                                         ti_pmic_clk_handler);
> +out_remove_vr_val_handler:
> +       acpi_remove_address_space_handler(handle, TI_PMIC_VR_VAL_OPREGION_ID,
> +                                         ti_pmic_vr_val_handler);
> +out_remove_power_handler:
> +       acpi_remove_address_space_handler(handle, TI_PMIC_POWER_OPREGION_ID,
> +                                         ti_pmic_power_handler);
> +       return -ENODEV;
> +}
> +
> +static struct platform_driver ti_tps68470_pmic_opregion_driver = {
> +       .probe = ti_tps68470_pmic_opregion_probe,
> +       .driver = {
> +               .name = "tps68470_pmic_opregion",
> +       },
> +};
> +
> +builtin_platform_driver(ti_tps68470_pmic_opregion_driver)
> --
> 1.9.1
>

-- 
With Best Regards,
Andy Shevchenko
