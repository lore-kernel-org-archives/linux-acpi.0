From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] ACPI / watchdog: Add support for WDAT hardware
 watchdog
Date: Tue, 13 Sep 2016 14:00:25 -0700
Message-ID: <af61227f-926a-f89d-1e39-381527fd6613@roeck-us.net>
References: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
 <20160913152336.75405-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46790 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755344AbcIMVAf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2016 17:00:35 -0400
In-Reply-To: <20160913152336.75405-2-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Wim Van Sebroeck <wim@iguana.be>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/13/2016 08:23 AM, Mika Westerberg wrote:
> Starting from Intel Skylake the iTCO watchdog timer registers were moved to
> reside in the same register space with SMBus host controller.  Not all
> needed registers are available though and we need to unhide P2SB (Primary
> to Sideband) device briefly to be able to read status of required NO_REBOOT
> bit. The i2c-i801.c SMBus driver used to handle this and creation of the
> iTCO watchdog platform device.
>
> Windows, on the other hand, does not use the iTCO watchdog hardware
> directly even if it is available. Instead it relies on ACPI Watchdog Action
> Table (WDAT) table to describe the watchdog hardware to the OS. This table
> contains necessary information about the the hardware and also set of
> actions which are executed by a driver as needed.
>
> This patch implements a new watchdog driver that takes advantage of the
> ACPI WDAT table. We split the functionality into two parts: first part
> enumerates the WDAT table and if found, populates resources and creates
> platform device for the actual driver. The second part is the driver
> itself.
>
> The reason for the split is that this way we can make the driver itself to
> be a module and loaded automatically if the WDAT table is found. Otherwise
> the module is not loaded.
>
What I don't really like is that the driver won't be in the watchdog directory,
and will thus easily be overlooked in the future by watchdog maintainers.

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/Kconfig         |  16 ++
>  drivers/acpi/Makefile        |   2 +
>  drivers/acpi/acpi_watchdog.c | 123 ++++++++++
>  drivers/acpi/internal.h      |  10 +
>  drivers/acpi/scan.c          |   1 +
>  drivers/acpi/wdat_wdt.c      | 524 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h         |   6 +
>  7 files changed, 682 insertions(+)
>  create mode 100644 drivers/acpi/acpi_watchdog.c
>  create mode 100644 drivers/acpi/wdat_wdt.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 445ce28475b3..f6dc7885c35f 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -462,6 +462,22 @@ source "drivers/acpi/nfit/Kconfig"
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
>
> +config ACPI_WATCHDOG
> +	bool
> +
> +config ACPI_WDAT_WDT
> +	tristate "ACPI Watchdog Action Table (WDAT)"
> +	depends on WATCHDOG_CORE
> +	select ACPI_WATCHDOG
> +	help
> +	  This driver adds support for systems with ACPI Watchdog Action
> +	  Table (WDAT) table. Servers typically have this but it can be
> +	  found on some desktop machines as well. This driver will take
> +	  over the native iTCO watchdog driver found on many Intel CPUs.
> +
> +	  To compile this driver as module, choose M here: the module will
> +	  be called wdat_wdt.
> +
>  config ACPI_EXTLOG
>  	tristate "Extended Error Log support"
>  	depends on X86_MCE && X86_LOCAL_APIC
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 5ae9d85c5159..b9568a954090 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -56,6 +56,7 @@ acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  acpi-y				+= acpi_lpat.o
>  acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
> +acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
>
>  # These are (potentially) separate modules
>
> @@ -82,6 +83,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
> +obj-$(CONFIG_ACPI_WDAT_WDT)	+= wdat_wdt.o
>
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> new file mode 100644
> index 000000000000..13caebd679f5
> --- /dev/null
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -0,0 +1,123 @@
> +/*
> + * ACPI watchdog table parsing support.
> + *
Not just parsing. Looks to me like an ACPI watchdog driver.

> + * Copyright (C) 2016, Intel Corporation
> + * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "ACPI: watchdog: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +
> +#include "internal.h"
> +
> +/**
> + * Returns true if this system should prefer ACPI based watchdog instead of
> + * the native one (which are typically the same hardware).
> + */
> +bool acpi_has_watchdog(void)
> +{
> +	struct acpi_table_header hdr;
> +
> +	if (acpi_disabled)
> +		return false;
> +
> +	return ACPI_SUCCESS(acpi_get_table_header(ACPI_SIG_WDAT, 0, &hdr));
> +}
> +EXPORT_SYMBOL_GPL(acpi_has_watchdog);
> +
> +void __init acpi_watchdog_init(void)
> +{
> +	const struct acpi_wdat_entry *entries;
> +	const struct acpi_table_wdat *wdat;
> +	struct list_head resource_list;
> +	struct resource_entry *rentry;
> +	struct platform_device *pdev;
> +	struct resource *resources;
> +	size_t nresources = 0;
> +	acpi_status status;
> +	int i;
> +
> +	status = acpi_get_table(ACPI_SIG_WDAT, 0,
> +				(struct acpi_table_header **)&wdat);
> +	if (ACPI_FAILURE(status)) {
> +		/* It is fine if there is no WDAT */
> +		return;
> +	}
> +
> +	/* Watchdog disabled by BIOS */
> +	if (!(wdat->flags & ACPI_WDAT_ENABLED))
> +		return;
> +
> +	/* Skip legacy PCI WDT devices */
> +	if (wdat->pci_segment != 0xff || wdat->pci_bus != 0xff ||
> +	    wdat->pci_device != 0xff || wdat->pci_function != 0xff)
> +		return;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +
> +	entries = (struct acpi_wdat_entry *)(wdat + 1);
> +	for (i = 0; i < wdat->entries; i++) {
> +		const struct acpi_generic_address *gas;
> +		struct resource_entry *rentry;
> +		struct resource res;
> +		bool found;
> +
> +		gas = &entries[i].register_region;
> +
> +		res.start = gas->address;
> +		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +			res.flags = IORESOURCE_MEM;
> +			res.end = res.start + ALIGN(gas->access_width, 4);
> +		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +			res.flags = IORESOURCE_IO;
> +			res.end = res.start + gas->access_width;
> +		} else {
> +			pr_warn("Unsupported address space: %u\n",
> +				gas->space_id);
> +			goto fail_free_resource_list;
> +		}
> +
> +		found = false;
> +		resource_list_for_each_entry(rentry, &resource_list) {
> +			if (resource_contains(rentry->res, &res)) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			rentry = resource_list_create_entry(NULL, 0);
> +			if (!rentry)
> +				goto fail_free_resource_list;
> +
> +			*rentry->res = res;
> +			resource_list_add_tail(rentry, &resource_list);
> +			nresources++;
> +		}
> +	}
> +
> +	resources = kcalloc(nresources, sizeof(*resources), GFP_KERNEL);
> +	if (!resources)
> +		goto fail_free_resource_list;
> +
> +	i = 0;
> +	resource_list_for_each_entry(rentry, &resource_list)
> +		resources[i++] = *rentry->res;
> +
> +	pdev = platform_device_register_simple("wdat_wdt", PLATFORM_DEVID_NONE,
> +					       resources, nresources);
> +	if (IS_ERR(pdev))
> +		pr_err("Failed to create platform device\n");
> +
> +	kfree(resources);
> +
> +fail_free_resource_list:
> +	resource_list_free(&resource_list);
> +}
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 940218ff0193..fb9a7ad96756 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -225,4 +225,14 @@ static inline void suspend_nvs_restore(void) {}
>  void acpi_init_properties(struct acpi_device *adev);
>  void acpi_free_properties(struct acpi_device *adev);
>
> +/*--------------------------------------------------------------------------
> +				Watchdog
> +  -------------------------------------------------------------------------- */
> +
> +#ifdef CONFIG_ACPI_WATCHDOG
> +void acpi_watchdog_init(void);
> +#else
> +static inline void acpi_watchdog_init(void) {}
> +#endif
> +
>  #endif /* _ACPI_INTERNAL_H_ */
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e878fc799af7..3b85d87021da 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2002,6 +2002,7 @@ int __init acpi_scan_init(void)
>  	acpi_pnp_init();
>  	acpi_int340x_thermal_init();
>  	acpi_amba_init();
> +	acpi_watchdog_init();
>
>  	acpi_scan_add_handler(&generic_device_handler);
>
> diff --git a/drivers/acpi/wdat_wdt.c b/drivers/acpi/wdat_wdt.c
> new file mode 100644
> index 000000000000..a541753a3fc1
> --- /dev/null
> +++ b/drivers/acpi/wdat_wdt.c
> @@ -0,0 +1,524 @@
> +/*
> + * ACPI Hardware Watchdog (WDAT) driver.
> + *
> + * Copyright (C) 2016, Intel Corporation
> + * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/watchdog.h>
> +
> +#define MAX_WDAT_ACTIONS ACPI_WDAT_ACTION_RESERVED
> +
> +/**
> + * struct wdat_instruction - Single ACPI WDAT instruction
> + * @entry: Copy of the ACPI table instruction
> + * @reg: Register the instruction is accessing
> + * @node: Next instruction in action sequence
> + */
> +struct wdat_instruction {
> +	struct acpi_wdat_entry entry;
> +	void __iomem *reg;
> +	struct list_head node;
> +};
> +
> +/**
> + * struct wdat_wdt - ACPI WDAT watchdog device
> + * @pdev: Parent platform device
> + * @wdd: Watchdog core device
> + * @period: How long is one watchdog period in ms
> + * @stopped_in_sleep: Is this watchdog stopped by the firmware in S1-S5
> + * @stopped: Was the watchdog stopped by the driver in suspend
> + * @actions: An array of instruction lists indexed by an action number from
> + *           the WDAT table. There can be %NULL entries for not implemented
> + *           actions.
> + */
> +struct wdat_wdt {
> +	struct platform_device *pdev;
> +	struct watchdog_device wdd;
> +	unsigned int period;
> +	bool stopped_in_sleep;
> +	bool stopped;
> +	struct list_head *instructions[MAX_WDAT_ACTIONS];
> +};
> +
> +#define to_wdat_wdt(wdd) container_of(wdd, struct wdat_wdt, wdd)
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int wdat_wdt_read(struct wdat_wdt *wdat,
> +	 const struct wdat_instruction *instr, u32 *value)
> +{
> +	const struct acpi_generic_address *gas = &instr->entry.register_region;
> +
> +	switch (gas->access_width) {
> +	case 1:
> +		*value = ioread8(instr->reg);
> +		break;
> +	case 2:
> +		*value = ioread16(instr->reg);
> +		break;
> +	case 3:
> +		*value = ioread32(instr->reg);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&wdat->pdev->dev, "Read %#x from 0x%08llx\n", *value,
> +		gas->address);
> +
> +	return 0;
> +}
> +
> +static int wdat_wdt_write(struct wdat_wdt *wdat,
> +	const struct wdat_instruction *instr, u32 value)
> +{
> +	const struct acpi_generic_address *gas = &instr->entry.register_region;
> +
> +	switch (gas->access_width) {
> +	case 1:
> +		iowrite8((u8)value, instr->reg);
> +		break;
> +	case 2:
> +		iowrite16((u16)value, instr->reg);
> +		break;
> +	case 3:
> +		iowrite32(value, instr->reg);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&wdat->pdev->dev, "Wrote %#x to 0x%08llx\n", value,
> +		gas->address);
> +
> +	return 0;
> +}
> +
> +static int wdat_wdt_run_action(struct wdat_wdt *wdat, unsigned int action,
> +			       u32 param, u32 *retval)
> +{
> +	struct wdat_instruction *instr;
> +
> +	if (action >= ARRAY_SIZE(wdat->instructions))
> +		return -EINVAL;
> +
> +	if (!wdat->instructions[action])
> +		return -EOPNOTSUPP;
> +
> +	dev_dbg(&wdat->pdev->dev, "Running action %#x\n", action);
> +
> +	/* Run each instruction sequentially */
> +	list_for_each_entry(instr, wdat->instructions[action], node) {
> +		const struct acpi_wdat_entry *entry = &instr->entry;
> +		const struct acpi_generic_address *gas;
> +		u32 flags, value, mask, x, y;
> +		bool preserve;
> +		int ret;
> +
> +		gas = &entry->register_region;
> +
> +		preserve = entry->instruction & ACPI_WDAT_PRESERVE_REGISTER;
> +		flags = entry->instruction & ~ACPI_WDAT_PRESERVE_REGISTER;
> +		value = entry->value;
> +		mask = entry->mask;
> +
> +		switch (flags) {
> +		case ACPI_WDAT_READ_VALUE:
> +			ret = wdat_wdt_read(wdat, instr, &x);
> +			if (ret)
> +				return ret;
> +			x >>= gas->bit_offset;
> +			x &= mask;
> +			if (retval)
> +				*retval = x == value;
> +			break;
> +
> +		case ACPI_WDAT_READ_COUNTDOWN:
> +			ret = wdat_wdt_read(wdat, instr, &x);
> +			if (ret)
> +				return ret;
> +			x >>= gas->bit_offset;
> +			x &= mask;
> +			if (retval)
> +				*retval = x;
> +			break;
> +
> +		case ACPI_WDAT_WRITE_VALUE:
> +			x = value & mask;
> +			x <<= gas->bit_offset;
> +			if (preserve) {
> +				ret = wdat_wdt_read(wdat, instr, &y);
> +				if (ret)
> +					return ret;
> +				y = y & ~(mask << gas->bit_offset);
> +				x |= y;
> +			}
> +			ret = wdat_wdt_write(wdat, instr, x);
> +			if (ret)
> +				return ret;
> +			break;
> +
> +		case ACPI_WDAT_WRITE_COUNTDOWN:
> +			x = param;
> +			x &= mask;
> +			x <<= gas->bit_offset;
> +			if (preserve) {
> +				ret = wdat_wdt_read(wdat, instr, &y);
> +				if (ret)
> +					return ret;
> +				y = y & ~(mask << gas->bit_offset);
> +				x |= y;
> +			}
> +			ret = wdat_wdt_write(wdat, instr, x);
> +			if (ret)
> +				return ret;
> +			break;
> +
> +		default:
> +			dev_err(&wdat->pdev->dev, "Unknown instruction: %u\n",
> +				flags);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int wdat_wdt_enable_reboot(struct wdat_wdt *wdat)
> +{
> +	int ret;
> +
> +	/*
> +	 * WDAT specification says that the watchdog is required to reboot
> +	 * the system when it fires. However, it also states that it is
> +	 * recommeded to make it configurable through hardware register. We
> +	 * enable reboot now if it is configrable, just in case.
> +	 */
> +	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_REBOOT, 0, 0);
> +	if (ret && ret != -EOPNOTSUPP) {
> +		dev_err(&wdat->pdev->dev,
> +			"Failed to enable reboot when watchdog triggers\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void wdat_wdt_boot_status(struct wdat_wdt *wdat)
> +{
> +	u32 boot_status = 0;
> +	int ret;
> +
> +	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_GET_STATUS, 0, &boot_status);
> +	if (ret && ret != -EOPNOTSUPP) {
> +		dev_err(&wdat->pdev->dev, "Failed to read boot status\n");
> +		return;
> +	}
> +
> +	if (boot_status)
> +		wdat->wdd.bootstatus = WDIOF_CARDRESET;
> +
> +	/* Clear the boot status in case BIOS did not do it */
> +	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_STATUS, 0, 0);
> +	if (ret && ret != -EOPNOTSUPP)
> +		dev_err(&wdat->pdev->dev, "Failed to clear boot status\n");
> +}
> +
> +static int wdat_wdt_start(struct watchdog_device *wdd)
> +{
> +	return wdat_wdt_run_action(to_wdat_wdt(wdd),
> +				   ACPI_WDAT_SET_RUNNING_STATE, 0, NULL);
> +}
> +
> +static int wdat_wdt_stop(struct watchdog_device *wdd)
> +{
> +	return wdat_wdt_run_action(to_wdat_wdt(wdd),
> +				   ACPI_WDAT_SET_STOPPED_STATE, 0, NULL);
> +}
> +
> +static int wdat_wdt_ping(struct watchdog_device *wdd)
> +{
> +	return wdat_wdt_run_action(to_wdat_wdt(wdd), ACPI_WDAT_RESET, 0, NULL);
> +}
> +
> +static int wdat_wdt_set_timeout(struct watchdog_device *wdd,
> +				unsigned int timeout)
> +{
> +	struct wdat_wdt *wdat = to_wdat_wdt(wdd);
> +	unsigned int periods;
> +	int ret;
> +
> +	periods = timeout * 1000 / wdat->period;
> +	ret = wdat_wdt_run_action(wdat, ACPI_WDAT_SET_COUNTDOWN, periods, NULL);
> +	if (!ret)
> +		wdd->timeout = timeout;
> +	return ret;
> +}
> +
> +static unsigned int wdat_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct wdat_wdt *wdat = to_wdat_wdt(wdd);
> +	u32 periods = 0;
> +
> +	wdat_wdt_run_action(wdat, ACPI_WDAT_GET_COUNTDOWN, 0, &periods);
> +	return periods * wdat->period / 1000;
> +}
> +
> +static const struct watchdog_info wdat_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.firmware_version = 0,
> +	.identity = "wdat_wdt",
> +};
> +
> +static const struct watchdog_ops wdat_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = wdat_wdt_start,
> +	.stop = wdat_wdt_stop,
> +	.ping = wdat_wdt_ping,
> +	.set_timeout = wdat_wdt_set_timeout,
> +	.get_timeleft = wdat_wdt_get_timeleft,
> +};
> +
> +static int wdat_wdt_probe(struct platform_device *pdev)
> +{
> +	const struct acpi_wdat_entry *entries;
> +	const struct acpi_table_wdat *tbl;
> +	struct wdat_wdt *wdat;
> +	struct resource *res;
> +	void __iomem **regs;
> +	acpi_status status;
> +	int i, ret;
> +
> +	status = acpi_get_table(ACPI_SIG_WDAT, 0,
> +				(struct acpi_table_header **)&tbl);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	wdat = devm_kzalloc(&pdev->dev, sizeof(*wdat), GFP_KERNEL);
> +	if (!wdat)
> +		return -ENOMEM;
> +
> +	regs = devm_kcalloc(&pdev->dev, pdev->num_resources, sizeof(*regs),
> +			    GFP_KERNEL);
> +	if (!regs)
> +		return -ENOMEM;
> +
> +	wdat->period = tbl->timer_period;

Is this guaranteed to never be 0 ?

> +	wdat->wdd.max_timeout = wdat->period * tbl->max_count / 1000;
> +	wdat->wdd.min_timeout = wdat->period * tbl->min_count / 1000;

Are those guaranteed to be correct, ie max_timeout >= min_timeout
and both valid ?

Reason for asking is that the core will accept any timeouts if, for
example, max_timeout is 0.

> +	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
> +	wdat->wdd.info = &wdat_wdt_info;
> +	wdat->wdd.ops = &wdat_wdt_ops;
> +	wdat->pdev = pdev;
> +
> +	/* Request and map all resources */
> +	for (i = 0; i < pdev->num_resources; i++) {
> +		void __iomem *reg;
> +
> +		res = &pdev->resource[i];
> +		if (resource_type(res) == IORESOURCE_MEM) {
> +			reg = devm_ioremap_resource(&pdev->dev, res);
> +		} else if (resource_type(res) == IORESOURCE_IO) {
> +			reg = devm_ioport_map(&pdev->dev, res->start, 1);
> +		} else {
> +			dev_err(&pdev->dev, "Unsupported resource\n");
> +			return -EINVAL;
> +		}
> +
> +		if (!reg)
> +			return -ENOMEM;
> +
> +		regs[i] = reg;
> +	}
> +
> +	entries = (struct acpi_wdat_entry *)(tbl + 1);
> +	for (i = 0; i < tbl->entries; i++) {
> +		const struct acpi_generic_address *gas;
> +		struct wdat_instruction *instr;
> +		struct list_head *instructions;
> +		unsigned int action;
> +		struct resource r;
> +		int j;
> +
> +		action = entries[i].action;
> +		if (action >= MAX_WDAT_ACTIONS) {
> +			dev_dbg(&pdev->dev, "Skipping unknown action: %u\n",
> +				action);
> +			continue;
> +		}
> +
> +		instr = devm_kzalloc(&pdev->dev, sizeof(*instr), GFP_KERNEL);
> +		if (!instr)
> +			return -ENOMEM;
> +
> +		INIT_LIST_HEAD(&instr->node);
> +		instr->entry = entries[i];
> +
> +		gas = &entries[i].register_region;
> +
> +		memset(&r, 0, sizeof(r));
> +		r.start = gas->address;
> +		r.end = r.start + gas->access_width;
> +		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +			r.flags = IORESOURCE_MEM;
> +		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +			r.flags = IORESOURCE_IO;
> +		} else {
> +			dev_dbg(&pdev->dev, "Unsupported address space: %d\n",
> +				gas->space_id);
> +			continue;
> +		}
> +
> +		/* Find the matching resource */
> +		for (j = 0; j < pdev->num_resources; j++) {
> +			res = &pdev->resource[j];
> +			if (resource_contains(res, &r)) {
> +				instr->reg = regs[j] + r.start - res->start;
> +				break;
> +			}
> +		}
> +
> +		if (!instr->reg) {
> +			dev_err(&pdev->dev, "I/O resource not found\n");
> +			return -EINVAL;
> +		}
> +
> +		instructions = wdat->instructions[action];
> +		if (!instructions) {
> +			instructions = devm_kzalloc(&pdev->dev,
> +					sizeof(*instructions), GFP_KERNEL);
> +			if (!instructions)
> +				return -ENOMEM;
> +
> +			INIT_LIST_HEAD(instructions);
> +			wdat->instructions[action] = instructions;
> +		}
> +
> +		list_add_tail(&instr->node, instructions);
> +	}
> +
> +	/* Make sure it is stopped now */
> +	ret = wdat_wdt_stop(&wdat->wdd);

Why ? You could set max_hw_heartbeat_ms instead of max_timeout and
inform the watchdog core that the watchdog is running (by setting
the WDOG_HW_RUNNING status flag).

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to stop watchdog\n");
> +		return ret;
> +	}
> +
> +	wdat_wdt_boot_status(wdat);
> +
> +	ret = wdat_wdt_enable_reboot(wdat);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, wdat);
> +
> +	watchdog_set_nowayout(&wdat->wdd, nowayout);
> +	return watchdog_register_device(&wdat->wdd);
> +}
> +
> +static int wdat_wdt_remove(struct platform_device *pdev)
> +{
> +	struct wdat_wdt *wdat = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdat->wdd);

You could also use devm_watchdog_register_device()
and drop the remove function.

> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP

I personally prefer to drop the #ifdef and use __maybe_unused instead.

> +static int wdat_wdt_suspend_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct wdat_wdt *wdat = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	if (!watchdog_active(&wdat->wdd))
> +		return 0;
> +
> +	/*
> +	 * We need to stop the watchdog if firmare is not doing it or if we
> +	 * are going suspend to idle (where firmware is not involved). If
> +	 * firmware is stopping the watchdog we kick it here one more time
> +	 * to give it some time.
> +	 */
> +	wdat->stopped = false;

Could the watchdog already be stopped here ? If so, what would be the purpose
and benefit of stopping it again ? And if it is already stopped, could there
be conditions where it would not restart in suspend because the stopped flag
is 0 ?

> +	if (acpi_target_system_state() == ACPI_STATE_S0 ||
> +	    !wdat->stopped_in_sleep) {
> +		ret = wdat_wdt_stop(&wdat->wdd);
> +		if (!ret)
> +			wdat->stopped = true;
> +	} else {
> +		ret = wdat_wdt_ping(&wdat->wdd);
> +	}
> +
> +	return ret;
> +}
> +
> +static int wdat_wdt_resume_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct wdat_wdt *wdat = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	if (!watchdog_active(&wdat->wdd))
> +		return 0;
> +
> +	if (!wdat->stopped) {
> +		/*
> +		 * Looks like the boot firmware reinitializes the watchdog
> +		 * before it hands off to the OS on resume from sleep so we
> +		 * stop and reprogram the watchdog here.

And the firmware reprograms it as it sees fit ? Brr ... :-(

> +		 */
> +		ret = wdat_wdt_stop(&wdat->wdd);
> +		if (ret)
> +			return ret;
> +
> +		ret = wdat_wdt_set_timeout(&wdat->wdd, wdat->wdd.timeout);
> +		if (ret)
> +			return ret;
> +
> +		ret = wdat_wdt_enable_reboot(wdat);
> +		if (ret)
> +			return ret;
> +
> +		ret = wdat_wdt_ping(&wdat->wdd);
> +		if (ret)
> +			return ret;

The watchdog is already running here. Why start it again ?

> +	}
> +
> +	return wdat_wdt_start(&wdat->wdd);
> +}
> +#endif
> +
> +static const struct dev_pm_ops wdat_wdt_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(wdat_wdt_suspend_noirq,
> +				      wdat_wdt_resume_noirq)
> +};
> +
> +static struct platform_driver wdat_wdt_driver = {
> +	.probe = wdat_wdt_probe,
> +	.remove = wdat_wdt_remove,
> +	.driver = {
> +		.name = "wdat_wdt",
> +		.pm = &wdat_wdt_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(wdat_wdt_driver);
> +
> +MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
> +MODULE_DESCRIPTION("ACPI Hardware Watchdog (WDAT) driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:wdat_wdt");
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c5eaf2f80a4c..8ff6ca4a2639 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1074,4 +1074,10 @@ void acpi_table_upgrade(void);
>  static inline void acpi_table_upgrade(void) { }
>  #endif
>
> +#if defined(CONFIG_ACPI) && defined(CONFIG_ACPI_WATCHDOG)
> +extern bool acpi_has_watchdog(void);
> +#else
> +static inline bool acpi_has_watchdog(void) { return false; }
> +#endif
> +
>  #endif	/*_LINUX_ACPI_H*/
>

