From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 00/13] Unify the interrupt delivery mode and do its
 setup in advance
Date: Mon, 28 Aug 2017 13:38:09 +0800
Message-ID: <0961a67c-3f88-deb5-2714-c65d097d6c10@cn.fujitsu.com>
References: <1503890438-27840-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503890438-27840-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc: mingo@kernel.org, hpa@zytor.com, bhe@redhat.com, rjw@rjwysocki.net, bp@alien8.de, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Follow Juergen's advice, +CC xen-devel and linux-acpi

In case a single patch of a series isn't stand alone it would be nice
to receive at least the cover letter of the series in order to know
what its all about.

Thanks,
	dou.

At 08/28/2017 11:20 AM, Dou Liyang wrote:
> Changes V7 --> V8:
>
>   - Change the order of [12/13] patch and [11/13]patch suggested by Rafael J. Wysocki.
>   - Fix some comments.
>   - Do more tests in Thinkpad x121e   -- Thanks for Borislav Petkov's help.
>
> [Background]
>
> MP specification defines three different interrupt delivery modes as follows:
>
>  1. PIC Mode
>  2. Virtual Wire Mode
>  3. Symmetric I/O Mode
>
> They will be setup in the different periods of booting time:
>  1. *PIC Mode*, the default interrupt delivery modes, will be set first.
>  2. *Virtual Wire Mode* will be setup during ISA IRQ initialization( step 1
>     in the figure.1).
>  3. *Symmetric I/O Mode*'s setup is related to the system
>     3.1 In SMP-capable system, setup during prepares CPUs(step 2)
>     3.2 In UP system, setup during initializes itself(step 3).
>
>
>  start_kernel
> +---------------+
> |
> +--> .......
> |
> |    setup_arch
> +--> +-------+
> |
> |    init_IRQ
> +-> +--+-----+
> |      |        init_ISA_irqs
> |      +------> +-+--------+
> |                 |         +----------------+
> +--->             +------>  | 1.init_bsp_APIC|
> |     .......               +----------------+
> +--->
> |     rest_init
> +--->---+-----+
> |       |   kernel_init
> |       +> ----+-----+
> |              |   kernel_init_freeable
> |              +->  ----+-------------+
> |                       |     smp_prepare_cpus
> |                       +---> +----+---------+
> |                       |          |   +-------------------+
> |                       |          +-> |2.  apic_bsp_setup |
> |                       |              +-------------------+
> |                       |
> v                       |     smp_init
>                         +---> +---+----+
>                                   |    +-------------------+
>                                   +--> |3.  apic_bsp_setup |
>                                        +-------------------+
>     figure.1 The flow chart of the kernel startup process
>
> [Problem]
>
> 1. Cause kernel in an unmatched mode at the beginning of booting time.
> 2. Cause the dump-capture kernel hangs with 'notsc' option inherited
>    from 1st kernel option.
> 3. Cause the code hard to read and maintain.
>
> As Ingo's and Eric's discusses[1,2], it need to be refactor.
>
> [Solution]
>
> 1. Construct a selector to unify these switches
>
>        +------------+
>        |disable_apic+--------------------+
>        +------------+       true         |
>               |false                     |
>               |                          |
>  +------------v------------------+       |
>  |!boot_cpu_has(X86_FEATURE_APIC)+-------+
>  +-------------------------------+  true |
>               |false                     |
>               |                          |
>       +-------v---------+                v
>       |!smp_found_config|            PIC MODE
>       +---------------+-+
>        |false         |true
>        |              |
>        v          +---v---------+
> SYMMETRIC IO MODE | !acpi_lapic |
>                   +------+------+
>                          |
>                          v
>                    VIRTUAL WIRE MODE
>
> 2. Unifying these setup steps of SMP-capable and UP system
>
>    start_kernel
> ---------------+
> |
> |
> |
> |    x86_late_time_init
> +---->---+------------+
> |        |
> |        |      +------------------------+
> |        +----> | 4. init_interrupt_mode |
> |               +------------------------+
> v
>
>
> 3. Execute the function as soon as possible.
>
> [Test]
>
> 1. In a theoretical code analysis, the patchset can wrap the original
> logic.
>
> 1) The original logic of the interrupt delivery mode setup：
>
> -Step O_1) Keep in PIC mode or virtual wire mode:
>
>   Check (smp_found_config || !boot_cpu_has(X86_FEATURE_APIC))
>     true:  PIC mode
>     false: virtual wire mode
>
> -Step O_2) Try to switch to symmetric IO mode:
>   O_2_1) In up system:
>
>     -Check disable_apic
>       ture: O_S_1 (original situation 1)
>     -Check whether there is a separate or integrated chip
>       don't has: O_S_2
>     -Check !smp_found_config
>       ture: O_S_3
>     -Others:
>       O_S_4
>
>   O_2_2) In smp-capable system:
>
>     -Check !smp_found_config && !acpi_lapic
>       true: goto O_2_1
>     -Check if it is LAPIC
>       don't has: O_S_5
>     -Check !max_cpus
>       true: O_S_6
>     -read_apic_id() != boot_cpu_physical_apicid
>       true: O_S_7
>     -Others:
>             O_S_8
>
> 2) After that patchset, the new logic:
>
> -Step N_1) Skip step O_1 and try to switch to the final interrupt mode
>    -Check disable_apic
>      ture: N_S_1 (New situation 1)
>    -Check whether there is a separate or integrated chip
>      ture: N_S_2
>    -Check if (!smp_found_config)
>      ture: N_S_3
>    -Check !setup_max_cpus
>      ture: N_S_4
>    -Check read_apic_id() != boot_cpu_physical_apicid
>      ture: N_S_5
>    -Others:
>            N_S_6
>
> O_S_1 is covered in N_S_1
> O_S_2 is covered in N_S_2
> O_S_3 is covered in N_S_3
> O_S_4 is covered in N_S_6
> O_S_5 is covered in N_S_2
> O_S_6 is covered in N_S_4
> O_S_7 is covered in N_S_5
> O_S_8 is covered in N_S_6
>
> 2. In the actual test, It also can work well in the situations of
> my test matrix
>
> The factors of test matrix:
>
>  X86  | SMP |LOCAL APIC|I/O APIC|UP_LATE_INIT|
> ----- |-----|----------|--------|------------|
> 32-bit|  Y  |     Y    |    Y   |     Y      |
> 64-bit|  N  |     N    |    N   |     N      |
> xen PV |
> xen HVM|
>
> disable_apic|X86_FEATURE_APIC|smp_found_config|
> ------------|----------------|----------------|
>       0     |        0       |        0       |
>       1     |        1       |        1       |
>
> acpi_lapic|acpi_ioapic|setup_max_cpus|
> ----------|-----------|--------------|
>      0    |     0     |      =0      |
>      1    |     1     |      >0      |
>
> [Link]
>
> [1]. https://lkml.org/lkml/2016/8/2/929
> [2]. https://lkml.org/lkml/2016/8/1/506
>
> For previous discussion, please refer to:
>   https://lkml.org/lkml/2017/5/10/323
>   https://www.spinics.net/lists/kernel/msg2491620.html
>   https://lkml.org/lkml/2017/3/29/481
>   https://lkml.org/lkml/2017/6/30/17
>   https://lkml.org/lkml/2017/7/3/269
>   https://lkml.org/lkml/2017/7/14/20
>
> Changes V6 --> V7:
>
>   - add a new patch: p12
>
> Changes V5 --> V6:
>
>   - change the check order for X86_32 in apic_intr_mode_select()
>   - replace the apic_printk with pr_info in apic_intr_mode_init()
>   - add a seperate helper function for get the logical apicid
>   - remove the extra argument upmode in apic_intr_mode_select()
>   - cleanup the logic of apic_intr_mode_init()
>   - replcae the 'ticks = jiffies' with 'end = jiffies + 4'
>   - rewrite the 9th and 10th patches's changelog
>
> Changes V4 --> V5:
>
>   - remove the RFC presix
>   - remove the 1/12 patch in V4
>   - merge 2 patches together for SMP-capable system
>   - replace the *_interrupt_* with *_intr_*
>   - replace the pr_info with apic_printk in apic_intr_mode_init()
>   - add a patch for PV xen to bypass intr_mode_init()
>
> Changes V3 --> V4:
>
>   - Move interrupt_mode_init to x86_init_ops instead of the use of
>     header files
>   - Replace "return" with "break" in case of APIC_SYMMETRIC_IO_NO_ROUTING
>   - Setup upmode earlier for UP system.
>   - Check interrupt mode before per cpu clock event setup.
>
> Changes V2 --> V3:
>
>   - Rebase the patches.
>   - Change two function name:
>       apic_bsp_mode_check --> apic_interrupt_mode_select
>       init_interrupt_mode --> apic_interrupt_mode_init
>   - Find a new waiting way to check whether timer IRQs work or not
>   - Refine the switch logic in apic_interrupt_mode_init()
>   - Consistently start sentences with upper case letters
>   - Fix some typos and comments
>   - Try my best to rewrite some changelog again
>
> Changes since V1:
>
>   - Move the initialization from init_IRQ() to x86_late_time_init()
>   - Use a threshold to refactor the check logic in timer_irq_works()
>   - Rename the framework to a selector
>   - Split two patches
>   - Consistently start sentences with upper case letters
>   - Fix some typos
>   - Rewrite the changelog
>
>
> Dou Liyang (13):
>   x86/apic: Construct a selector for the interrupt delivery mode
>   x86/apic: Prepare for unifying the interrupt delivery modes setup
>   x86/apic: Split local APIC timer setup from the APIC setup
>   x86/apic: Move logical APIC ID away from apic_bsp_setup()
>   x86/apic: Unify interrupt mode setup for SMP-capable system
>   x86/apic: Mark the apic_intr_mode extern for sanity check cleanup
>   x86/apic: Unify interrupt mode setup for UP system
>   x86/ioapic: Refactor the delay logic in timer_irq_works()
>   x86/init: add intr_mode_init to x86_init_ops
>   x86/xen: Bypass intr mode setup in enlighten_pv system
>   ACPI / init: Invoke early ACPI initialization earlier
>   x86/time: Initialize interrupt mode behind timer init
>   x86/apic: Remove the init_bsp_APIC()
>
>  arch/x86/include/asm/apic.h     |  15 +++-
>  arch/x86/include/asm/x86_init.h |   2 +
>  arch/x86/kernel/apic/apic.c     | 188 +++++++++++++++++++++-------------------
>  arch/x86/kernel/apic/io_apic.c  |  45 +++++++++-
>  arch/x86/kernel/irqinit.c       |   3 -
>  arch/x86/kernel/smpboot.c       |  80 +++++------------
>  arch/x86/kernel/time.c          |   5 ++
>  arch/x86/kernel/x86_init.c      |   1 +
>  arch/x86/xen/enlighten_pv.c     |   1 +
>  init/main.c                     |   2 +-
>  10 files changed, 186 insertions(+), 156 deletions(-)
>
