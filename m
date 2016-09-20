From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/4] ACPI / watchdog: Add support for WDAT hardware
 watchdog
Date: Tue, 20 Sep 2016 07:48:53 -0700
Message-ID: <03ecb311-45ed-f8e2-1958-868de0ebb7b2@roeck-us.net>
References: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
 <20160920123054.195021-2-mika.westerberg@linux.intel.com>
 <26c6e893-4b57-c7d6-7ab3-16e4f3a8c946@roeck-us.net>
 <20160920135007.GR1811@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160920135007.GR1811@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Wim Van Sebroeck <wim@iguana.be>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 09/20/2016 06:50 AM, Mika Westerberg wrote:
> On Tue, Sep 20, 2016 at 06:37:23AM -0700, Guenter Roeck wrote:
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
>> I must be missing something here. What is happening with instr ?
>
> Instr contains the actual instruction from WDAT table. There can be
> many.
>
>>> +		instructions = wdat->instructions[action];
>
> This will be NULL first time so...
>
>>> +		if (!instructions) {
>>> +			instructions = devm_kzalloc(&pdev->dev,
>>> +					sizeof(*instructions), GFP_KERNEL);
>>> +			if (!instructions)
>>> +				return -ENOMEM;
>>> +
>>> +			INIT_LIST_HEAD(instructions);
>>> +			wdat->instructions[action] = instructions;
>>
>> ... and I don't really see how wdat->instructions[action] contains anything but
>> a zero filled array. Confused :-(.
>
> ...we allocate entry for that here. Next time it will not be NULL for
> that action.
>
>>
>>> +		}
>>> +
>>> +		list_add_tail(&instr->node, instructions);
>
> Then we append each instr to the list for this action.
>
> Hope this clarifies :)
>
Yes, I somehow didn't see that last line. Too early in the morning,
not enough coffee.

Thanks,
Guenter
