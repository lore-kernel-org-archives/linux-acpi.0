From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] ACPI / watchdog: Add support for WDAT hardware
 watchdog
Date: Wed, 14 Sep 2016 07:54:34 -0700
Message-ID: <dce4b919-a861-ca05-47e0-71d743f9a017@roeck-us.net>
References: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
 <20160913152336.75405-2-mika.westerberg@linux.intel.com>
 <af61227f-926a-f89d-1e39-381527fd6613@roeck-us.net>
 <20160914080615.GU1811@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59678 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761961AbcINOyr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2016 10:54:47 -0400
In-Reply-To: <20160914080615.GU1811@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Wim Van Sebroeck <wim@iguana.be>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/14/2016 01:06 AM, Mika Westerberg wrote:
> On Tue, Sep 13, 2016 at 02:00:25PM -0700, Guenter Roeck wrote:
>> On 09/13/2016 08:23 AM, Mika Westerberg wrote:
>>> Starting from Intel Skylake the iTCO watchdog timer registers were moved to
>>> reside in the same register space with SMBus host controller.  Not all
>>> needed registers are available though and we need to unhide P2SB (Primary
>>> to Sideband) device briefly to be able to read status of required NO_REBOOT
>>> bit. The i2c-i801.c SMBus driver used to handle this and creation of the
>>> iTCO watchdog platform device.
>>>
>>> Windows, on the other hand, does not use the iTCO watchdog hardware
>>> directly even if it is available. Instead it relies on ACPI Watchdog Action
>>> Table (WDAT) table to describe the watchdog hardware to the OS. This table
>>> contains necessary information about the the hardware and also set of
>>> actions which are executed by a driver as needed.
>>>
>>> This patch implements a new watchdog driver that takes advantage of the
>>> ACPI WDAT table. We split the functionality into two parts: first part
>>> enumerates the WDAT table and if found, populates resources and creates
>>> platform device for the actual driver. The second part is the driver
>>> itself.
>>>
>>> The reason for the split is that this way we can make the driver itself to
>>> be a module and loaded automatically if the WDAT table is found. Otherwise
>>> the module is not loaded.
>>>
>> What I don't really like is that the driver won't be in the watchdog directory,
>> and will thus easily be overlooked in the future by watchdog maintainers.
>
> It is in ACPI directory because we expose the functionality to users as
> "ACPI Watchdog Action Table (WDAT)" which works with other similar table
> options in drivers/acpi/Kconfig.
>
> I'm fine moving the driver itself (wdat_wdt.c) under drivers/watchdog
> but at least the enumeration part should be part of drivers/acpi and I
> would still like to have only one user selectable option.
>

SGTM, but up to you and Wim to decide, really.

>>> +	wdat->wdd.max_timeout = wdat->period * tbl->max_count / 1000;
>>> +	wdat->wdd.min_timeout = wdat->period * tbl->min_count / 1000;
>>
>> Are those guaranteed to be correct, ie max_timeout >= min_timeout
>> and both valid ?
>
> The WDAT spec says nothing about those. I'll add sanity check here and
> return -EINVAL if the values cannot be used. While there I think I can
> do the same for tbl->timer_period, just in case.
>
Using max_hw_heartbeat_ms would help a bit here. Then the actual timeout
is not limited by the hardware maximum, and the watchdog core will ping
the watchdog if the selected timeout is larger than the maximum hardware
timeout.

Not sure how well the core would handle a maximum timeout of 1ms, though,
so some basic sanity checking might still make sense.

>> Reason for asking is that the core will accept any timeouts if, for
>> example, max_timeout is 0.
>>
>>> +	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
>>> +	wdat->wdd.info = &wdat_wdt_info;
>>> +	wdat->wdd.ops = &wdat_wdt_ops;
>>> +	wdat->pdev = pdev;
>>> +
>>> +	/* Request and map all resources */
>>> +	for (i = 0; i < pdev->num_resources; i++) {
>>> +		void __iomem *reg;
>>> +
>>> +		res = &pdev->resource[i];
>>> +		if (resource_type(res) == IORESOURCE_MEM) {
>>> +			reg = devm_ioremap_resource(&pdev->dev, res);
>>> +		} else if (resource_type(res) == IORESOURCE_IO) {
>>> +			reg = devm_ioport_map(&pdev->dev, res->start, 1);
>>> +		} else {
>>> +			dev_err(&pdev->dev, "Unsupported resource\n");
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		if (!reg)
>>> +			return -ENOMEM;
>>> +
>>> +		regs[i] = reg;
>>> +	}
>>> +
>>> +	entries = (struct acpi_wdat_entry *)(tbl + 1);
>>> +	for (i = 0; i < tbl->entries; i++) {
>>> +		const struct acpi_generic_address *gas;
>>> +		struct wdat_instruction *instr;
>>> +		struct list_head *instructions;
>>> +		unsigned int action;
>>> +		struct resource r;
>>> +		int j;
>>> +
>>> +		action = entries[i].action;
>>> +		if (action >= MAX_WDAT_ACTIONS) {
>>> +			dev_dbg(&pdev->dev, "Skipping unknown action: %u\n",
>>> +				action);
>>> +			continue;
>>> +		}
>>> +
>>> +		instr = devm_kzalloc(&pdev->dev, sizeof(*instr), GFP_KERNEL);
>>> +		if (!instr)
>>> +			return -ENOMEM;
>>> +
>>> +		INIT_LIST_HEAD(&instr->node);
>>> +		instr->entry = entries[i];
>>> +
>>> +		gas = &entries[i].register_region;
>>> +
>>> +		memset(&r, 0, sizeof(r));
>>> +		r.start = gas->address;
>>> +		r.end = r.start + gas->access_width;
>>> +		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>>> +			r.flags = IORESOURCE_MEM;
>>> +		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>>> +			r.flags = IORESOURCE_IO;
>>> +		} else {
>>> +			dev_dbg(&pdev->dev, "Unsupported address space: %d\n",
>>> +				gas->space_id);
>>> +			continue;
>>> +		}
>>> +
>>> +		/* Find the matching resource */
>>> +		for (j = 0; j < pdev->num_resources; j++) {
>>> +			res = &pdev->resource[j];
>>> +			if (resource_contains(res, &r)) {
>>> +				instr->reg = regs[j] + r.start - res->start;
>>> +				break;
>>> +			}
>>> +		}
>>> +
>>> +		if (!instr->reg) {
>>> +			dev_err(&pdev->dev, "I/O resource not found\n");
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		instructions = wdat->instructions[action];
>>> +		if (!instructions) {
>>> +			instructions = devm_kzalloc(&pdev->dev,
>>> +					sizeof(*instructions), GFP_KERNEL);
>>> +			if (!instructions)
>>> +				return -ENOMEM;
>>> +
>>> +			INIT_LIST_HEAD(instructions);
>>> +			wdat->instructions[action] = instructions;
>>> +		}
>>> +
>>> +		list_add_tail(&instr->node, instructions);
>>> +	}
>>> +
>>> +	/* Make sure it is stopped now */
>>> +	ret = wdat_wdt_stop(&wdat->wdd);
>>
>> Why ? You could set max_hw_heartbeat_ms instead of max_timeout and
>> inform the watchdog core that the watchdog is running (by setting
>> the WDOG_HW_RUNNING status flag).
>
> Hmm is the watchdog core then kicking it?
>
> It is stopped here to make sure system does not reboot until userspace
> explicitly opens the device and starts kicking the watchdog.
>

Yes, that functionality was recently added to the watchdog core.

>
>>> +		 */
>>> +		ret = wdat_wdt_stop(&wdat->wdd);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		ret = wdat_wdt_set_timeout(&wdat->wdd, wdat->wdd.timeout);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		ret = wdat_wdt_enable_reboot(wdat);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		ret = wdat_wdt_ping(&wdat->wdd);
>>> +		if (ret)
>>> +			return ret;
>>
>> The watchdog is already running here. Why start it again ?
>
> No it's not. We stopped it few lines above before we reprogram it.
>
But you start it below, don't you ? And it is stopped here, so why ping it ?

If it is necessary to ping the watchdog before starting it,
maybe the start code should do it ?

Thanks,
Guenter



