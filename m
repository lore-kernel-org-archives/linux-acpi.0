From: Myron Stowe <mstowe@redhat.com>
Subject: kernel oops and panic in acpi_atomic_read under 2.6.32
Date: Mon, 05 Mar 2012 17:19:25 -0700
Message-ID: <1330993165.2411.64.camel@zim.stowe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758054Ab2CFATs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Mar 2012 19:19:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "ying.huang" <ying.huang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Huang Ying, all:

We have a customer getting a kernel oops/panic that looks exactly what
was reported in https://lkml.org/lkml/2011/8/17/352 - the address in
question, which corresponds to ACPI's APEI error_status_address, is even
the same: 0xbf7b5ff0 (before he started instrumenting his kernel).  The
OS is RHEL6.2.

The scenario is similar to the previously reported issue also: After n
days of testing, the system seems to encounter an error which triggers
APEI's platform driver which in turn oops/panics.

The kernel was instrumented with the patch presented in
https://lkml.org/lkml/2011/9/4/123 and the following is seen:

2012-02-27 07:56:03 Kernel panic - not syncing: ACPI atomic read mem:
addr 0xbf7b5ff0 is not mapped!
2012-02-27 07:56:03
2012-02-27 07:56:03 Pid: 0, comm: swapper Not tainted
2.6.32-220.4.2.1chaos.ch5.x86_64 #1
2012-02-27 07:56:03 Call Trace:
2012-02-27 07:56:03  <NMI>  [<ffffffff814ee06c>] ? panic+0x78/0x143
2012-02-27 07:56:03  [<ffffffff812c8163>] ? acpi_atomic_read+0xa7/0xfe
2012-02-27 07:56:03  [<ffffffff812f86aa>] ? ghes_read_estatus+0x4a/0x170
2012-02-27 07:56:03  [<ffffffff812f8aa1>] ? ghes_notify_nmi+0xc1/0x180
2012-02-27 07:56:03  [<ffffffff814f4265>] ? notifier_call_chain+0x55/0x80
2012-02-27 07:56:03  [<ffffffff814f42ca>] ?
atomic_notifier_call_chain+0x1a/0x20
2012-02-27 07:56:03  [<ffffffff81096dbe>] ? notify_die+0x2e/0x30
2012-02-27 07:56:03  [<ffffffff814f1f11>] ? do_nmi+0x1a1/0x2b0
2012-02-27 07:56:03  [<ffffffff814f17f0>] ? nmi+0x20/0x30
2012-02-27 07:56:03  [<ffffffff8103772a>] ? native_write_msr_safe+0xa/0x10
2012-02-27 07:56:03  <<EOE>>  <IRQ>  [<ffffffff8101af1f>] ?
intel_pmu_disable_all+0x3f/0x110
2012-02-27 07:56:03  [<ffffffff8101a942>] ? x86_pmu_disable+0x52/0x60
2012-02-27 07:56:03  [<ffffffff8110532b>] ? perf_pmu_disable+0x2b/0x40
2012-02-27 07:56:03  [<ffffffff8110ae15>] ? perf_event_task_tick+0x2a5/0x2f0
2012-02-27 07:56:03  [<ffffffff8105689c>] ? scheduler_tick+0xcc/0x260
2012-02-27 07:56:03  [<ffffffff810a0d60>] ? tick_sched_timer+0x0/0xc0
2012-02-27 07:56:03  [<ffffffff8107c512>] ? update_process_times+0x52/0x70
2012-02-27 07:56:03  [<ffffffff810a0dc6>] ? tick_sched_timer+0x66/0xc0
2012-02-27 07:56:03  [<ffffffff8109555e>] ? __run_hrtimer+0x8e/0x1a0
2012-02-27 07:56:03  [<ffffffff81012b59>] ? read_tsc+0x9/0x20
2012-02-27 07:56:03  [<ffffffff81095906>] ? hrtimer_interrupt+0xe6/0x250
2012-02-27 07:56:03  [<ffffffff814f6b1b>] ? smp_apic_timer_interrupt+0x6b/0x9b
2012-02-27 07:56:03  [<ffffffff8100bc13>] ? apic_timer_interrupt+0x13/0x20
2012-02-27 07:56:03  <EOI>  [<ffffffff812c66fe>] ? intel_idle+0xde/0x170
2012-02-27 07:56:03  [<ffffffff812c66e1>] ? intel_idle+0xc1/0x170
2012-02-27 07:56:03  [<ffffffff813fbc47>] ? cpuidle_idle_call+0xa7/0x140
2012-02-27 07:56:03  [<ffffffff81009e06>] ? cpu_idle+0xb6/0x110
2012-02-27 07:56:03  [<ffffffff814e7c6e>] ? start_secondary+0x202/0x245
2012-02-27 07:56:04 Initializing cgroup subsys cpuset
2012-02-27 07:56:04 Initializing cgroup subsys cpu

--- and ---

2012-03-02 05:19:42 GHES: gar accessed: 0, 0xbf7b5ff0
2012-03-02 05:19:42 Kernel panic - not syncing: ACPI atomic read mem: addr
0xbf7b5ff0 is not mapped!
2012-03-02 05:19:42
2012-03-02 05:19:42 Pid: 0, comm: swapper Not tainted
2.6.32-220.4.2.1chaos.ch5.x86_64 #1
2012-03-02 05:19:42 Call Trace:
2012-03-02 05:19:42  <NMI>  [<ffffffff814ee06c>] ? panic+0x78/0x143
2012-03-02 05:19:42  [<ffffffff812c8163>] ? acpi_atomic_read+0xa7/0xfe
2012-03-02 05:19:42  [<ffffffff812f86aa>] ? ghes_read_estatus+0x4a/0x170
2012-03-02 05:19:42  [<ffffffff812f8aa1>] ? ghes_notify_nmi+0xc1/0x180
2012-03-02 05:19:42  [<ffffffff814f4265>] ? notifier_call_chain+0x55/0x80
2012-03-02 05:19:42  [<ffffffff814f42ca>] ?
atomic_notifier_call_chain+0x1a/0x20
2012-03-02 05:19:42  [<ffffffff81096dbe>] ? notify_die+0x2e/0x30
2012-03-02 05:19:42  [<ffffffff814f1f11>] ? do_nmi+0x1a1/0x2b0
2012-03-02 05:19:42  [<ffffffff814f17f0>] ? nmi+0x20/0x30
2012-03-02 05:19:42  [<ffffffff8103772a>] ? native_write_msr_safe+0xa/0x10
2012-03-02 05:19:42  <<EOE>>  <IRQ>  [<ffffffff8101af1f>] ?
intel_pmu_disable_all+0x3f/0x110
2012-03-02 05:19:42  [<ffffffff8101a942>] ? x86_pmu_disable+0x52/0x60
2012-03-02 05:19:42  [<ffffffff8110532b>] ? perf_pmu_disable+0x2b/0x40
2012-03-02 05:19:42  [<ffffffff8110ae15>] ? perf_event_task_tick+0x2a5/0x2f0
2012-03-02 05:19:42  [<ffffffff8105689c>] ? scheduler_tick+0xcc/0x260
2012-03-02 05:19:42  [<ffffffff810a0d60>] ? tick_sched_timer+0x0/0xc0
2012-03-02 05:19:42  [<ffffffff8107c512>] ? update_process_times+0x52/0x70
2012-03-02 05:19:42  [<ffffffff810a0dc6>] ? tick_sched_timer+0x66/0xc0
2012-03-02 05:19:42  [<ffffffff8109555e>] ? __run_hrtimer+0x8e/0x1a0
2012-03-02 05:19:42  [<ffffffff81012b59>] ? read_tsc+0x9/0x20
2012-03-02 05:19:42  [<ffffffff81095906>] ? hrtimer_interrupt+0xe6/0x250
2012-03-02 05:19:42  [<ffffffff814f6b1b>] ? smp_apic_timer_interrupt+0x6b/0x9b
2012-03-02 05:19:42  [<ffffffff8100bc13>] ? apic_timer_interrupt+0x13/0x20
2012-03-02 05:19:42  <EOI>  [<ffffffff813fba61>] ? poll_idle+0x41/0x80
2012-03-02 05:19:42  [<ffffffff813fba33>] ? poll_idle+0x13/0x80
2012-03-02 05:19:42  [<ffffffff813fcd79>] ? menu_select+0x139/0x350
2012-03-02 05:19:42  [<ffffffff813fbc47>] ? cpuidle_idle_call+0xa7/0x140
2012-03-02 05:19:42  [<ffffffff81009e06>] ? cpu_idle+0xb6/0x110
2012-03-02 05:19:42  [<ffffffff814e7c6e>] ? start_secondary+0x202/0x245
2012-03-02 05:19:42 Initializing cgroup subsys cpuset
2012-03-02 05:19:42 Initializing cgroup subsys cpu
2012-03-02 05:19:42 Linux version 2.6.32-220.4.2.1chaos.ch5.x86_64
(mockbuild@builder1) (gcc version 4.4.5 20110214
(Red Hat 4.4.5-6) (GCC) ) #1 SMP Fri Feb 17 10:21:35 PST 2012


Pulling out what I believe are the pertinent parts from dmesg -

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.32-220.4.2.1chaos.ch5.x86_64 (mockbuild@builder1) (gcc
version 4.4.5 20110214 (Red Hat 4.4.5-6) (GCC) ) #1 SMP Fri Feb 17 10:21:35 PST
2012
Command line: initrd=initramfs console=tty0 console=ttyS0,115200n8
crashkernel=256M BOOT_IMAGE=vmlinuz BOOTIF=01-00-25-90-09-3b-44 
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099800 (usable)
 BIOS-e820: 0000000000099800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bf780000 (usable)
 BIOS-e820: 00000000bf78e000 - 00000000bf790000 type 9
 BIOS-e820: 00000000bf790000 - 00000000bf79e000 (ACPI data)
 BIOS-e820: 00000000bf79e000 - 00000000bf7d0000 (ACPI NVS)
 BIOS-e820: 00000000bf7d0000 - 00000000bf7e0000 (reserved)
 BIOS-e820: 00000000bf7ec000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000640000000 (usable)
...
ACPI: RSDP 00000000000fadf0 00024 (v02 ACPIAM)
ACPI: XSDT 00000000bf790100 00094 (v01 SMCI            20100929 MSFT 00000097)
ACPI: FACP 00000000bf790290 000F4 (v03 SUPERM FACP1026 20100929 MSFT 00000097)
ACPI: DSDT 00000000bf790700 07506 (v01  10400 10400000 00000000 INTL 20051117)
ACPI: FACS 00000000bf79e000 00040
ACPI: APIC 00000000bf790390 0012A (v01 SUPERM APIC1026 20100929 MSFT 00000097)
ACPI: MCFG 00000000bf7904c0 0003C (v01 SUPERM OEMMCFG  20100929 MSFT 00000097)
ACPI: SLIT 00000000bf790500 00030 (v01 SUPERM OEMSLIT  20100929 MSFT 00000097)
ACPI: SPMI 00000000bf790530 00041 (v05 SUPERM OEMSPMI  20100929 MSFT 00000097)
ACPI: OEMB 00000000bf79e040 0009B (v01 SUPERM OEMB1026 20100929 MSFT 00000097)
ACPI: SRAT 00000000bf79a700 001D0 (v01 SUPERM OEMSRAT  00000001 INTL 00000001)
ACPI: HPET 00000000bf79a8d0 00038 (v01 SUPERM OEMHPET  20100929 MSFT 00000097)
ACPI: DMAR 00000000bf79e0e0 00218 (v01    AMI  OEMDMAR 00000001 MSFT 00000097)
ACPI: SSDT 00000000bf7a1c30 00363 (v01 DpgPmm    CpuPm 00000012 INTL 20051117)
ACPI: EINJ 00000000bf79a910 00130 (v01  AMIER AMI_EINJ 20100929 MSFT 00000097)
ACPI: BERT 00000000bf79aaa0 00030 (v01  AMIER AMI_BERT 20100929 MSFT 00000097)
ACPI: ERST 00000000bf79aad0 001B0 (v01  AMIER AMI_ERST 20100929 MSFT 00000097)
ACPI: HEST 00000000bf79ac80 000A8 (v01  AMIER ABC_HEST 20100929 MSFT 00000097)
...
APEI: Can not request iomem region <00000000bf7b5fca-00000000bf7b5fcc> for
GARs.
GHES: gar mapped: 0, 0xbf7b5ff0
GHES: gar mapped: 0, 0xbf7b6200
[Firmware Warn]: GHES: Poll interval is 0 for generic hardware error source: 1, disabled.
GHES: APEI firmware first mode is enabled by WHEA _OSC.
Non-volatile memory driver v1.3
...


Looking into this the relevant messages seem to be:

BIOS-e820: 00000000bf79e000 - 00000000bf7d0000 (ACPI NVS)
...
APEI: Can not request iomem region <00000000bf7b5fca-00000000bf7b5fcc> for GARs.
GHES: gar mapped: 0, 0xbf7b5ff0 <--- the problem pointer
GHES: gar mapped: 0, 0xbf7b6200

This leads me to believe that the mapping for the error status register,
which is put in place by ghes_new(), is silently failing.  The other
possibility is that the mapping was un-mapped at some point.

My current guess is that the mapping is failing due to the GAR in
question residing within ACPI's NVS.

It looks like the original sighting was never root caused - the reporter
changed the CPUs in his system and the failure never reoccurred.  Well,
now that I read https://lkml.org/lkml/2011/9/4/123 again Rick's system
did have a mapping in place whereas this scenario does not so there is
at least that difference.

I looked into this some today and noticed some upstream commits that may
be of interest here:
  4134b8c8811  ACPI, APEI, Resolve false conflict between ACPI NVS and APEI
  b54ac6d2a25  ACPI, Record ACPI NVS regions
  b4e008dc53a  ACPI, APEI, EINJ, Refine the fix of resource conflict
  fdea163d8c1  ACPI, APEI, EINJ, Fix resource conflict on some machine

I'm wondering; were you ever able to root cause the issue when it
originally occurred?  I noticed that the above referenced patches seemed
to be posted shortly after the issue originally appeared - do you think
I'm on the right track and if so, is there some subset of the above
patches (or others that I have not identified) that you believe would
resolve what is occurring?

Thanks,
 Myron





