From: John Keller <jpk@sgi.com>
Subject: acpi_bus_register_driver() and latest acpi trees
Date: Wed, 31 Jan 2007 10:11:11 -0600 (CST)
Message-ID: <200701311611.l0VGBCwY395506@fcbayern.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:49410 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030219AbXAaQLW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Jan 2007 11:11:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, ayoung@sgi.com

Len,
  When building kernels from your ACPI release or test trees,
as well as the -mm tree, SN Altix boots are crashing in the
kobject code when calling acpi_bus_register_driver().
The crash is because kset->list has not been initialized yet.

 kobject_add()
  list_add_tail(&kobj->entry,&kobj->kset->list);


Is there now a restriction on how early acpi_bus_register_driver()
can be called? If so, at what point in time can calls be made,
and is it still possible to register a driver early enough such
that it will be called at device discovery time vs registration time?

Thanks,
John


-------------------

BUG: at lib/kref.c:34 kref_get()

Call Trace: 
 [<a000000100012b80>] show_stack+0x40/0xa0
                                sp=e00000b0037f7ab0 bsp=e00000b0037f0e68
 [<a000000100012c10>] dump_stack+0x30/0x60
                                sp=e00000b0037f7c80 bsp=e00000b0037f0e50
 [<a0000001004196c0>] kref_get+0xa0/0xe0
                                sp=e00000b0037f7c80 bsp=e00000b0037f0e30
 [<a0000001004173b0>] kobject_get+0x30/0x60
                                sp=e00000b0037f7c80 bsp=e00000b0037f0e10
 [<a0000001005070d0>] get_bus+0x30/0x80
                                sp=e00000b0037f7c80 bsp=e00000b0037f0de8
 [<a000000100507f30>] bus_add_driver+0x30/0x3a0
                                sp=e00000b0037f7c80 bsp=e00000b0037f0db0
 [<a000000100509c20>] driver_register+0x160/0x180 
                                sp=e00000b0037f7c80 bsp=e00000b0037f0d90
 [<a0000001004a00b0>] acpi_bus_register_driver+0x50/0x80
                                sp=e00000b0037f7c80 bsp=e00000b0037f0d70
 [<a0000001009afbc0>] sn_io_acpi_init+0x80/0x240
                                sp=e00000b0037f7c80 bsp=e00000b0037f0d50
 [<a0000001009aff80>] sn_io_early_init+0x200/0x240
                                sp=e00000b0037f7d20 bsp=e00000b0037f0d38
 [<a000000100009720>] init+0x420/0x840
                                sp=e00000b0037f7d30 bsp=e00000b0037f0d08
 [<a0000001000110f0>] kernel_thread_helper+0xd0/0x100
                                sp=e00000b0037f7e30 bsp=e00000b0037f0ce0
 [<a000000100009140>] start_kernel_thread+0x20/0x40
                                sp=e00000b0037f7e30 bsp=e00000b0037f0ce0
JPK:kref_get: refcount = 0, kref=0xa000000100d6d7bc
BUG: at lib/kref.c:34 kref_get()

Unable to handle kernel NULL pointer dereference (address 0000000000000000)
swapper[1]: Oops 8804682956800 [1]
Modules linked in:

Pid: 1, CPU 1, comm:              swapper
psr : 00001010085a6010 ifs : 800000000000040c ip  : [<a0000001004179d0>]    Not tainted
ip is at kobject_add+0x370/0x640
unat: 0000000000000000 pfs : 000000000000040c rsc : 0000000000000003
rnat: 000000000000030e bsps: 0000000000000000 pr  : 0000000000006681
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a000000100417980 b6  : e0000030025ee6a0 b7  : a0000001004f69e0
f6  : 000000000000000000000 f7  : 1003e20c49ba5e353f7cf
f8  : 1003e00000000000000c8 f9  : 10006c7fffffffd73ea5c
f10 : 0fffe9ffffffff6000000 f11 : 1003e0000000000000000
r1  : a000000100f8e5c0 r2  : e00000b0037f0ca8 r3  : 0000000000000003
r8  : 000000000000005e r9  : 0000000000004000 r10 : a000000100da9d18
r11 : a000000100da9d28 r12 : e00000b0037f7c80 r13 : e00000b0037f0000
r14 : 0000000000000002 r15 : e00000b0037f0c90 r16 : e00000b0037f0ca8
r17 : a000000100da9d48 r18 : e00000b0037f7b31 r19 : e00000b0037f7c10
r20 : 0000000000004000 r21 : 0000000000004000 r22 : a000000100da9d10
r23 : a000000100d998d0 r24 : a000000100cafaa0 r25 : a000000100cafaa0
r26 : e00000b0037f0c90 r27 : 0000000000000000 r28 : a000000100d6d790
r29 : a000000100d6d788 r30 : a000000100d6d778 r31 : a000000100da5338

Call Trace:
 [<a000000100012b80>] show_stack+0x40/0xa0
                                sp=e00000b0037f7830 bsp=e00000b0037f0f68
 [<a000000100013480>] show_regs+0x840/0x880
                                sp=e00000b0037f7a00 bsp=e00000b0037f0f10
 [<a000000100034e70>] die+0x250/0x340
                                sp=e00000b0037f7a00 bsp=e00000b0037f0ec8
 [<a000000100059350>] ia64_do_page_fault+0x930/0xa60
                                sp=e00000b0037f7a20 bsp=e00000b0037f0e78
 [<a00000010000bb60>] ia64_leave_kernel+0x0/0x290
                                sp=e00000b0037f7ab0 bsp=e00000b0037f0e78
 [<a0000001004179d0>] kobject_add+0x370/0x640
                                sp=e00000b0037f7c80 bsp=e00000b0037f0e18
 [<a000000100418050>] kobject_register+0x90/0xe0
                                sp=e00000b0037f7c80 bsp=e00000b0037f0de8    
 [<a000000100507fa0>] bus_add_driver+0xa0/0x3a0
                                sp=e00000b0037f7c80 bsp=e00000b0037f0db0
 [<a000000100509c20>] driver_register+0x160/0x180 
                                sp=e00000b0037f7c80 bsp=e00000b0037f0d90
 [<a0000001004a00b0>] acpi_bus_register_driver+0x50/0x80
                                sp=e00000b0037f7c80 bsp=e00000b0037f0d70
 [<a0000001009afbc0>] sn_io_acpi_init+0x80/0x240
                                sp=e00000b0037f7c80 bsp=e00000b0037f0d50
 [<a0000001009aff80>] sn_io_early_init+0x200/0x240
                                sp=e00000b0037f7d20 bsp=e00000b0037f0d38
 [<a000000100009720>] init+0x420/0x840
                                sp=e00000b0037f7d30 bsp=e00000b0037f0d08
 [<a0000001000110f0>] kernel_thread_helper+0xd0/0x100
                                sp=e00000b0037f7e30 bsp=e00000b0037f0ce0
 [<a000000100009140>] start_kernel_thread+0x20/0x40 
                                sp=e00000b0037f7e30 bsp=e00000b0037f0ce0

