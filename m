From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] platform/x86: Add driver for INT0002 ACPI device
Date: Tue, 23 May 2017 22:12:23 +0200
Message-ID: <260cfaad-0037-94b3-ad77-328a88495dca@redhat.com>
References: <20170421125246.3982-1-hdegoede@redhat.com>
 <CAHp75Vf28pXs81pThrjVtpqDfsosTsGQSnX0V1WHth=9OJ9u7g@mail.gmail.com>
 <20170424104255.GV7152@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170424104255.GV7152@lahna.fi.intel.com>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, joeyli <jlee@suse.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 04/24/2017 12:42 PM, Mika Westerberg wrote:
> On Mon, Apr 24, 2017 at 12:40:30PM +0300, Andy Shevchenko wrote:
>> +Cc: Mika (that's why left all content + one my comment below)
>>
>> On Fri, Apr 21, 2017 at 3:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
>>> PMC to wakeup the system. When this happens software needs to clear the
>>> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
>>>
>>> This is modelled in ACPI through the INT0002 ACPI device.
>>>
>>> This commit adds a driver which will bind to that device, call the
>>> ACPI event handler for the wakeup and clear the interrupt source
>>> avoiding the irq storm.
>>>
>>> Cc: joeyli <jlee@suse.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Tested-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>> Changes in v2:
>>> -Remove dev_err after malloc failure
>>> -Remove unused empty runtime pm callbacks
>>> -s/GPE0A_PME_/GPE0A_PME_B0_/
>>> -Fixed some checkpatch warnings (I forgot to run checkpatch on v1)
>>> ---
>>>   drivers/platform/x86/Kconfig         |  10 ++
>>>   drivers/platform/x86/Makefile        |   1 +
>>>   drivers/platform/x86/intel_int0002.c | 214 +++++++++++++++++++++++++++++++++++
>>>   3 files changed, 225 insertions(+)
>>>   create mode 100644 drivers/platform/x86/intel_int0002.c
>>>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>> index 53afa78..be2ffbd 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -889,6 +889,16 @@ config INTEL_PMC_CORE
>>>            Supported features:
>>>                  - SLP_S0_RESIDENCY counter.
>>>
>>> +config INTEL_INT0002
>>> +       tristate "Intel INT0002 Virtual GPIO ACPI device driver"
>>> +       depends on X86 && ACPI
>>> +       ---help---
>>> +         Some peripherals on Baytrail and Cherrytrail platforms signal
>>> +         PME to the PMC to wakeup the system. When this happens software
>>> +         needs to explicitly clear the interrupt source to avoid an IRQ
>>> +         storm on IRQ 9. This is modelled in ACPI through the INT0002
>>> +         ACPI device. This driver implements the clearing of the IRQ.
>>> +
>>>   config IBM_RTL
>>>          tristate "Device driver to enable PRTL support"
>>>          depends on PCI
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>>> index 6731893..de4ffb5 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -51,6 +51,7 @@ obj-$(CONFIG_INTEL_SCU_IPC)   += intel_scu_ipc.o
>>>   obj-$(CONFIG_INTEL_SCU_IPC_UTIL) += intel_scu_ipcutil.o
>>>   obj-$(CONFIG_INTEL_MFLD_THERMAL) += intel_mid_thermal.o
>>>   obj-$(CONFIG_INTEL_IPS)                += intel_ips.o
>>> +obj-$(CONFIG_INTEL_INT0002)    += intel_int0002.o
>>>   obj-$(CONFIG_XO1_RFKILL)       += xo1-rfkill.o
>>>   obj-$(CONFIG_XO15_EBOOK)       += xo15-ebook.o
>>>   obj-$(CONFIG_IBM_RTL)          += ibm_rtl.o
>>> diff --git a/drivers/platform/x86/intel_int0002.c b/drivers/platform/x86/intel_int0002.c
>>> new file mode 100644
>>> index 0000000..52aab58
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/intel_int0002.c
>>> @@ -0,0 +1,214 @@
>>> +/*
>>> + * Intel INT0002 "Virtual GPIO" driver
>>> + *
>>> + * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
>>> + *
>>> + * Loosely based on android x86 kernel code which is:
>>> + *
>>> + * Copyright (c) 2014, Intel Corporation.
>>> + *
>>> + * Author: Dyut Kumar Sil <dyut.k.sil@intel.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
>>> + * PMC to wakeup the system. When this happens software needs to clear the
>>> + * PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
>>> + *
>>> + * This is modelled in ACPI through the INT0002 ACPI device, which is
>>> + * called a "Virtual GPIO controller" in ACPI because it defines the event
>>> + * handler to call when the PME triggers through _AEI and _L02 / _E02
>>> + * methods as would be done for a real GPIO interrupt.
>>> + *
>>> + * This driver will bind to the INT0002 device, call the ACPI event handler
>>> + * for the wakeup and clear the interrupt source avoiding the irq storm.
>>> + */
>>> +
>>> +#include <asm/cpu_device_id.h>
>>> +#include <asm/intel-family.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#define GPE0A_PME_B0_STS_BIT           0x2000
>>> +#define GPE0A_PME_B0_EN_BIT            0x2000
>>> +#define GPE0A_STS_PORT                 0x420
>>> +#define GPE0A_EN_PORT                  0x428
>>> +
>>> +#define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
>>> +
>>> +static const struct x86_cpu_id int0002_cpu_ids[] = {
>>> +/*
>>> + * Limit ourselves to Cherry Trail for now, until testing shows we
>>> + * need to handle the INT0002 device on Baytrail too.
>>> + *     ICPU(INTEL_FAM6_ATOM_SILVERMONT1),       * Valleyview, Bay Trail *
>>> + */
>>> +       ICPU(INTEL_FAM6_ATOM_AIRMONT),          /* Braswell, Cherry Trail */
>>> +       {}
>>> +};
>>> +
>>> +struct int0002_data {
>>> +       spinlock_t lock;
>>> +       struct device *dev;
>>> +       const struct x86_cpu_id *cpu_id;
>>> +       acpi_handle handle;
>>> +       char ev_name[5];
>>> +};
>>> +
>>> +static void int0002_irq_enable(struct int0002_data *data, bool enable)
>>> +{
>>> +       unsigned long flags;
>>> +       u32 gpe_en_reg;
>>> +
>>> +       spin_lock_irqsave(&data->lock, flags);
>>> +
>>> +       gpe_en_reg = inl(GPE0A_EN_PORT);
>>> +       if (enable)
>>> +               gpe_en_reg |= GPE0A_PME_B0_EN_BIT;
>>> +       else
>>> +               gpe_en_reg &= ~GPE0A_PME_B0_EN_BIT;
>>> +       outl(gpe_en_reg, GPE0A_EN_PORT);
>>> +
>>> +       spin_unlock_irqrestore(&data->lock, flags);
>>> +}
>>> +
>>> +static irqreturn_t int0002_irq_handler(int irq, void *handler_data)
>>> +{
>>> +       struct int0002_data *data = handler_data;
>>> +       u32 gpe_sts_reg;
>>> +
>>> +       gpe_sts_reg = inl(GPE0A_STS_PORT);
>>> +       if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
>>> +               return IRQ_NONE;
>>> +
>>> +       int0002_irq_enable(data, false);
>>> +
>>> +       return IRQ_WAKE_THREAD;
>>> +}
>>> +
>>> +static irqreturn_t int0002_irq_thread(int irq, void *handler_data)
>>> +{
>>> +       struct int0002_data *data = handler_data;
>>> +       acpi_status status;
>>> +
>>> +       /* Don't call ACPI event handler on Baytrail? Taken from Android-x86 */
>>> +       if (data->cpu_id->model != INTEL_FAM6_ATOM_SILVERMONT1) {
>>> +               status = acpi_evaluate_object(data->handle, data->ev_name,
>>> +                                             NULL, NULL);
>>> +               if (ACPI_FAILURE(status))
>>> +                       dev_err(data->dev, "Error calling %s\n", data->ev_name);
>>> +       }
>>> +
>>> +       /* Ack and then re-enable IRQ */
>>> +       outl(GPE0A_PME_B0_STS_BIT, GPE0A_STS_PORT);
>>> +       int0002_irq_enable(data, true);
>>> +
>>> +       return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int int0002_probe(struct platform_device *pdev)
>>> +{
>>> +       struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>>> +       struct device *dev = &pdev->dev;
>>> +       struct int0002_data *data;
>>> +       struct acpi_resource *res;
>>> +       acpi_status status;
>>> +       acpi_handle hdl;
>>> +       int irq, ret;
>>> +
>>> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>> +       if (!data)
>>> +               return -ENOMEM;
>>> +
>>> +       spin_lock_init(&data->lock);
>>> +       data->dev = dev;
>>> +
>>> +       /* Menlow has a different INT0002 device? <sigh> */
>>> +       data->cpu_id = x86_match_cpu(int0002_cpu_ids);
>>> +       if (!data->cpu_id)
>>> +               return -ENODEV;
>>> +
>>> +       data->handle = ACPI_HANDLE(dev);
>>> +       if (!data->handle)
>>> +               return -ENODEV;
>>> +
>>> +       irq = platform_get_irq(pdev, 0);
>>> +       if (irq < 0) {
>>> +               dev_err(dev, "Error getting IRQ: %d\n", irq);
>>> +               return irq;
>>> +       }
>>> +
>>> +       status = acpi_get_event_resources(data->handle, &buf);
>>> +       if (ACPI_FAILURE(status)) {
>>> +               dev_err(dev, "Error getting acpi event resources\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       /* Find the "GPIO interrupt" event handler to call upon PME */
>>> +       ret = -ENODEV;
>>> +       for (res = buf.pointer;
>>> +            res && (res->type != ACPI_RESOURCE_TYPE_END_TAG);
>>> +            res = ACPI_NEXT_RESOURCE(res)) {
>>> +
>>> +               if (res->type != ACPI_RESOURCE_TYPE_GPIO ||
>>> +                   res->data.gpio.connection_type !=
>>> +                   ACPI_RESOURCE_GPIO_TYPE_INT)
>>> +                       continue;
>>> +
>>
>>> +               snprintf(data->ev_name, sizeof(data->ev_name), "_%c%02X",
>>> +                       res->data.gpio.triggering ? 'E' : 'L',
>>> +                       res->data.gpio.pin_table[0]);
>>> +
>>> +               status = acpi_get_handle(data->handle, data->ev_name, &hdl);
>>> +               if (ACPI_SUCCESS(status)) {
>>> +                       ret = 0;
>>> +                       break;
>>> +               }
>>
>> I still think it might make sense to split it to some generic helper
>> (same code is used in gpiolib-acpi.c).
> 
> I agree and further if this device has _AEI I would investigate how you
> could get acpi_gpiochip_request_interrupts() to cope with it.

Thank you for the review / the remarks.

I'm about to post a new version as a result of these remarks I've converted
the driver into a (virtual) gpiochip driver to match how things are modelled
in the DSDT, this removes the need for any direct interaction with the ACPI
subsys, letting gpiolib-acpi take care of everything.

Regards,

Hans
