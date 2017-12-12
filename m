From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3 v5] thinkpad_acpi: Add support for battery thresholds
Date: Tue, 12 Dec 2017 21:10:33 +0200
Message-ID: <CAHp75VeP=mz1xrJ91AbXFYwET9oSjqy32R0b9WgOG-Nvfxy8xg@mail.gmail.com>
References: <20171210180650.GA2039@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40427 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbdLLTKe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Dec 2017 14:10:34 -0500
In-Reply-To: <20171210180650.GA2039@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org

On Sun, Dec 10, 2017 at 8:06 PM, Ognjen Galic <smclt30p@gmail.com> wrote:

>  #include <linux/jiffies.h>
>  #include <linux/workqueue.h>
>  #include <linux/acpi.h>
> +#include <linux/power_supply.h>
>  #include <linux/pci_ids.h>
>  #include <linux/thinkpad_acpi.h>
>  #include <sound/core.h>
> @@ -84,6 +85,8 @@
>  #include <sound/initval.h>
>  #include <linux/uaccess.h>
>  #include <acpi/video.h>
> +#include <acpi/battery.h>

I would try to keep it more ordered (yes, I noticed that no order in
the original file), like

 #include <linux/acpi.h>
 #include <linux/pci_ids.h>
+#include <linux/power_supply.h>
 #include <linux/thinkpad_acpi.h>

+#include <acpi/battery.h>
 #include <acpi/video.h>

instead of above.

> +/**

I think the function name is missed here.

> + * This evaluates a ACPI method call specific to the battery
> + * ACPI extension. The specifics are that an error is marked
> + * in the 32rd bit of the response, so we just check that here.
> + *
> + * Returns 0 on success
> + */
> +static int tpacpi_battery_eval(char *method, int *ret, int param)
> +{
> +       if (!acpi_evalf(hkey_handle, ret, method, "dd", param)) {
> +               pr_err("%s: evaluate failed", method);
> +               return AE_ERROR;
> +       }
> +
> +       if (*ret & METHOD_ERR) {
> +               pr_err("%s evaluated but flagged as error", method);
> +               return AE_ERROR;
> +       }
> +

Just a side note: does it make any sense to switch to
acpi_handle_err() at some point?

> +       return AE_OK;
> +}

> +static int tpacpi_battery_get(int what, int battery, int *ret)
> +{

> +               /*
> +                * On the stop value, if we return 0 that
> +                * does not make any sense. 0 means Default, which
> +                * means that charging stops at 100%, so we return
> +                * that.
> +                */

> +               *ret = *ret == 0 ? 100 : *ret;

Hmm... Perhaps just

if (*ret == 0)
*ret = 100;

?

> +               return 0;

> +}
> +
> +static int tpacpi_battery_set(int what, int battery, int value)
> +{
> +
> +       int param = 0x0, ret = 0xFFFFFFFF;
> +
> +       /* The first 8 bits are the value of the threshold */
> +       param = value;
> +       /* The battery ID is in bits 8-9, 2 bits */
> +       param |= (battery << 8);

Redundant parens.

> +}

> +
> +static int tpacpi_battery_probe(int battery)
> +{
> +       int ret = 0;
> +
> +       /* Reset the struct */
> +       battery_info.start_support[battery] = 0x0;
> +       battery_info.stop_support[battery] = 0x0;
> +       battery_info.start_charge[battery] = 0x0;
> +       battery_info.stop_charge[battery] = 0x0;
> +

Hmm... If you reorganize your data struct to
struct _info {
};

struct _pdata {
 ...
 struct _info info[3];
};

You can use memset() and memcpy() or just plain assignment whenever it's needed.

> +               /* Individual addressing is in bit 9 */
> +               if (ret & (1 << 9))

BIT(9) ?

> +               /* Support is marked in bit 8 */
> +               if (ret & (1 << 8))

BIT(8) ?

> +                       battery_info.start_support[battery] = 1;

> +               else
> +                       return -ENODEV;

OK, here it is in align with the previous cond.


> +               /* Support is marked in bit 8 */
> +               if (ret & (1 << 8))
> +                       battery_info.stop_support[battery] = 1;

> +       pr_info("battery %d registered (start %d, stop %d)",
> +                       battery,
> +                       battery_info.start_charge[battery],
> +                       battery_info.stop_charge[battery]);
> +
> +       return 0;
> +}
> +
> +/* General helper functions */
> +
> +static int tpacpi_battery_get_id(const char *battery_name)
> +{
> +
> +       if (strcmp(battery_name, "BAT0") == 0)
> +               return BAT_PRIMARY;

> +       else if (strcmp(battery_name, "BAT1") == 0)

1. Redundant 'else'.
2. Consider to use match_string().

> +}

> +static int tpacpi_battery_get_attr(struct device_attribute *attr)
> +{
> +       if (strcmp(START_ATTR, attr->attr.name) == 0)
> +               return THRESHOLD_START;
> +       else if (strcmp(STOP_ATTR, attr->attr.name) == 0)
> +               return THRESHOLD_STOP;
> +
> +       pr_crit("Invalid attribute: %s", attr->attr.name);
> +       return -EINVAL;
> +}
> +
> +/* sysfs interface */
> +
> +static ssize_t tpacpi_battery_store(struct device *dev,
> +                                  struct device_attribute *devattr,
> +                                  const char *buf, size_t count)
> +{
> +       int attr, battery;
> +       long value;

> +       struct power_supply *supply =
> +               container_of(dev, struct power_supply, dev);

drivers/power/supply/power_supply_core.c:671:

Perhaps move it to the header of power supply subsystem?

> +
> +       if (!supply) {
> +               pr_crit("Can't upcast to power_supply!");

I recommend to reconsider levels on which you print some messages
here. Do we really need KERN_CRIT?

> +               return -ENODEV;
> +       }
> +

> +       if (battery_info.individual_addressing)
> +               /* BAT_PRIMARY or BAT_SECONDARY */
> +               battery = tpacpi_battery_get_id(supply->desc->name);
> +       else
> +               battery = BAT_PRIMARY;
> +
> +       if (kstrtol(buf, 10, &value))

...ul()?

> +               return -EINVAL;
> +
> +       attr = tpacpi_battery_get_attr(devattr);
> +

> +               value = value == 100 ? 0 : value;

if (value == 100)
value = 0;

> +}
> +
> +static ssize_t tpacpi_battery_show(struct device *dev,
> +                                 struct device_attribute *devattr,
> +                                 char *buf)
> +{
> +       int ret = 0x0, attr, battery;

> +       struct power_supply *supply =
> +               container_of(dev, struct power_supply, dev);

See above.

> +}

> +
> +static const struct device_attribute battery_start = {
> +       .show = tpacpi_battery_show,
> +       .store = tpacpi_battery_store,
> +       .attr = {
> +               .name = START_ATTR,
> +               .mode = 0644,
> +       },
> +};
> +
> +static const struct device_attribute battery_stop = {
> +       .show = tpacpi_battery_show,
> +       .store = tpacpi_battery_store,
> +       .attr = {
> +               .name = STOP_ATTR,
> +               .mode = 0644,
> +       },
> +};

Don't we have some helper macros for above?
Something based on __ATTR_RW() ?

> +static int tpacpi_battery_add(struct power_supply *battery)
> +{
> +       int batteryid = tpacpi_battery_get_id(battery->desc->name);
> +
> +       pr_info("battery %s added", battery->desc->name);
> +
> +       if (tpacpi_battery_probe(batteryid))
> +               return -ENODEV;
> +
> +       if (device_create_file(&battery->dev, &battery_start))
> +               return -ENODEV;
> +
> +       if (device_create_file(&battery->dev, &battery_stop))
> +               return -ENODEV;

Shouldn't be done via group attribures?

> +
> +       return 0;
> +}


> +static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
> +{
> +       tp_features.battery = 0;
> +       battery_hook_register(&battery_hook);
> +

> +       pr_info("battery driver initialized");

This kind of messages is somehow useless. 'initcall_debug' will show you this.

> +
> +       battery_info.individual_addressing = 0;
> +       tp_features.battery = 1;
> +
> +       return 0;
> +}
> +
> +static void tpacpi_battery_exit(void)
> +{

> +       if (!tp_features.battery) {
> +               pr_info("battery driver was not loaded, not de-registering");
> +               return;
> +       }

When might it happen?

> +
> +       battery_hook_unregister(&battery_hook);
> +}

-- 
With Best Regards,
Andy Shevchenko
