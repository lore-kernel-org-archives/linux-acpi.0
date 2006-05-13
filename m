From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI_ALLOCATE and may sleep warning
Date: Sat, 13 May 2006 00:35:59 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F22F@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5784 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932114AbWEMEgC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 00:36:02 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Cc: linux-acpi@vger.kernel.org

>>Could we do something like this:
>>
>>#define ACPI_ALLOCATE(a)	kmalloc((a),
>(in_atomic())?GFP_ATOMIC:GFP_KERNEL)
>>#define ACPI_ALLOCATE_ZEROED(a)	kzalloc((a),
>(in_atomic())?GFP_ATOMIC:GFP_KERNEL)
>
>The question is if we allocate with interrupts off
>only on resume, or during normal operation.
>
>If it is only during resume, then I think we should
>be using the exact same mechanism that we use
>during boot, It must also apply to semaphores,
>not just kmalloc.

To clarify...

kernel/sched.c

void __might_sleep(...) {
   if (.... & (system_state == SYSTEM_RUNNING)...)
	printk(KERN_ERROR "BUG: sleeping in fuction called from invalid
context...
	...
	dump_stack
}

When we boot the system system_state == SYSTEM_BOOTING
allocations do not sleep, they succeed, and thus the sleep
check is disabled.

It is likely we should do the same thing, or an analogous thing,
on resume from suspend.

-Len
