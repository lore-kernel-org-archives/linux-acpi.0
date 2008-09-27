From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] ACPI: Add _PDC object evaluate for VIA.
Date: Sat, 27 Sep 2008 18:05:30 +0200
Message-ID: <20080927160530.GA27124@elte.hu>
References: <48DDF430.8060806@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:58980 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400AbYI0QFq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Sep 2008 12:05:46 -0400
Content-Disposition: inline
In-Reply-To: <48DDF430.8060806@viatech.com.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: louisqi <louisqi@viatech.com.cn>
Cc: len.brown@intel.com, venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org


just a few minor comments:

* louisqi <louisqi@viatech.com.cn> wrote:

> +static void init_via_pdc(struct acpi_processor *pr, struct cpuinfo_x86 *c)
> +{
> +	struct acpi_object_list *obj_list;
> +	union acpi_object *obj;
> +	u32 *buf;
> +
> +	/* allocate and initialize pdc. It will be used later. */
> +	obj_list = kmalloc(sizeof(struct acpi_object_list), GFP_KERNEL);
> +	if (!obj_list) {
> +		printk(KERN_ERR "Memory allocation error\n");
> +		return;
> +	}
> +
> +	obj = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
> +	if (!obj) {
> +		printk(KERN_ERR "Memory allocation error\n");
> +		kfree(obj_list);
> +		return;
> +	}
> +
> +	buf = kmalloc(12, GFP_KERNEL);
> +	if (!buf) {
> +		printk(KERN_ERR "Memory allocation error\n");
> +		kfree(obj);
> +		kfree(obj_list);
> +		return;
> +	}

error condition cleanliness: it's cleaner to create a single off-line 
instance of freeing logic, at the end of the function:

...
	[ ... normal path ... ]
	return;

err_obj:
	kfree(obj);
err_obj_list:
	kfree(obj_list);
err:
	printk(KERN_ERR "init_via_pdc: memory allocation error\n");
}

and then after the allocation do:

	if (!obj_list)
		goto err;

etc.

(also note the different style of the printk)

> +
> +	buf[0] = ACPI_PDC_REVISION_ID;
> +	buf[1] = 1;
> +	buf[2] = 0;
> +
> +	if (cpu_has(c, X86_FEATURE_EST))
> +		buf[2] |= ACPI_PDC_P_FFH;
> +
> +	if (cpu_has(c, X86_FEATURE_ACPI))
> +		buf[2] |= ACPI_PDC_T_FFH;
> +
> +	obj->type = ACPI_TYPE_BUFFER;
> +	obj->buffer.length = 12;
> +	obj->buffer.pointer = (u8 *) buf;

style: no need to put a space between the '(u8 *)' and 'buf'.

> +	return;
> +}

style: no need to put 'return' at the end of a void function.

	Ingo
