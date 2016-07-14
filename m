From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
Date: Thu, 14 Jul 2016 16:33:35 -0400
Message-ID: <CAP=VYLp0tfVehQkPquvDHx+GVUYPZw29u7w9HCaHKy+ND5Bj-Q@mail.gmail.com>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org> <1468432402-4872-5-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468432402-4872-5-git-send-email-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, marc.zyngier-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, kva
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 13, 2016 at 1:53 PM,  <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This patch adds support for parsing arch timer in GTDT,
> provides some kernel APIs to parse all the PPIs and
> always-on info in GTDT and export them.
>
> By this driver, we can simplify arm_arch_timer drivers, and
> separate the ACPI GTDT knowledge from it.
>
> Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/acpi/Kconfig           |   5 ++
>  drivers/acpi/Makefile          |   1 +
>  drivers/acpi/arm64/Kconfig     |  15 ++++
>  drivers/acpi/arm64/Makefile    |   1 +
>  drivers/acpi/arm64/acpi_gtdt.c | 170 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h           |   6 ++
>  6 files changed, 198 insertions(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index b7e2e77..1cdc7d2 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -521,4 +521,9 @@ config XPOWER_PMIC_OPREGION
>
>  endif
>
> +if ARM64
> +source "drivers/acpi/arm64/Kconfig"
> +
> +endif
> +
>  endif  # ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 251ce85..1a94ff7 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)     += acpi_extlog.o
>  obj-$(CONFIG_PMIC_OPREGION)    += pmic/intel_pmic.o
>  obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
>  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
> +obj-$(CONFIG_ARM64)    += arm64/
>
>  video-objs                     += acpi_video.o video_detect.o
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> new file mode 100644
> index 0000000..ff5c253
> --- /dev/null
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -0,0 +1,15 @@
> +#
> +# ACPI Configuration for ARM64
> +#
> +
> +menu "The ARM64-specific ACPI Support"
> +
> +config ACPI_GTDT
> +       bool "ACPI GTDT table Support"
> +       help
> +         GTDT (Generic Timer Description Table) provides information
> +         for per-processor timers and Platform (memory-mapped) timers
> +         for ARM platforms. Select this option to provide information
> +         needed for the timers init.
> +
> +endmenu
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> new file mode 100644
> index 0000000..466de6b
> --- /dev/null
> +++ b/drivers/acpi/arm64/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ACPI_GTDT)                += acpi_gtdt.o
> diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
> new file mode 100644
> index 0000000..9ee977d
> --- /dev/null
> +++ b/drivers/acpi/arm64/acpi_gtdt.c
> @@ -0,0 +1,170 @@
> +/*
> + * ARM Specific GTDT table Support
> + *
> + * Copyright (C) 2016, Linaro Ltd.
> + * Author: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *         Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *         Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Please do not use module.h in drivers that are using a
bool Kconfig setting.

Thanks,
Paul.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
