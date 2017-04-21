From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] drivers/platform/x86: Add driver for INT0002 ACPI device
Date: Fri, 21 Apr 2017 18:28:52 +0800
Message-ID: <20170421102852.GE7636@linux-l9pv.suse>
References: <20170421074157.19159-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170421074157.19159-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 21, 2017 at 09:41:57AM +0200, Hans de Goede wrote:
> Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
> PMC to wakeup the system. When this happens software needs to clear the
> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
> 
> This is modelled in ACPI through the INT0002 ACPI device.
> 
> This commit adds a driver which will bind to that device, call the
> ACPI event handler for the wakeup and clear the interrupt source
> avoiding the irq storm.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/Kconfig         |  10 ++
>  drivers/platform/x86/Makefile        |   1 +
>  drivers/platform/x86/intel_int0002.c | 232 +++++++++++++++++++++++++++++++++++
>  3 files changed, 243 insertions(+)
>  create mode 100644 drivers/platform/x86/intel_int0002.c
> 
[...snip]
> --- /dev/null
> +++ b/drivers/platform/x86/intel_int0002.c
> @@ -0,0 +1,232 @@
> +/*
> + * Intel INT0002 "Virtual GPIO" driver
> + *
> + * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + * Loosely based on android x86 kernel code which is:
> + *
> + * Copyright (c) 2014, Intel Corporation.
> + *
> + * Author: Dyut Kumar Sil <dyut.k.sil@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
> + * PMC to wakeup the system. When this happens software needs to clear the
> + * PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
> + *
> + * This is modelled in ACPI through the INT0002 ACPI device, which is
> + * called a "Virtual GPIO controller" in ACPI because it defines the event
> + * handler to call when the PME triggers through _AEI and _L02 / _E02
> + * methods as would be done for a real GPIO interrupt.
> + * 
> + * This driver will bind to the INT0002 device, call the ACPI event handler
> + * for the wakeup and clear the interrupt source avoiding the irq storm.
> + */
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +#include <asm/io.h>
> +#include <linux/acpi.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#define GPE0A_PME_STS_BIT               0x2000
> +#define GPE0A_PME_EN_BIT                0x2000

Maybe it's minor. Could you please consider to change the name to
GPE0A_PME_B0_STS_BIT and GPE0A_PME_B0_EN_BIT?

Because it's easy to confuse with the PME_STS/PME_EN bit
(0x800, bit 11) 

Thanks a lot!
Joey Lee
