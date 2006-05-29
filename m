From: Andrew Morton <akpm@osdl.org>
Subject: Fw: Possible kernel memory leaks
Date: Mon, 29 May 2006 13:19:24 -0700
Message-ID: <20060529131924.172503d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:54757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751272AbWE2UPM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 May 2006 16:15:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@gmail.com>



Begin forwarded message:

Date: Sun, 28 May 2006 11:31:11 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Possible kernel memory leaks


Hi,

There are some possible kernel memory leaks discovered by kmemleak. I
didn't have time for investigating them. Please let me know if they are
not leaks so that I can improve kmemleak (or just add a false alarm call):

- acpi_evaluate_integer in drivers/acpi/utils.c - "element" is not freed
on the error path (if Coverity hasn't seen this, it was probably
confused by the return_* macros)

- acpi_ev_execute_reg_method in drivers/acpi/events/evregion.c - I'm not
sure about this but kmemleak reports an orphan pointer on the following
allocation path:
  c0159372: <kmem_cache_alloc>
  c01ffa07: <acpi_os_acquire_object>
  c0215b3a: <acpi_ut_allocate_object_desc_dbg>
  c02159ce: <acpi_ut_create_internal_object_dbg>
  c0203784: <acpi_ev_execute_reg_method>
  c0203db4: <acpi_ev_reg_run>
  c020ed17: <acpi_ns_walk_namespace>
  c0203d6b: <acpi_ev_execute_reg_methods>
Is acpi_ut_remove_reference actually removing the params[0/1]?

And some new false positives (kmemleak needs fixing):

- legacy_init_iomem_resources in arch/i386/kernel/setup.c - kmemleak is
probably right here in that "res" can never be freed since the pointer
was lost. However, there is no need to free this resource and that's why
I'll add a false alarm call

- there are a lot of false positives caused by module loading. I would
need to investigate these a bit more (it's missing a root memory block
that can lead to the reported pointers; it's also missing the static
variables in module)

Thanks,

Catalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
