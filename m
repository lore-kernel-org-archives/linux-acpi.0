From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v9 00/12] Unify the interrupt delivery mode and do its setup in advance
Date: Wed, 13 Sep 2017 17:12:43 +0800
Message-ID: <1505293975-26005-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7446 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751447AbdIMJOK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Sep 2017 05:14:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, yinghai@kernel.org, bhe@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>

Changes V8 --> V9:
  No functionality change, update and modify the comments.

  - [01/12] patch: modify the comments of apic_intr_mode_select().
       Currently, the check logic of BIOS is based on the original code,
    Baoquan and I have discussed it in V8 for readability, I am not sure
    that I can clean up it correctly, So keep it like before.

  - [06/12] patch: update the comments of init_apic_mappings()

  - [11/12] patch: update the comments of native_smp_prepare_cpus().

  - Post the patch putting acpi_early_init() earlier independently
    suggested by Rafael and Baoquan.

  - Rebase it

[Background]

MP specification defines three different interrupt delivery modes as follows:

 1. PIC Mode
 2. Virtual Wire Mode
 3. Symmetric I/O Mode

They will be setup in the different periods of booting time:
 1. *PIC Mode*, the default interrupt delivery modes, will be set first.
 2. *Virtual Wire Mode* will be setup during ISA IRQ initialization( step 1
    in the figure.1).
 3. *Symmetric I/O Mode*'s setup is related to the system
    3.1 In SMP-capable system, setup during prepares CPUs(step 2) 
    3.2 In UP system, setup during initializes itself(step 3).


 start_kernel
+---------------+
|
+--> .......
|
|    setup_arch
+--> +-------+
|
|    init_IRQ
+-> +--+-----+
|      |        init_ISA_irqs
|      +------> +-+--------+
|                 |         +----------------+
+--->             +------>  | 1.init_bsp_APIC|
|     .......               +----------------+
+--->
|     rest_init
+--->---+-----+
|       |   kernel_init
|       +> ----+-----+
|              |   kernel_init_freeable
|              +->  ----+-------------+
|                       |     smp_prepare_cpus
|                       +---> +----+---------+
|                       |          |   +-------------------+
|                       |          +-> |2.  apic_bsp_setup |
|                       |              +-------------------+
|                       |
v                       |     smp_init
                        +---> +---+----+
                                  |    +-------------------+
                                  +--> |3.  apic_bsp_setup |
                                       +-------------------+
    figure.1 The flow chart of the kernel startup process

[Problem]

1. Cause kernel in an unmatched mode at the beginning of booting time.
2. Cause the dump-capture kernel hangs with 'notsc' option inherited
   from 1st kernel option.
3. Cause the code hard to read and maintain.

As Ingo's and Eric's discusses[1,2], it need to be refactor.

[Solution]

1. Construct a selector to unify these switches

       +------------+
       |disable_apic+--------------------+
       +------------+       true         |
              |false                     |
              |                          |
 +------------v------------------+       |
 |!boot_cpu_has(X86_FEATURE_APIC)+-------+
 +-------------------------------+  true |
              |false                     |
              |                          |
      +-------v---------+                v
      |!smp_found_config|            PIC MODE
      +---------------+-+
       |false         |true
       |              |
       v          +---v---------+
SYMMETRIC IO MODE | !acpi_lapic |
                  +------+------+
                         |
                         v
                   VIRTUAL WIRE MODE 

2. Unifying these setup steps of SMP-capable and UP system

   start_kernel
---------------+
|
|
|
|    x86_late_time_init
+---->---+------------+
|        |
|        |      +------------------------+
|        +----> | 4. init_interrupt_mode |
|               +------------------------+
v


3. Execute the function as soon as possible.

[Link]

[1]. https://lkml.org/lkml/2016/8/2/929
[2]. https://lkml.org/lkml/2016/8/1/506

[History patches]
For previous discussion, please refer to:

  V8:  https://lkml.org/lkml/2017/8/27/265
  V7:  https://lkml.org/lkml/2017/7/14/20
  V6:  https://lkml.org/lkml/2017/7/3/269
  V5:  https://lkml.org/lkml/2017/6/30/17
  V3:  https://lkml.org/lkml/2017/5/10/323
  V2:  https://www.spinics.net/lists/kernel/msg2491620.html
  V1:  https://lkml.org/lkml/2017/3/29/481


Changes V7 --> V8:

  - Change the order of [12/13] patch and [11/13]patch suggested by Rafael J. Wysocki.
  - Fix some comments.
  - Do more tests in Thinkpad x121e   -- Thanks for Borislav Petkov's help.

Changes V6 --> V7:

  - add a new patch: p12

Changes V5 --> V6:

  - change the check order for X86_32 in apic_intr_mode_select()
  - replace the apic_printk with pr_info in apic_intr_mode_init()
  - add a separate helper function for get the logical apicid
  - remove the extra argument upmode in apic_intr_mode_select()
  - cleanup the logic of apic_intr_mode_init()
  - replcae the 'ticks = jiffies' with 'end = jiffies + 4'
  - rewrite the 9th and 10th patches's changelog

Changes V4 --> V5:

  - remove the RFC presix
  - remove the 1/12 patch in V4
  - merge 2 patches together for SMP-capable system
  - replace the *_interrupt_* with *_intr_*
  - replace the pr_info with apic_printk in apic_intr_mode_init()
  - add a patch for PV xen to bypass intr_mode_init()

Changes V3 --> V4:

  - Move interrupt_mode_init to x86_init_ops instead of the use of
    header files
  - Replace "return" with "break" in case of APIC_SYMMETRIC_IO_NO_ROUTING
  - Setup upmode earlier for UP system.
  - Check interrupt mode before per cpu clock event setup.

Changes V2 --> V3:

  - Rebase the patches.
  - Change two function name:
      apic_bsp_mode_check --> apic_interrupt_mode_select
      init_interrupt_mode --> apic_interrupt_mode_init
  - Find a new waiting way to check whether timer IRQs work or not
  - Refine the switch logic in apic_interrupt_mode_init()
  - Consistently start sentences with upper case letters
  - Fix some typos and comments
  - Try my best to rewrite some changelog again

Changes since V1: 

  - Move the initialization from init_IRQ() to x86_late_time_init()
  - Use a threshold to refactor the check logic in timer_irq_works()
  - Rename the framework to a selector
  - Split two patches
  - Consistently start sentences with upper case letters
  - Fix some typos
  - Rewrite the changelog

Cc: xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-acpi@vger.kernel.org
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Zheng, Lv <lv.zheng@intel.com>

Dou Liyang (12):
  x86/apic: Construct a selector for the interrupt delivery mode
  x86/apic: Prepare for unifying the interrupt delivery modes setup
  x86/apic: Split local APIC timer setup from the APIC setup
  x86/apic: Move logical APIC ID away from apic_bsp_setup()
  x86/apic: Unify interrupt mode setup for SMP-capable system
  x86/apic: Mark the apic_intr_mode extern for sanity check cleanup
  x86/apic: Unify interrupt mode setup for UP system
  x86/ioapic: Refactor the delay logic in timer_irq_works()
  x86/init: add intr_mode_init to x86_init_ops
  x86/xen: Bypass intr mode setup in enlighten_pv system
  x86/time: Initialize interrupt mode behind timer init
  x86/apic: Remove the init_bsp_APIC()

 arch/x86/include/asm/apic.h     |  15 +++-
 arch/x86/include/asm/x86_init.h |   2 +
 arch/x86/kernel/apic/apic.c     | 188 ++++++++++++++++++++--------------------
 arch/x86/kernel/apic/io_apic.c  |  45 +++++++++-
 arch/x86/kernel/irqinit.c       |   3 -
 arch/x86/kernel/smpboot.c       |  85 ++++++------------
 arch/x86/kernel/time.c          |   5 ++
 arch/x86/kernel/x86_init.c      |   1 +
 arch/x86/xen/enlighten_pv.c     |   1 +
 9 files changed, 184 insertions(+), 161 deletions(-)

-- 
2.5.5



