From: "Muller, Francois-nicolas" <francois-nicolas.muller-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] TCO Watchdog warning interrupt driver creation
Date: Mon, 22 Dec 2014 13:18:33 +0000
Message-ID: <B9C02DB17496AC4197F41A146D371B9B075C5FE3@hasmsx107.ger.corp.intel.com>
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com>
 <20141211040404.GA28797@vmdeb7> <5489AA6B.9080802@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5489AA6B.9080802-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "'platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux ACPI Mailing List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks Darren and Guenter for your review.
Here is a new patchset, including the feature in the watchdog driver an=
d using a boot parameter to be enabled.
=46ran=E7ois-Nicolas

Subject: [PATCH] TCO watchdog warning interrupt handler

Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel.c=
om>
---
 drivers/watchdog/iTCO_wdt.c |   66 +++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index e802a54..1ce9ad8 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -49,6 +49,8 @@
 /* Module and version information */
 #define DRV_NAME	"iTCO_wdt"
 #define DRV_VERSION	"1.11"
+#define DRV_NAME_ACPI	"iTCO_wdt_wirq"
+#define TCO_CLASS	DRV_NAME
=20
 /* Includes */
 #include <linux/module.h>		/* For module specific items */
@@ -68,6 +70,9 @@
 #include <linux/pm.h>			/* For suspend/resume */
 #include <linux/mfd/core.h>
 #include <linux/mfd/lpc_ich.h>
+#include <linux/nmi.h>
+#include <linux/acpi.h>
+#include <acpi/actypes.h>
=20
 #include "iTCO_vendor.h"
=20
@@ -107,6 +112,12 @@ static struct {		/* this is private data for the i=
TCO_wdt device */
 	bool started;
 } iTCO_wdt_private;
=20
+static const struct acpi_device_id iTCO_wdt_ids[] =3D {
+	{"8086229C", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, iTCO_wdt_ids);
+
 /* module parameters */
 #define WATCHDOG_TIMEOUT 30	/* 30 sec default heartbeat */
 static int heartbeat =3D WATCHDOG_TIMEOUT;  /* in seconds */
@@ -126,6 +137,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
 MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
 	"Turn off SMI clearing watchdog (depends on TCO-version)(default=3D1)=
");
=20
+static bool warn_irq;
+module_param(warn_irq, bool, 0);
+MODULE_PARM_DESC(warn_irq,
+	"Watchdog trigs a panic at first expiration (default=3D0)");
+
 /*
  * Some TCO specific functions
  */
@@ -200,6 +216,37 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
 	return ret; /* returns: 0 =3D OK, -EIO =3D Error */
 }
=20
+static u32 iTCO_wdt_wirq(acpi_handle gpe_device, u32 gpe, void *contex=
t)
+{
+	pr_warn("[SHTDWN] %s, WATCHDOG TIMEOUT HANDLER!\n", __func__);
+
+	trigger_all_cpu_backtrace();
+	panic("Kernel Watchdog");
+
+	/* This code should not be reached */
+	return IRQ_HANDLED;
+}
+
+static int iTCO_wdt_acpi_add(struct acpi_device *device)
+{
+	unsigned long long gpe;
+	acpi_status status;
+
+	status =3D acpi_evaluate_integer(device->handle, "_GPE", NULL, &gpe);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	status =3D acpi_install_gpe_handler(NULL, gpe, ACPI_GPE_EDGE_TRIGGERE=
D,
+					  iTCO_wdt_wirq, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	acpi_enable_gpe(NULL, gpe);
+
+	pr_info("interrupt=3DSCI GPE=3D0x%02llx", gpe);
+	return 0;
+}
+
 static int iTCO_wdt_start(struct watchdog_device *wd_dev)
 {
 	unsigned int val;
@@ -628,6 +675,15 @@ static struct platform_driver iTCO_wdt_driver =3D =
{
 	},
 };
=20
+static struct acpi_driver iTCO_wdt_acpi_driver =3D {
+	.name =3D DRV_NAME_ACPI,
+	.class =3D TCO_CLASS,
+	.ids =3D iTCO_wdt_ids,
+	.ops =3D {
+		.add =3D iTCO_wdt_acpi_add,
+	},
+};
+
 static int __init iTCO_wdt_init_module(void)
 {
 	int err;
@@ -638,12 +694,22 @@ static int __init iTCO_wdt_init_module(void)
 	if (err)
 		return err;
=20
+	if (warn_irq) {
+		err =3D acpi_bus_register_driver(&iTCO_wdt_acpi_driver);
+		if (err) {
+			platform_driver_unregister(&iTCO_wdt_driver);
+			return err;
+		}
+	}
+
 	return 0;
 }
=20
 static void __exit iTCO_wdt_cleanup_module(void)
 {
 	platform_driver_unregister(&iTCO_wdt_driver);
+	if (warn_irq)
+		acpi_bus_unregister_driver(&iTCO_wdt_acpi_driver);
 	pr_info("Watchdog Module Unloaded\n");
 }
=20
--=20
1.7.9.5



-----Original Message-----
=46rom: Guenter Roeck [mailto:linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org]=20
Sent: Thursday, December 11, 2014 3:30 PM
To: Darren Hart; Muller, Francois-nicolas
Cc: 'platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'; Rafael Wysocki; Linux ACPI M=
ailing List; linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wim Van Sebroeck
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation

On 12/10/2014 08:04 PM, Darren Hart wrote:
> On Fri, Dec 05, 2014 at 10:08:45AM +0000, Muller, Francois-nicolas wr=
ote:
>> This driver provides support for TCO watchdog warning interrupt.
>>
>
> Hi Francois,
>
> Cc: Rafael and linux-acpi per his request on ACPI drivers (even if=20
> they are for platform/drivers/x86).
>
>> This feature is useful to root cause watchdog expiration.
>
> Would this not be better suited as a debug option to the iTCO_wdt.c=20
> driver under drivers/watchdog?
>

I agree, this should be in the watchdog driver.

Normally a watchdog is expected to reset the system if it fires. This i=
s its "normal" operation. Correct, some watchdogs create an NMI or some=
 other interrupt before this happens, as a last warning to give the sys=
tem a chance to do something about it.

Catching this interrupt and dumping a message maybe a good idea, but le=
tting the system panic as response seems to be excessive and may even b=
e counter-productive. Maybe there should be a run-time option (eg a boo=
t parameter), in addition or instead of the Kconfig entry, to enable it=
, if it is considered useful for debugging.

I find the headline in the Kconfig entry a bit misleading. It states "s=
upport interrupt", while what it really does is to crash the system if =
that interrupt actually happens. I don't usually call that "support".

Thanks,
Guenter

> Cc: Wim Van Sebroeck and linux-watchdog
>
>> Upon first expiration of the TCO watchdog, a warning interrupt is=20
>> fired to this driver, which calls panic() function and dumps debug=20
>> information (registers and call stacks).
>
> Nit: Newlines between paragraphs for legibility here and in comments =
please.
>
>> This implies TCO watchdog driver has enabled the interrupt (SCI) and=
=20
>> ACPI tables contain GPE mapping information.
>> After the interrupt has been fired, TCO watchdog reloads=20
>> automatically and upon second expiration it trigs a reset of the pla=
tform.
>
> triggers
>
>>
>> Change-Id: I39b615b59dd4336bf208454f08b3e9eac9eb2880
>
> Please run through checkpatch.pl (Gerrit change-id's should be remove=
d).
>
>> Signed-off-by: Francois-Nicolas Muller=20
>> <francois-nicolas.muller-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>> drivers/platform/x86/Kconfig          |   13 +++++
>> drivers/platform/x86/Makefile         |    1 +
>> drivers/platform/x86/intel_warn_int.c |   98 +++++++++++++++++++++++=
++++++++++
>> 3 files changed, 112 insertions(+)
>> create mode 100644 drivers/platform/x86/intel_warn_int.c
>>
>> diff --git a/drivers/platform/x86/Kconfig=20
>> b/drivers/platform/x86/Kconfig index 5ae65c1..79cba16 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -827,4 +827,17 @@ config INTEL_BAYTRAIL_MBI
>>                   Interface. This is a requirement for systems that =
need to configure
>>                   the PUNIT for power management features such as RA=
PL.
>> +config INTEL_WARN_INT
>> +             tristate "TCO Watchdog warning interrupt"
>> +             depends on ITCO_WDT
>> +             ---help---
>> +               This driver provides support for TCO watchdog warnin=
g interrupt.
>> +               Upon first expiration of the TCO watchdog, a warning=
 interrupt is
>> +               fired and the driver calls panic() function to dump=20
>> +debug information
>
> s/function//
>
>> +               (registers and call stacks).
>
> newline
>
>> +               At the same time, the TCO watchdog reloads with 2.4 =
seconds timeout
>> +               value and runs till the second expiration. At the=20
>> + second expiration of
>
> s/till/until/
>
>> +               the TCO watchdog, the platform resets (the dump is s=
upposed to last less
>> +               than 2.4 seconds).
>> +
>> endif # X86_PLATFORM_DEVICES
>> diff --git a/drivers/platform/x86/Makefile=20
>> b/drivers/platform/x86/Makefile index 32caae3..2d47b4d 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -58,3 +58,4 @@ obj-$(CONFIG_PVPANIC)                             =
  +=3D pvpanic.o
>> obj-$(CONFIG_INTEL_BAYTRAIL_MBI)                +=3D intel_baytrail.=
o
>> obj-$(CONFIG_INTEL_SOC_PMIC)        +=3D dc_ti_cc.o
>> obj-$(CONFIG_ACPI)                   +=3D intel_em_config.o
>> +obj-$(CONFIG_INTEL_WARN_INT)      +=3D intel_warn_int.o
>> diff --git a/drivers/platform/x86/intel_warn_int.c=20
>> b/drivers/platform/x86/intel_warn_int.c
>> new file mode 100644
>> index 0000000..7ec8b73
>> --- /dev/null
>> +++ b/drivers/platform/x86/intel_warn_int.c
>> @@ -0,0 +1,98 @@
>> +/*
>> + * intel_warn_int.c - This driver provides support for TCO watchdog=
=20
>> +warning
>> + * interrupt.
>
> Newlines between paragraphs in this section too.
>
>> + * This feature is useful to root cause watchdog expiration.
>> + * Upon first expiration of the TCO watchdog, a warning interrupt i=
s=20
>> + fired
>> + * to this driver, which calls panic() function and dumps debug=20
>> + information
>
> s/function//
>
>> + * (registers and call stacks).
>> + * This implies TCO watchdog driver has enabled the interrupt (SCI)=
=20
>> + and ACPI
>
> the ACPI...
>
>> + * tables contain GPE mapping information.
>
> the GPE...
>
>> + * After the interrupt has been fired, TCO watchdog reloads=20
>> + automatically and
>> + * upon second expiration it trigs a reset of the platform.
>
> triggers
>
>> + * Copyright (c) 2014, Intel Corporation.
>
> All rights reserved.
>
>> + *
>> + * This program is free software; you can redistribute it and/or=20
>> + modify it
>> + * under the terms and conditions of the GNU General Public License=
,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but=20
>> + WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of=20
>> + MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public=20
>> + License for
>> + * more details.
>> + *
>
> extra * line, can remove.
>
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/module.h>
>> +#include <linux/types.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/acpi.h>
>> +#include <linux/nmi.h>
>> +#include <acpi/actypes.h>
>> +
>> +#define DRV_NAME "warn_int"
>> +#define TCO_CLASS DRV_NAME
>> +
>> +static const struct acpi_device_id tco_device_ids[] =3D {
>> +             {"8086229C", 0},
>
> What is this device ID? Is it specific to a debug ID for the WDT? If=20
> not, will this eventually conflict with a non-debug driver for this W=
DT?
>
>> +             {"", 0},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, tco_device_ids);
>> +
>> +static u32 warn_irq_handler(acpi_handle gpe_device, u32 gpe, void=20
>> +*context) {
>> +             pr_warn("[SHTDWN] %s, WATCHDOG TIMEOUT HANDLER!\n",=20
>> +__func__);
>
> Indenting with 13 spaces? Please review Documentation/CodingStyle and=
=20
> update the patch. Rather than point out all these sorts of errors, I'=
m=20
> goign to stop here - please read the doc and correct throughout.
>
>> +
>> +             trigger_all_cpu_backtrace();
>> +             panic("Kernel Watchdog");
>> +
>> +             /* This code should not be reached */
>> +             return IRQ_HANDLED;
>> +}
>> +
>> +static int acpi_tco_add(struct acpi_device *device) {
>> +             acpi_status status;
>> +             unsigned long long tco_gpe;
>
> Declare variables in decreasing line length order.
>
>> +
>> +             status =3D acpi_evaluate_integer(device->handle, "_GPE=
", NULL, &tco_gpe);
>> +             if (ACPI_FAILURE(status))
>> +                             return -EINVAL;
>> +
>> +             status =3D acpi_install_gpe_handler(NULL, tco_gpe,
>> +                                                                   =
           ACPI_GPE_EDGE_TRIGGERED,
>> +                                                                   =
           warn_irq_handler, NULL);
>> +             if (ACPI_FAILURE(status))
>> +                             return -ENODEV;
>> +
>> +             acpi_enable_gpe(NULL, tco_gpe);
>> +
>> +             pr_info("initialized. Interrupt=3DSCI GPE 0x%02llx", t=
co_gpe);
>> +             return 0;
>> +}
>> +
>> +static struct acpi_driver tco_driver =3D {
>> +             .name =3D "warn_int",
>> +             .class =3D TCO_CLASS,
>> +             .ids =3D tco_device_ids,
>> +             .ops =3D {
>> +                             .add =3D acpi_tco_add,
>> +             },
>> +};
>> +
>> +static int __init warn_int_init(void) {
>> +             return acpi_bus_register_driver(&tco_driver);
>> +}
>> +
>> +module_init(warn_int_init);
>> +/* no module_exit, this driver shouldn't be unloaded */
>> +
>> +MODULE_AUTHOR("Francois-Nicolas Muller=20
>> +<francois-nicolas.muller-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
>> +MODULE_DESCRIPTION("Intel TCO WatchDog Warning Interrupt");=20
>> +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:" DRV_NAME);
>> --
>> 1.7.9.5
>>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
