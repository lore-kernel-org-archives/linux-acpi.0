From: louisqi <louisqi@viatech.com.cn>
Subject: Re: [PATCH] ACPI: Add _PDC object evaluate for VIA.
Date: Sun, 28 Sep 2008 10:40:33 +0800
Message-ID: <48DEEEA1.1010605@viatech.com.cn>
References: <48DDF430.8060806@viatech.com.cn> <20080927160530.GA27124@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exchtp08.via.com.tw ([61.66.243.7]:23914 "EHLO
	exchtp08.via.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbYI1ClT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Sep 2008 22:41:19 -0400
In-Reply-To: <20080927160530.GA27124@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: len.brown@intel.com, venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org


Thanks a lot, Ingo! Thanks for your kindly help.

I have revise my patch as following:


////////////////////////////////////////////////////////////////////////////////////
[PATCH] ACPI: Add _PDC object evaluate for VIA.

Frome: Louis Qi <louisqi@viatech.com.cn>

The current routine "arch_acpi_processor_init_pdc" only supports INTEL CPUs.
This patch add support for VIA CPUs.

Signed-off-by: Louis Qi <louisqi@viatech.com.cn>
---

--- 2.6.26.5/arch/x86/kernel/acpi/processor.c.orig	2008-09-28 10:18:11.000000000 
+0800
+++ 2.6.26.5/arch/x86/kernel/acpi/processor.c	2008-09-28 10:18:11.000000000 +0800
@@ -66,6 +66,53 @@ static void init_intel_pdc(struct acpi_p
  	return;
  }

+static void init_via_pdc(struct acpi_processor *pr, struct cpuinfo_x86 *c)
+{
+	struct acpi_object_list *obj_list;
+	union acpi_object *obj;
+	u32 *buf;
+
+	/* allocate and initialize pdc. It will be used later. */
+	obj_list = kmalloc(sizeof(struct acpi_object_list), GFP_KERNEL);
+	if (!obj_list)
+		goto err_obj_list;
+
+	obj = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
+	if (!obj)
+		goto err_obj;
+
+	buf = kmalloc(12, GFP_KERNEL);
+	if (!buf)
+		goto err_buf;
+
+	buf[0] = ACPI_PDC_REVISION_ID;
+	buf[1] = 1;
+	buf[2] = 0;
+
+	if (cpu_has(c, X86_FEATURE_EST))
+		buf[2] |= ACPI_PDC_P_FFH;
+
+	if (cpu_has(c, X86_FEATURE_ACPI))
+		buf[2] |= ACPI_PDC_T_FFH;
+
+	obj->type = ACPI_TYPE_BUFFER;
+	obj->buffer.length = 12;
+	obj->buffer.pointer = (u8 *)buf;
+	obj_list->count = 1;
+	obj_list->pointer = obj;
+	pr->pdc = obj_list;
+
+	return;
+
+err_buf:
+	kfree(obj);
+err_obj:
+	kfree(obj_list);
+err_obj_list:
+	printk(KERN_ERR "init_via_pdc: memory allocation failed\n");
+}
+
+
  /* Initialize _PDC data based on the CPU vendor */
  void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
  {
@@ -74,6 +121,8 @@ void arch_acpi_processor_init_pdc(struct
  	pr->pdc = NULL;
  	if (c->x86_vendor == X86_VENDOR_INTEL)
  		init_intel_pdc(pr, c);
+	else if (c->x86_vendor == X86_VENDOR_CENTAUR)
+		init_via_pdc(pr, c);

  	return;
  }
////////////////////////////////////////////////////////////////////////////////////

Ingo Molnar :
> just a few minor comments:
> 
> * louisqi <louisqi@viatech.com.cn> wrote:
> 
>> +static void init_via_pdc(struct acpi_processor *pr, struct cpuinfo_x86 *c)
>> +{
>> +	struct acpi_object_list *obj_list;
>> +	union acpi_object *obj;
>> +	u32 *buf;
>> +
>> +	/* allocate and initialize pdc. It will be used later. */
>> +	obj_list = kmalloc(sizeof(struct acpi_object_list), GFP_KERNEL);
>> +	if (!obj_list) {
>> +		printk(KERN_ERR "Memory allocation error\n");
>> +		return;
>> +	}
>> +
>> +	obj = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
>> +	if (!obj) {
>> +		printk(KERN_ERR "Memory allocation error\n");
>> +		kfree(obj_list);
>> +		return;
>> +	}
>> +
>> +	buf = kmalloc(12, GFP_KERNEL);
>> +	if (!buf) {
>> +		printk(KERN_ERR "Memory allocation error\n");
>> +		kfree(obj);
>> +		kfree(obj_list);
>> +		return;
>> +	}
> 
> error condition cleanliness: it's cleaner to create a single off-line 
> instance of freeing logic, at the end of the function:
> 
> ...
> 	[ ... normal path ... ]
> 	return;
> 
> err_obj:
> 	kfree(obj);
> err_obj_list:
> 	kfree(obj_list);
> err:
> 	printk(KERN_ERR "init_via_pdc: memory allocation error\n");
> }
> 
> and then after the allocation do:
> 
> 	if (!obj_list)
> 		goto err;
> 
> etc.
> 
> (also note the different style of the printk)
> 
>> +
>> +	buf[0] = ACPI_PDC_REVISION_ID;
>> +	buf[1] = 1;
>> +	buf[2] = 0;
>> +
>> +	if (cpu_has(c, X86_FEATURE_EST))
>> +		buf[2] |= ACPI_PDC_P_FFH;
>> +
>> +	if (cpu_has(c, X86_FEATURE_ACPI))
>> +		buf[2] |= ACPI_PDC_T_FFH;
>> +
>> +	obj->type = ACPI_TYPE_BUFFER;
>> +	obj->buffer.length = 12;
>> +	obj->buffer.pointer = (u8 *) buf;
> 
> style: no need to put a space between the '(u8 *)' and 'buf'.
> 
>> +	return;
>> +}
> 
> style: no need to put 'return' at the end of a void function.
> 
> 	Ingo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
