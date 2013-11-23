From: art1 <art1@vhex.net>
Subject: PROBLEM: restart instead of shutdown on 3.12.1, B85 Haswell
Date: Sat, 23 Nov 2013 13:28:31 +0100
Message-ID: <52909F6F.40401@vhex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vhex.net ([146.185.136.158]:34507 "EHLO vhex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755539Ab3KWMhb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Nov 2013 07:37:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org

Hi,
restarting and shutting down works correctly on 3.11.8, but on 3.12.1 
when I execute "sudo poweroff" the system restarts instead of shutting 
down. I didn't find any error messages.

Hardware is ASRock B85 Pro4 motherboard with i5-4670 Haswell and 
integrated graphics, software is Ubuntu 12.04.


System data:


$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux as 3.12.1-a1 #1 SMP PREEMPT Wed Nov 20 23:24:08 CET 2013 x86_64 
x86_64 x86_64 GNU/Linux

Gnu C                  4.6
Gnu make               3.81
binutils               2.22
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42
xfsprogs               3.1.7
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15.2
Sh-utils               8.13
wireless-tools         30
Modules Loaded         usb_storage snd_hrtimer pci_stub vboxpci 
vboxnetadp vboxnetflt fuse vboxdrv ip6table_filter ip6_tables 
ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT 
xt_CHECKSUM iptable_mangle xt_tcpudp iptable_filter ip_tables x_tables 
bridge stp llc dm_crypt dm_mod snd_hda_codec_realtek snd_hda_intel 
snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy 
snd_seq_oss snd_seq_midi joydev snd_rawmidi snd_seq_midi_event snd_seq 
psmouse bnep snd_timer serio_raw snd_seq_device rfcomm lpc_ich ehci_pci 
bluetooth ehci_hcd snd soundcore snd_page_alloc mei_me mei rfkill evdev 
processor w83627ehf hwmon_vid lm75 coretemp lp parport ext4 jbd2 mbcache 
crc16 sd_mod hid_generic usbhid hid crc32_pclmul crc32c_intel 
ghash_clmulni_intel ahci libahci aesni_intel i915 drm_kms_helper drm 
intel_agp i2c_algo_bit intel_gtt libata ablk_helper cryptd lrw gf128mul 
glue_helper i2c_core video e1000e aes_x86_64 scsi_mod xhci_hcd ptp 
pps_core usbcore usb_common button



$ dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.12.1-a1 (root@as) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1 SMP PREEMPT Wed Nov 20 23:24:08 CET 2013
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.12.1-a1 
root=UUID=3f8f69f8-5a66-49e1-8dd0-081d62f95a0d ro 
crashkernel=384M-2G:64M,2G-:128M
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b967afff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b967b000-0x00000000b9681fff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000b9682000-0x00000000b9f56fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b9f57000-0x00000000ba1f4fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ba1f5000-0x00000000cc20cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cc20d000-0x00000000cc412fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cc413000-0x00000000cc44efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cc44f000-0x00000000cc4f6fff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cc4f7000-0x00000000ccffefff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ccfff000-0x00000000ccffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cf800000-0x00000000df9fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041e5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./B85 
Pro4, BIOS P1.80 09/10/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x41e600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask 7C00000000 write-back
[    0.000000]   1 base 0400000000 mask 7FE0000000 write-back
[    0.000000]   2 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   3 base 00D0000000 mask 7FF0000000 uncachable
[    0.000000]   4 base 00CF800000 mask 7FFF800000 uncachable
[    0.000000]   5 base 041F000000 mask 7FFF000000 uncachable
[    0.000000]   6 base 041E800000 mask 7FFF800000 uncachable
[    0.000000]   7 base 041E600000 mask 7FFFE00000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 
0x7010600070106
[    0.000000] e820: update [mem 0xcf800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcd000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fd7b0-0x000fd7bf] mapped 
at [ffff8800000fd7b0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01b30000, 0x01b30fff] PGTABLE
[    0.000000] BRK [0x01b31000, 0x01b31fff] PGTABLE
[    0.000000] BRK [0x01b32000, 0x01b32fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x41e400000-0x41e5fffff]
[    0.000000]  [mem 0x41e400000-0x41e5fffff] page 2M
[    0.000000] BRK [0x01b33000, 0x01b33fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x41c000000-0x41e3fffff]
[    0.000000]  [mem 0x41c000000-0x41e3fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x400000000-0x41bffffff]
[    0.000000]  [mem 0x400000000-0x41bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xb967afff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0x7fffffff] page 1G
[    0.000000]  [mem 0x80000000-0xb95fffff] page 2M
[    0.000000]  [mem 0xb9600000-0xb967afff] page 4k
[    0.000000] init_memory_mapping: [mem 0xb9682000-0xb9f56fff]
[    0.000000]  [mem 0xb9682000-0xb97fffff] page 4k
[    0.000000]  [mem 0xb9800000-0xb9dfffff] page 2M
[    0.000000]  [mem 0xb9e00000-0xb9f56fff] page 4k
[    0.000000] BRK [0x01b34000, 0x01b34fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xba1f5000-0xcc20cfff]
[    0.000000]  [mem 0xba1f5000-0xba1fffff] page 4k
[    0.000000]  [mem 0xba200000-0xcc1fffff] page 2M
[    0.000000]  [mem 0xcc200000-0xcc20cfff] page 4k
[    0.000000] BRK [0x01b35000, 0x01b35fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xcc413000-0xcc44efff]
[    0.000000]  [mem 0xcc413000-0xcc44efff] page 4k
[    0.000000] init_memory_mapping: [mem 0xccfff000-0xccffffff]
[    0.000000]  [mem 0xccfff000-0xccffffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x3ffffffff]
[    0.000000]  [mem 0x100000000-0x3ffffffff] page 1G
[    0.000000] RAMDISK: [mem 0x35188000-0x368bbfff]
[    0.000000] Reserving 128MB of memory at 720MB for crashkernel 
(System RAM: 16037MB)
[    0.000000] ACPI: RSDP 00000000000f0490 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 00000000cc4d3088 00094 (v01 ALASKA    A M I 
01072009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000cc4dd7f8 0010C (v05 ALASKA    A M I 
01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 00000000cc4d31b8 0A639 (v02 ALASKA    A M I 
00000180 INTL 20091112)
[    0.000000] ACPI: FACS 00000000cc4f5080 00040
[    0.000000] ACPI: APIC 00000000cc4dd908 00072 (v03 ALASKA    A M I 
01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 00000000cc4dd980 00044 (v01 ALASKA    A M I 
01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 00000000cc4dd9c8 00539 (v01  PmRef Cpu0Ist 
00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000cc4ddf08 00AD8 (v01  PmRef CpuPm 
00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000cc4de9e0 001C7 (v01  PmRef LakeTiny 
00003000 INTL 20051117)
[    0.000000] ACPI: MCFG 00000000cc4deba8 0003C (v01 ALASKA    A M I 
01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cc4debe8 00038 (v01 ALASKA    A M I 
01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 00000000cc4dec20 0036D (v01 SataRe SataTabl 
00001000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000cc4def90 03294 (v01 SaSsdt SaSsdt  
00003000 INTL 20091112)
[    0.000000] ACPI: AAFT 00000000cc4e2228 002BB (v01 ALASKA OEMAAFT  
01072009 MSFT 00000097)
[    0.000000] ACPI: ASF! 00000000cc4e24e8 000A5 (v32 INTEL HCG 00000001 
TFSM 000F4240)
[    0.000000] ACPI: DMAR 00000000cc4e2590 000B8 (v01 INTEL HSW  
00000001 INTL 00000001)
[    0.000000] ACPI: SSDT 00000000cc4e2648 00803 (v01 Intel_ IsctTabl 
00001000 INTL 20091112)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000041e5fffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x41e5fffff]
[    0.000000]   NODE_DATA [mem 0x41e5f5000-0x41e5f9fff]
[    0.000000]  [ffffea0000000000-ffffea00107fffff] PMD -> 
[ffff88040e000000-ffff88041dbfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x41e5fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009cfff]
[    0.000000]   node   0: [mem 0x00100000-0xb967afff]
[    0.000000]   node   0: [mem 0xb9682000-0xb9f56fff]
[    0.000000]   node   0: [mem 0xba1f5000-0xcc20cfff]
[    0.000000]   node   0: [mem 0xcc413000-0xcc44efff]
[    0.000000]   node   0: [mem 0xccfff000-0xccffffff]
[    0.000000]   node   0: [mem 0x100000000-0x41e5fffff]
[    0.000000] On node 0 totalpages: 4105537
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12991 pages used for memmap
[    0.000000]   DMA32 zone: 831397 pages, LIFO batch:31
[    0.000000]   Normal zone: 51096 pages used for memmap
[    0.000000]   Normal zone: 3270144 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xb967b000-0xb9681fff]
[    0.000000] PM: Registered nosave memory: [mem 0xb9f57000-0xba1f4fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcc20d000-0xcc412fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcc44f000-0xcc4f6fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcc4f7000-0xccffefff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd000000-0xcf7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcf800000-0xdf9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfa00000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xdfa00000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 
nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff88041e200000 s86144 
r8192 d24448 u524288
[    0.000000] pcpu-alloc: s86144 r8192 d24448 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 4041365
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: 
BOOT_IMAGE=/boot/vmlinuz-3.12.1-artur1 
root=UUID=3f8f69f8-5a66-49e1-8dd0-081d62f95a0d ro 
crashkernel=384M-2G:64M,2G-:128M
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 15930888K/16422148K available (5188K kernel code, 
797K rwdata, 1696K rodata, 1144K init, 1288K bss, 491260K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]     RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]     Dump stacks of tasks blocking RCU-preempt GP.
[    0.000000]     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000] NR_IRQS:4352 nr_irqs:712 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 66060288 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't 
want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.003333] tsc: Detected 3398.872 MHz processor
[    0.000002] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 6800.98 BogoMIPS (lpj=11329573)
[    0.000117] pid_max: default: 32768 minimum: 301
[    0.000188] Security Framework initialized
[    0.000247] AppArmor: AppArmor disabled by boot time parameter
[    0.000304] Yama: becoming mindful.
[    0.001015] Dentry cache hash table entries: 2097152 (order: 12, 
16777216 bytes)
[    0.003226] Inode-cache hash table entries: 1048576 (order: 11, 
8388608 bytes)
[    0.004214] Mount-cache hash table entries: 256
[    0.004386] Initializing cgroup subsys memory
[    0.004448] Initializing cgroup subsys devices
[    0.004503] Initializing cgroup subsys freezer
[    0.004558] Initializing cgroup subsys net_cls
[    0.004613] Initializing cgroup subsys blkio
[    0.004682] CPU: Physical Processor ID: 0
[    0.004735] CPU: Processor Core ID: 0
[    0.004790] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.004790] ENERGY_PERF_BIAS: View and update with 
x86_energy_perf_policy(8)
[    0.005618] mce: CPU supports 9 MCE banks
[    0.005682] CPU0: Thermal monitoring enabled (TM1)
[    0.005746] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.005746] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0
[    0.005746] tlb_flushall_shift: 6
[    0.005931] Freeing SMP alternatives memory: 20K (ffffffff819e7000 - 
ffffffff819ec000)
[    0.006550] ACPI: Core revision 20130725
[    0.011621] ACPI: All ACPI Tables successfully acquired
[    0.013083] ftrace: allocating 20131 entries in 79 pages
[    0.018982] dmar: Host address width 39
[    0.020454] dmar: DRHD base: 0x000000fed90000 flags: 0x0
[    0.020515] dmar: IOMMU 0: reg_base_addr fed90000 ver 1:0 cap 
c0000020660462 ecap f0101a
[    0.020589] dmar: DRHD base: 0x000000fed91000 flags: 0x1
[    0.020649] dmar: IOMMU 1: reg_base_addr fed91000 ver 1:0 cap 
d2008020660462 ecap f010da
[    0.020722] dmar: RMRR base: 0x000000cc39a000 end: 0x000000cc3a6fff
[    0.020778] dmar: RMRR base: 0x000000cf800000 end: 0x000000df9fffff
[    0.020899] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.020956] HPET id 0 under DRHD base 0xfed91000
[    0.021117] Enabled IRQ remapping in x2apic mode
[    0.021172] Enabling x2apic
[    0.021224] Enabled x2apic
[    0.021279] Switched APIC routing to cluster x2apic.
[    0.021717] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.054748] smpboot: CPU0: Intel(R) Core(TM) i5-4670 CPU @ 3.40GHz 
(fam: 06, model: 3c, stepping: 03)
[    0.054934] TSC deadline timer enabled
[    0.054939] Performance Events: PEBS fmt2+, 16-deep LBR, Haswell 
events, full-width counters, Intel PMU driver.
[    0.055195] ... version:                3
[    0.055248] ... bit width:              48
[    0.055303] ... generic registers:      8
[    0.055358] ... value mask:             0000ffffffffffff
[    0.055414] ... max period:             0000ffffffffffff
[    0.055471] ... fixed-purpose events:   3
[    0.055524] ... event mask:             00000007000000ff
[    0.095607] NMI watchdog: enabled on all CPUs, permanently consumes 
one hw-PMU counter.
[    0.081679] smpboot: Booting Node   0, Processors  #   1 #   2 #   3 OK
[    0.136697] Brought up 4 CPUs
[    0.136752] smpboot: Total of 4 processors activated (27201.93 BogoMIPS)
[    0.139366] devtmpfs: initialized
[    0.142095] PM: Registering ACPI NVS region [mem 
0xb967b000-0xb9681fff] (28672 bytes)
[    0.142168] PM: Registering ACPI NVS region [mem 
0xcc44f000-0xcc4f6fff] (688128 bytes)
[    0.142706] RTC time: 11:58:25, date: 11/23/13
[    0.142784] NET: Registered protocol family 16
[    0.142896] cpuidle: using governor ladder
[    0.142951] cpuidle: using governor menu
[    0.143012] ACPI FADT declares the system doesn't support PCIe ASPM, 
so disable it
[    0.143084] ACPI: bus type PCI registered
[    0.143138] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.143229] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.143306] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.147610] PCI: Using configuration type 1 for base access
[    0.148090] bio: create slab <bio-0> at 0
[    0.148204] ACPI: Added _OSI(Module Device)
[    0.148256] ACPI: Added _OSI(Processor Device)
[    0.148313] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.148369] ACPI: Added _OSI(Processor Aggregator Device)
[    0.149528] ACPI: EC: Look up EC in DSDT
[    0.150732] ACPI: Executed 1 blocks of module-level executable AML code
[    0.152317] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.160100] ACPI: SSDT 00000000cc408c18 003D3 (v01  PmRef Cpu0Cst 
00003001 INTL 20051117)
[    0.160521] ACPI: Dynamic OEM Table Load:
[    0.160646] ACPI: SSDT           (null) 003D3 (v01  PmRef Cpu0Cst 
00003001 INTL 20051117)
[    0.172725] ACPI: SSDT 00000000cc408618 005AA (v01  PmRef ApIst 
00003000 INTL 20051117)
[    0.173195] ACPI: Dynamic OEM Table Load:
[    0.173319] ACPI: SSDT           (null) 005AA (v01  PmRef ApIst 
00003000 INTL 20051117)
[    0.186154] ACPI: SSDT 00000000cc407d98 00119 (v01  PmRef ApCst 
00003000 INTL 20051117)
[    0.186577] ACPI: Dynamic OEM Table Load:
[    0.186704] ACPI: SSDT           (null) 00119 (v01  PmRef ApCst 
00003000 INTL 20051117)
[    0.197048] ACPI: Interpreter enabled
[    0.197105] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep 
State [\_S1_] (20130725/hwxface-571)
[    0.197253] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep 
State [\_S2_] (20130725/hwxface-571)
[    0.197408] ACPI: (supports S0 S3 S4 S5)
[    0.197461] ACPI: Using IOAPIC for interrupt routing
[    0.197552] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.197731] ACPI: No dock devices found.
[    0.203244] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.203434] acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
[    0.203616] acpi PNP0A08:00: ACPI _OSC control (0x18) granted
[    0.203946] ACPI: \_SB_.PCI0.TPMX: can't evaluate _ADR (0x5)
[    0.204068] ACPI: \_SB_.PCI0.PDRC: can't evaluate _ADR (0x5)
[    0.204123] ACPI: \_SB_.PCI0.DOCK: can't evaluate _ADR (0x5)
[    0.204195] PCI host bridge to bus 0000:00
[    0.204250] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.204307] pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7]
[    0.204365] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff]
[    0.204423] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff]
[    0.204482] pci_bus 0000:00: root bus resource [mem 
0x000d0000-0x000d3fff]
[    0.204542] pci_bus 0000:00: root bus resource [mem 
0x000d4000-0x000d7fff]
[    0.204602] pci_bus 0000:00: root bus resource [mem 
0x000d8000-0x000dbfff]
[    0.204662] pci_bus 0000:00: root bus resource [mem 
0x000dc000-0x000dffff]
[    0.204721] pci_bus 0000:00: root bus resource [mem 
0x000e0000-0x000e3fff]
[    0.204780] pci_bus 0000:00: root bus resource [mem 
0x000e4000-0x000e7fff]
[    0.204839] pci_bus 0000:00: root bus resource [mem 
0xdfa00000-0xfeafffff]
[    0.204903] pci 0000:00:00.0: [8086:0c00] type 00 class 0x060000
[    0.204961] pci 0000:00:02.0: [8086:0412] type 00 class 0x030000
[    0.204969] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fffff 64bit]
[    0.204973] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 
64bit pref]
[    0.204976] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.205046] pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
[    0.205061] pci 0000:00:14.0: reg 0x10: [mem 0xf0420000-0xf042ffff 64bit]
[    0.205112] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.205144] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.205223] pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
[    0.205239] pci 0000:00:16.0: reg 0x10: [mem 0xf043c000-0xf043c00f 64bit]
[    0.205293] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.205349] pci 0000:00:19.0: [8086:153b] type 00 class 0x020000
[    0.205363] pci 0000:00:19.0: reg 0x10: [mem 0xf0400000-0xf041ffff]
[    0.205369] pci 0000:00:19.0: reg 0x14: [mem 0xf0439000-0xf0439fff]
[    0.205376] pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
[    0.205426] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.205456] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.205537] pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
[    0.205555] pci 0000:00:1a.0: reg 0x10: [mem 0xf0438000-0xf04383ff]
[    0.205632] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.205672] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.205753] pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
[    0.205765] pci 0000:00:1b.0: reg 0x10: [mem 0xf0430000-0xf0433fff 64bit]
[    0.205819] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.205851] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.205929] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
[    0.205983] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.206016] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.206092] pci 0000:00:1c.2: [8086:244e] type 01 class 0x060401
[    0.206146] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.206178] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    0.206262] pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
[    0.206279] pci 0000:00:1d.0: reg 0x10: [mem 0xf0437000-0xf04373ff]
[    0.206356] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.206394] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.206472] pci 0000:00:1f.0: [8086:8c50] type 00 class 0x060100
[    0.206606] pci 0000:00:1f.2: [8086:8c02] type 00 class 0x010601
[    0.206619] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
[    0.206625] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
[    0.206630] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
[    0.206636] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
[    0.206642] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    0.206648] pci 0000:00:1f.2: reg 0x24: [mem 0xf0436000-0xf04367ff]
[    0.206681] pci 0000:00:1f.2: PME# supported from D3hot
[    0.206725] pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
[    0.206737] pci 0000:00:1f.3: reg 0x10: [mem 0xf0435000-0xf04350ff 64bit]
[    0.206753] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.206843] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.206958] pci 0000:02:00.0: [1b21:1080] type 01 class 0x060401
[    0.207050] pci 0000:02:00.0: System wakeup disabled by ACPI
[    0.207123] pci 0000:00:1c.2: PCI bridge to [bus 02-03] (subtractive 
decode)
[    0.207189] pci 0000:00:1c.2:   bridge window [io  0x0000-0x0cf7] 
(subtractive decode)
[    0.207190] pci 0000:00:1c.2:   bridge window [io  0x0d00-0xffff] 
(subtractive decode)
[    0.207191] pci 0000:00:1c.2:   bridge window [mem 
0x000a0000-0x000bffff] (subtractive decode)
[    0.207192] pci 0000:00:1c.2:   bridge window [mem 
0x000d0000-0x000d3fff] (subtractive decode)
[    0.207193] pci 0000:00:1c.2:   bridge window [mem 
0x000d4000-0x000d7fff] (subtractive decode)
[    0.207194] pci 0000:00:1c.2:   bridge window [mem 
0x000d8000-0x000dbfff] (subtractive decode)
[    0.207195] pci 0000:00:1c.2:   bridge window [mem 
0x000dc000-0x000dffff] (subtractive decode)
[    0.207196] pci 0000:00:1c.2:   bridge window [mem 
0x000e0000-0x000e3fff] (subtractive decode)
[    0.207197] pci 0000:00:1c.2:   bridge window [mem 
0x000e4000-0x000e7fff] (subtractive decode)
[    0.207198] pci 0000:00:1c.2:   bridge window [mem 
0xdfa00000-0xfeafffff] (subtractive decode)
[    0.207307] pci 0000:02:00.0: PCI bridge to [bus 03] (subtractive decode)
[    0.207381] pci 0000:02:00.0:   bridge window [??? 0x00000000 flags 
0x0] (subtractive decode)
[    0.207382] pci 0000:02:00.0:   bridge window [??? 0x00000000 flags 
0x0] (subtractive decode)
[    0.207383] pci 0000:02:00.0:   bridge window [??? 0x00000000 flags 
0x0] (subtractive decode)
[    0.207384] pci 0000:02:00.0:   bridge window [??? 0x00000000 flags 
0x0] (subtractive decode)
[    0.207384] pci 0000:02:00.0:   bridge window [io  0x0000-0x0cf7] 
(subtractive decode)
[    0.207385] pci 0000:02:00.0:   bridge window [io  0x0d00-0xffff] 
(subtractive decode)
[    0.207386] pci 0000:02:00.0:   bridge window [mem 
0x000a0000-0x000bffff] (subtractive decode)
[    0.207387] pci 0000:02:00.0:   bridge window [mem 
0x000d0000-0x000d3fff] (subtractive decode)
[    0.207388] pci 0000:02:00.0:   bridge window [mem 
0x000d4000-0x000d7fff] (subtractive decode)
[    0.207389] pci 0000:02:00.0:   bridge window [mem 
0x000d8000-0x000dbfff] (subtractive decode)
[    0.207390] pci 0000:02:00.0:   bridge window [mem 
0x000dc000-0x000dffff] (subtractive decode)
[    0.207391] pci 0000:02:00.0:   bridge window [mem 
0x000e0000-0x000e3fff] (subtractive decode)
[    0.207392] pci 0000:02:00.0:   bridge window [mem 
0x000e4000-0x000e7fff] (subtractive decode)
[    0.207393] pci 0000:02:00.0:   bridge window [mem 
0xdfa00000-0xfeafffff] (subtractive decode)
[    0.207409] acpi PNP0A08:00: Disabling ASPM (FADT indicates it is 
unsupported)
[    0.207985] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 
14 15)
[    0.208462] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 
15) *0, disabled.
[    0.209020] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 
14 15)
[    0.209497] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 
14 15)
[    0.209970] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 10 11 12 
14 15)
[    0.210449] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 
15) *0, disabled.
[    0.211010] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 10 11 12 
14 15)
[    0.211486] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *10 11 12 
14 15)
[    0.212170] ACPI: Enabled 4 GPEs in block 00 to 3F
[    0.212298] ACPI: \_SB_.PCI0: notify handler is installed
[    0.212336] Found 1 acpi root devices
[    0.212379] vgaarb: device added: 
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.212452] vgaarb: loaded
[    0.212504] vgaarb: bridge control possible 0000:00:02.0
[    0.212579] PCI: Using ACPI for IRQ routing
[    0.213851] PCI: pci_cache_line_size set to 64 bytes
[    0.213886] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
[    0.213888] e820: reserve RAM buffer [mem 0xb967b000-0xbbffffff]
[    0.213889] e820: reserve RAM buffer [mem 0xb9f57000-0xbbffffff]
[    0.213889] e820: reserve RAM buffer [mem 0xcc20d000-0xcfffffff]
[    0.213891] e820: reserve RAM buffer [mem 0xcc44f000-0xcfffffff]
[    0.213891] e820: reserve RAM buffer [mem 0xcd000000-0xcfffffff]
[    0.213892] e820: reserve RAM buffer [mem 0x41e600000-0x41fffffff]
[    0.213940] NetLabel: Initializing
[    0.213993] NetLabel:  domain hash size = 128
[    0.214048] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.214111] NetLabel:  unlabeled traffic allowed by default
[    0.214178] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.214556] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.216624] Switched to clocksource hpet
[    0.219132] pnp: PnP ACPI init
[    0.219191] ACPI: bus type PNP registered
[    0.219286] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.219346] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.219353] pnp 00:01: [dma 4]
[    0.219361] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.219372] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    0.219425] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.219489] system 00:04: [io  0x0680-0x069f] has been reserved
[    0.219548] system 00:04: [io  0xffff] has been reserved
[    0.219604] system 00:04: [io  0xffff] has been reserved
[    0.219661] system 00:04: [io  0xffff] has been reserved
[    0.219718] system 00:04: [io  0x1c00-0x1cfe] has been reserved
[    0.219776] system 00:04: [io  0x1d00-0x1dfe] has been reserved
[    0.219833] system 00:04: [io  0x1e00-0x1efe] has been reserved
[    0.219891] system 00:04: [io  0x1f00-0x1ffe] has been reserved
[    0.219949] system 00:04: [io  0x1800-0x18fe] could not be reserved
[    0.220012] system 00:04: [io  0x164e-0x164f] has been reserved
[    0.220069] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.220088] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.220114] system 00:06: [io  0x1854-0x1857] has been reserved
[    0.220172] system 00:06: Plug and Play ACPI device, IDs INT3f0d 
PNP0c02 (active)
[    0.220214] system 00:07: [io  0x0290-0x029f] has been reserved
[    0.220272] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.220389] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.220446] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.220461] pnp 00:09: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.220551] pnp 00:0a: [dma 0 disabled]
[    0.220576] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.220822] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.220881] system 00:0b: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.220939] system 00:0b: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.220998] system 00:0b: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.221057] system 00:0b: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.221116] system 00:0b: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.221175] system 00:0b: [mem 0xfed90000-0xfed93fff] could not be 
reserved
[    0.221234] system 00:0b: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.221293] system 00:0b: [mem 0xff000000-0xffffffff] has been reserved
[    0.221351] system 00:0b: [mem 0xfee00000-0xfeefffff] could not be 
reserved
[    0.221411] system 00:0b: [mem 0xf7fef000-0xf7feffff] has been reserved
[    0.221471] system 00:0b: [mem 0xf7ff0000-0xf7ff0fff] has been reserved
[    0.221530] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.221678] pnp: PnP ACPI: found 12 devices
[    0.221730] ACPI: bus type PNP unregistered
[    0.227455] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to 
[bus 01] add_size 1000
[    0.227458] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000
[    0.227459] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff] to [bus 01] add_size 200000
[    0.227475] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] 
get_res_add_size add_size 200000
[    0.227477] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 
64bit pref] get_res_add_size add_size 200000
[    0.227478] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] 
get_res_add_size add_size 1000
[    0.227480] pci 0000:00:1c.0: BAR 14: assigned [mem 
0xdfa00000-0xdfbfffff]
[    0.227541] pci 0000:00:1c.0: BAR 15: assigned [mem 
0xdfc00000-0xdfdfffff 64bit pref]
[    0.227613] pci 0000:00:1c.0: BAR 13: assigned [io 0x2000-0x2fff]
[    0.227672] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.227729] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.227789] pci 0000:00:1c.0:   bridge window [mem 0xdfa00000-0xdfbfffff]
[    0.227849] pci 0000:00:1c.0:   bridge window [mem 
0xdfc00000-0xdfdfffff 64bit pref]
[    0.227925] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.227996] pci 0000:00:1c.2: PCI bridge to [bus 02-03]
[    0.228060] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.228061] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.228062] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.228063] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.228064] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.228065] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.228066] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff]
[    0.228067] pci_bus 0000:00: resource 11 [mem 0x000e0000-0x000e3fff]
[    0.228067] pci_bus 0000:00: resource 12 [mem 0x000e4000-0x000e7fff]
[    0.228068] pci_bus 0000:00: resource 13 [mem 0xdfa00000-0xfeafffff]
[    0.228070] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.228070] pci_bus 0000:01: resource 1 [mem 0xdfa00000-0xdfbfffff]
[    0.228071] pci_bus 0000:01: resource 2 [mem 0xdfc00000-0xdfdfffff 
64bit pref]
[    0.228072] pci_bus 0000:02: resource 4 [io  0x0000-0x0cf7]
[    0.228073] pci_bus 0000:02: resource 5 [io  0x0d00-0xffff]
[    0.228074] pci_bus 0000:02: resource 6 [mem 0x000a0000-0x000bffff]
[    0.228075] pci_bus 0000:02: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.228076] pci_bus 0000:02: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.228077] pci_bus 0000:02: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.228078] pci_bus 0000:02: resource 10 [mem 0x000dc000-0x000dffff]
[    0.228079] pci_bus 0000:02: resource 11 [mem 0x000e0000-0x000e3fff]
[    0.228080] pci_bus 0000:02: resource 12 [mem 0x000e4000-0x000e7fff]
[    0.228081] pci_bus 0000:02: resource 13 [mem 0xdfa00000-0xfeafffff]
[    0.228082] pci_bus 0000:03: resource 8 [io  0x0000-0x0cf7]
[    0.228083] pci_bus 0000:03: resource 9 [io  0x0d00-0xffff]
[    0.228084] pci_bus 0000:03: resource 10 [mem 0x000a0000-0x000bffff]
[    0.228085] pci_bus 0000:03: resource 11 [mem 0x000d0000-0x000d3fff]
[    0.228085] pci_bus 0000:03: resource 12 [mem 0x000d4000-0x000d7fff]
[    0.228086] pci_bus 0000:03: resource 13 [mem 0x000d8000-0x000dbfff]
[    0.228087] pci_bus 0000:03: resource 14 [mem 0x000dc000-0x000dffff]
[    0.228088] pci_bus 0000:03: resource 15 [mem 0x000e0000-0x000e3fff]
[    0.228089] pci_bus 0000:03: resource 16 [mem 0x000e4000-0x000e7fff]
[    0.228090] pci_bus 0000:03: resource 17 [mem 0xdfa00000-0xfeafffff]
[    0.228107] NET: Registered protocol family 2
[    0.228312] TCP established hash table entries: 131072 (order: 9, 
2097152 bytes)
[    0.228628] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.228791] TCP: Hash tables configured (established 131072 bind 65536)
[    0.230281] TCP: reno registered
[    0.230345] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.230441] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.230557] NET: Registered protocol family 1
[    0.230618] pci 0000:00:02.0: Boot video device
[    0.263315] PCI: CLS 64 bytes, default 64
[    0.263338] Unpacking initramfs...
[    0.523289] Freeing initrd memory: 23760K (ffff880035188000 - 
ffff8800368bc000)
[    0.523369] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.523429] software IO TLB [mem 0xc820d000-0xcc20d000] (64MB) mapped 
at [ffff8800c820d000-ffff8800cc20cfff]
[    0.523609] Scanning for low memory corruption every 60 seconds
[    0.523814] audit: initializing netlink socket (disabled)
[    0.523878] type=2000 audit(1385207905.519:1): initialized
[    0.531757] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.532758] zbud: loaded
[    0.532890] VFS: Disk quotas dquot_6.5.2
[    0.532969] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.533133] msgmni has been set to 31161
[    0.533390] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 252)
[    0.533487] io scheduler noop registered
[    0.533543] io scheduler deadline registered
[    0.533612] io scheduler cfq registered (default)
[    0.533802] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.533866] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.533951] intel_idle: MWAIT substates: 0x42120
[    0.533952] intel_idle: v0.4 model 0x3C
[    0.533953] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.534033] GHES: HEST is not enabled!
[    0.534116] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.554681] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) 
is a 16550A
[    0.555028] Linux agpgart interface v0.103
[    0.555120] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    0.557614] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.557684] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.557796] mousedev: PS/2 mouse device common for all mice
[    0.557883] rtc_cmos 00:05: RTC can wake from S4
[    0.558047] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    0.558127] rtc_cmos 00:05: alarms up to one month, y3k, 242 bytes 
nvram, hpet irqs
[    0.558262] drop_monitor: Initializing network drop monitor service
[    0.558363] TCP: cubic registered
[    0.558465] NET: Registered protocol family 10
[    0.558613] NET: Registered protocol family 17
[    0.558673] Key type dns_resolver registered
[    0.558902] registered taskstats version 1
[    0.559557]   Magic number: 5:368:985
[    0.559696] rtc_cmos 00:05: setting system clock to 2013-11-23 
11:58:25 UTC (1385207905)
[    0.559798] PM: Hibernation image not present or could not be loaded.
[    0.560452] Freeing unused kernel memory: 1144K (ffffffff818c9000 - 
ffffffff819e7000)
[    0.560524] Write protecting the kernel read-only data: 8192k
[    0.561960] Freeing unused kernel memory: 944K (ffff880001514000 - 
ffff880001600000)
[    0.562547] Freeing unused kernel memory: 352K (ffff8800017a8000 - 
ffff880001800000)
[    0.572218] udevd[74]: starting version 175
[    0.583593] input: Power Button as 
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    0.583673] ACPI: Power Button [PWRB]
[    0.585483] pps_core: LinuxPPS API ver. 1 registered
[    0.585543] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.585735] ACPI: bus type USB registered
[    0.585806] usbcore: registered new interface driver usbfs
[    0.585869] usbcore: registered new interface driver hub
[    0.586268] usbcore: registered new device driver usb
[    0.586723] PTP clock support registered
[    0.587491] xhci_hcd 0000:00:14.0: setting latency timer to 64
[    0.587494] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.587556] xhci_hcd 0000:00:14.0: new USB bus registered, assigned 
bus number 1
[    0.587709] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.587726] xhci_hcd 0000:00:14.0: irq 42 for MSI/MSI-X
[    0.588451] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    0.588511] e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
[    0.589244] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.589324] ACPI: Power Button [PWRF]
[    0.591317] SCSI subsystem initialized
[    0.593877] [drm] Initialized drm 1.1.0 20060810
[    0.596464] libata version 3.00 loaded.
[    0.596710] hub 1-0:1.0: USB hub found
[    0.596785] hub 1-0:1.0: 12 ports detected
[    0.598766] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.598829] xhci_hcd 0000:00:14.0: new USB bus registered, assigned 
bus number 2
[    0.599169] hub 2-0:1.0: USB hub found
[    0.599291] hub 2-0:1.0: 6 ports detected
[    0.609822] e1000e 0000:00:19.0: setting latency timer to 64
[    0.609874] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    0.609999] e1000e 0000:00:19.0: irq 43 for MSI/MSI-X
[    0.777324] e1000e 0000:00:19.0 eth0: registered PHC clock
[    0.777388] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 
bc:5f:f4:d0:b0:1f
[    0.777461] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network 
Connection
[    0.777545] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: 
FFFFFF-0FF
[    0.778263] [drm] Memory usable by graphics device = 2048M
[    0.778323] i915 0000:00:02.0: setting latency timer to 64
[    0.797972] i915 0000:00:02.0: irq 44 for MSI/MSI-X
[    0.797978] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    0.798037] [drm] Driver supports precise vblank timestamp query.
[    0.798134] vgaarb: device changed decodes: 
PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    0.956008] usb 1-11: new full-speed USB device number 2 using xhci_hcd
[    0.980909] hidraw: raw HID events driver (C) Jiri Kosina
[    0.990500] usbcore: registered new interface driver usbhid
[    0.990566] usbhid: USB HID core driver
[    0.991583] input: Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 
SiderWinderTM X6 Keyboard as 
/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.0/input/input4
[    0.991729] hid-generic 0003:045E:074B.0001: input,hidraw0: USB HID 
v1.11 Keyboard [Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 
SiderWinderTM X6 Keyboard] on usb-0000:00:14.0-11/input0
[    0.993655] input: Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 
SiderWinderTM X6 Keyboard as 
/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.1/input/input5
[    0.993764] hid-generic 0003:045E:074B.0002: input,hidraw1: USB HID 
v1.11 Device [Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 
SiderWinderTM X6 Keyboard] on usb-0000:00:14.0-11/input1
[    1.139171] usb 1-12: new low-speed USB device number 3 using xhci_hcd
[    1.157078] usb 1-12: ep 0x81 - rounding interval to 64 microframes, 
ep desc says 80 microframes
[    1.159287] input: Microsoft Microsoft 5-Button Mouse with 
IntelliEye(TM) as 
/devices/pci0000:00/0000:00:14.0/usb1/1-12/1-12:1.0/input/input6
[    1.159527] hid-generic 0003:045E:0047.0003: input,hidraw2: USB HID 
v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on 
usb-0000:00:14.0-12/input0
[    1.185924] fbcon: inteldrmfb (fb0) is primary device
[    1.487550] Console: switching to colour frame buffer device 180x56
[    1.489561] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    1.489576] i915 0000:00:02.0: registered panic notifier
[    1.516536] acpi device:57: registered as cooling_device0
[    1.516570] ACPI: Video Device [GFX0] (multi-head: yes  rom: no post: no)
[    1.516608] input: Video Bus as 
/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input7
[    1.516639] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on 
minor 0
[    1.516672] ahci 0000:00:1f.2: version 3.0
[    1.516752] ahci 0000:00:1f.2: irq 45 for MSI/MSI-X
[    1.516841] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 
0x1 impl SATA mode
[    1.516863] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part 
ems apst
[    1.516883] ahci 0000:00:1f.2: setting latency timer to 64
[    1.517537] scsi0 : ahci
[    1.517595] scsi1 : ahci
[    1.517782] scsi2 : ahci
[    1.517878] scsi3 : ahci
[    1.517950] scsi4 : ahci
[    1.518013] scsi5 : ahci
[    1.518073] ata1: SATA max UDMA/133 abar m2048@0xf0436000 port 
0xf0436100 irq 45
[    1.518091] ata2: DUMMY
[    1.518098] ata3: DUMMY
[    1.518105] ata4: DUMMY
[    1.518112] ata5: DUMMY
[    1.518119] ata6: DUMMY
[    1.525488] tsc: Refined TSC clocksource calibration: 3399.013 MHz
[    1.835253] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.835614] ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
[    1.835616] ata1.00: ATA-9: Samsung SSD 840 EVO 120GB, EXT0AB0Q, max 
UDMA/133
[    1.835633] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 
31/32), AA
[    1.835943] ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
[    1.835945] ata1.00: configured for UDMA/133
[    1.836068] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 840  
EXT0 PQ: 0 ANSI: 5
[    1.838804] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 
GB/111 GiB)
[    1.838913] sd 0:0:0:0: [sda] Write Protect is off
[    1.838926] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.838948] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.839312]  sda: sda1 sda2 sda3
[    1.839558] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.351542] [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
[    2.524708] Switched to clocksource tsc
[    6.868792] EXT4-fs (sda1): mounted filesystem with ordered data 
mode. Opts: (null)
[    7.242032] EXT4-fs (sda1): re-mounted. Opts: 
discard,barrier=0,errors=remount-ro,commit=120
[    7.294910] EXT4-fs (sda3): barriers disabled
[    7.298052] EXT4-fs (sda3): mounted filesystem with ordered data 
mode. Opts: discard,barrier=0,commit=120,journal_async_commit
[    8.241337] udevd[665]: starting version 175
[    8.305636] lp: driver loaded but no devices found
[    8.341966] w83627ehf: Found NCT6776F chip at 0x290
[    8.385798] mei_me 0000:00:16.0: setting latency timer to 64
[    8.385842] mei_me 0000:00:16.0: irq 46 for MSI/MSI-X
[    8.393876] Bluetooth: Core ver 2.16
[    8.393890] NET: Registered protocol family 31
[    8.393891] Bluetooth: HCI device and connection manager initialized
[    8.393896] Bluetooth: HCI socket layer initialized
[    8.393898] Bluetooth: L2CAP socket layer initialized
[    8.393900] Bluetooth: SCO socket layer initialized
[    8.394572] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    8.398364] ehci-pci: EHCI PCI platform driver
[    8.398827] ehci-pci 0000:00:1a.0: setting latency timer to 64
[    8.398834] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    8.398839] ehci-pci 0000:00:1a.0: new USB bus registered, assigned 
bus number 3
[    8.398850] ehci-pci 0000:00:1a.0: debug port 2
[    8.402918] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    8.402932] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf0438000
[    8.404627] Bluetooth: RFCOMM TTY layer initialized
[    8.404634] Bluetooth: RFCOMM socket layer initialized
[    8.404635] Bluetooth: RFCOMM ver 1.11
[    8.412639] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    8.412646] Bluetooth: BNEP socket layer initialized
[    8.412829] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    8.412933] hub 3-0:1.0: USB hub found
[    8.412937] hub 3-0:1.0: 2 ports detected
[    8.413099] ehci-pci 0000:00:1d.0: setting latency timer to 64
[    8.413104] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    8.413107] ehci-pci 0000:00:1d.0: new USB bus registered, assigned 
bus number 4
[    8.413117] ehci-pci 0000:00:1d.0: debug port 2
[    8.417007] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    8.417021] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf0437000
[    8.426109] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    8.427410] hub 4-0:1.0: USB hub found
[    8.427417] hub 4-0:1.0: 2 ports detected
[    8.427836] ACPI Warning: 0x0000000000001828-0x000000000000182f 
SystemIO conflicts with Region \PMIO 1 (20130725/utaddress-251)
[    8.427840] ACPI: If an ACPI driver is available for this device, you 
should use it instead of the native driver
[    8.427843] ACPI Warning: 0x0000000000001c30-0x0000000000001c3f 
SystemIO conflicts with Region \GPRL 1 (20130725/utaddress-251)
[    8.427844] ACPI Warning: 0x0000000000001c30-0x0000000000001c3f 
SystemIO conflicts with Region \GPR_ 2 (20130725/utaddress-251)
[    8.427846] ACPI: If an ACPI driver is available for this device, you 
should use it instead of the native driver
[    8.427847] ACPI Warning: 0x0000000000001c00-0x0000000000001c2f 
SystemIO conflicts with Region \GPRL 1 (20130725/utaddress-251)
[    8.427848] ACPI Warning: 0x0000000000001c00-0x0000000000001c2f 
SystemIO conflicts with Region \GPR_ 2 (20130725/utaddress-251)
[    8.427850] ACPI: If an ACPI driver is available for this device, you 
should use it instead of the native driver
[    8.427850] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    8.462328] snd_hda_intel 0000:00:1b.0: irq 47 for MSI/MSI-X
[    8.484264] input: HDA Intel PCH Front Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    8.484310] input: HDA Intel PCH Line Out as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[    8.484343] input: HDA Intel PCH Line as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[    8.484537] input: HDA Intel PCH Rear Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[    8.484578] input: HDA Intel PCH Front Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    8.553751] device-mapper: uevent: version 1.0.3
[    8.553866] device-mapper: ioctl: 4.26.0-ioctl (2013-08-15) 
initialised: dm-devel@redhat.com
[    8.636041] e1000e 0000:00:19.0: irq 43 for MSI/MSI-X
[    8.719226] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    8.739215] e1000e 0000:00:19.0: irq 43 for MSI/MSI-X
[    8.739299] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[    8.846255] hub 3-1:1.0: USB hub found
[    8.846338] hub 3-1:1.0: 6 ports detected
[    8.952363] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    9.076200] hub 4-1:1.0: USB hub found
[    9.076265] hub 4-1:1.0: 6 ports detected
[   10.242783] e1000e: eth1 NIC Link is Up 100 Mbps Full Duplex, Flow 
Control: Rx/Tx
[   10.242786] e1000e 0000:00:19.0 eth1: 10/100 speed: disabling TSO
[   10.242812] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   12.567896] init: failsafe main process (955) killed by TERM signal
[   12.628495] init: Failed to spawn hybrid-gfx main process: unable to 
execute: No such file or directory
[   12.716853] Bridge firewalling registered
[   12.753914] ip_tables: (C) 2000-2006 Netfilter Core Team
[   12.769993] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   12.778774] IPv6: ADDRCONF(NETDEV_UP): virbr0: link is not ready
[   13.327580] Ebtables v2.0 registered
[   13.333724] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   13.341913] cgroup: libvirtd (1693) created nested cgroup for 
controller "memory" which has incomplete hierarchy support. Nested 
cgroups may change behavior in the future.
[   13.341915] cgroup: "memory" requires setting use_hierarchy to 1 on 
the root.
[   13.460898] vboxdrv: Found 4 processor cores.
[   13.461215] vboxdrv: fAsync=0 offMin=0x1a2 offMax=0xdfe
[   13.461647] vboxdrv: TSC mode is 'synchronous', kernel timer mode is 
'normal'.
[   13.461648] vboxdrv: Successfully loaded version 4.3.2 (interface 
0x001a0005).
[   13.589864] fuse init (API version 7.22)
[   13.667534] vboxpci: IOMMU not found (not registered)
[   13.760331] init: plymouth-stop pre-start process (2228) terminated 
with status 1
[   14.065888] hda-intel: IRQ timing workaround is activated for card 
#0. Suggest a bigger bdl_pos_adj.





$ lspci -vvv
00:00.0 Host bridge: Intel Corporation 4th Gen Core Processor DRAM 
Controller (rev 06)
     Subsystem: ASRock Incorporation Device 0c00
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3/4th 
Gen Core Processor Integrated Graphics Controller (rev 06) (prog-if 00 
[VGA controller])
     Subsystem: ASRock Incorporation Device 0412
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 44
     Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=4M]
     Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
     Region 4: I/O ports at f000 [size=64]
     Expansion ROM at <unassigned> [disabled]
     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00018  Data: 0000
     Capabilities: [d0] Power Management version 2
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a4] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: i915
     Kernel modules: i915

00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB xHCI (rev 05) (prog-if 30 [XHCI])
     Subsystem: ASRock Incorporation Device 8c31
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 42
     Region 0: Memory at f0420000 (64-bit, non-prefetchable) [size=64K]
     Capabilities: [70] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee00298  Data: 0000
     Kernel driver in use: xhci_hcd
     Kernel modules: xhci-hcd

00:16.0 Communication controller: Intel Corporation 8 Series/C220 Series 
Chipset Family MEI Controller #1 (rev 04)
     Subsystem: ASRock Incorporation Device 8c3a
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 46
     Region 0: Memory at f043c000 (64-bit, non-prefetchable) [size=16]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00338  Data: 0000
     Kernel driver in use: mei_me
     Kernel modules: mei-me

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection 
I217-V (rev 05)
     Subsystem: ASRock Incorporation Device 153b
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 43
     Region 0: Memory at f0400000 (32-bit, non-prefetchable) [size=128K]
     Region 1: Memory at f0439000 (32-bit, non-prefetchable) [size=4K]
     Region 2: I/O ports at f080 [size=32]
     Capabilities: [c8] Power Management version 2
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee002d8  Data: 0000
     Capabilities: [e0] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: e1000e
     Kernel modules: e1000e

00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])
     Subsystem: ASRock Incorporation Device 8c2d
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at f0438000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci
     Kernel modules: ehci-pci

00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset 
High Definition Audio Controller (rev 05)
     Subsystem: ASRock Incorporation Device 5892
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 47
     Region 0: Memory at f0430000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00378  Data: 0000
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE- FLReset+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown, 
Latency L0 <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk- 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=2 ArbSelect=Fixed TC/VC=04
             Status:    NegoPending- InProgress-
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 00002000-00002fff
     Memory behind bridge: dfa00000-dfbfffff
     Prefetchable memory behind bridge: 00000000dfc00000-00000000dfdfffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot+
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+ ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: ASRock Incorporation Device 8c10
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d5) (prog-if 
01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: fff00000-000fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <1us, L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot+
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+ ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: ASRock Incorporation Device 244e
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])
     Subsystem: ASRock Incorporation Device 8c26
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 0: Memory at f0437000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci
     Kernel modules: ehci-pci

00:1f.0 ISA bridge: Intel Corporation B85 Express LPC Controller (rev 05)
     Subsystem: ASRock Incorporation Device 8c50
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: lpc_ich
     Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series Chipset 
Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
     Subsystem: ASRock Incorporation Device 8c02
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 45
     Region 0: I/O ports at f0d0 [size=8]
     Region 1: I/O ports at f0c0 [size=4]
     Region 2: I/O ports at f0b0 [size=8]
     Region 3: I/O ports at f0a0 [size=4]
     Region 4: I/O ports at f060 [size=32]
     Region 5: Memory at f0436000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee00318  Data: 0000
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
     Kernel driver in use: ahci
     Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family 
SMBus Controller (rev 05)
     Subsystem: ASRock Incorporation Device 8c22
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 11
     Region 0: Memory at f0435000 (64-bit, non-prefetchable) [size=256]
     Region 4: I/O ports at f040 [size=32]
     Kernel modules: i2c-i801

02:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI 
Bridge (rev 03) (prog-if 01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: fff00000-000fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [c0] Subsystem: ASRock Incorporation Device 1080


