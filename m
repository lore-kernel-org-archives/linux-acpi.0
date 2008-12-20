From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: need pci=nomsi or ahci fails to resume
Date: Sat, 20 Dec 2008 03:23:02 +0000 (UTC)
Message-ID: <gihoel$p0c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56896 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbYLTDXO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 22:23:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LDsQn-0005tR-Ls
	for linux-acpi@vger.kernel.org; Sat, 20 Dec 2008 03:23:09 +0000
Received: from d193-213-184.home3.cgocable.net ([67.193.213.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 20 Dec 2008 03:23:09 +0000
Received: from brian by d193-213-184.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 20 Dec 2008 03:23:09 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi,

I've got an Acer Aspire 4350 here which I'm having some suspend/resume 
difficulties.  I'm using the Ubuntu 2.6.27-9-generic kernel (I've also
had the same problems with a 2.6.28-rc8 kernel.org kernel and it 
suspends just fine and mostly resumes fine with the exception that I 
don't seem to have a working disk after the resume.  In dmesg I see the 
following errors:

[   94.436968] NVRM: RmPowerManagement: 5
[   95.093046] ata6: SATA link down (SStatus 0 SControl 300)
[   95.093085] ata5: SATA link down (SStatus 0 SControl 300)
[   95.093109] ata3: SATA link down (SStatus 0 SControl 300)
[   95.093133] ata4: SATA link down (SStatus 0 SControl 300)
[   95.257023] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   95.761025] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  100.257019] ata2.00: qc timeout (cmd 0xa1)
[  100.257029] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  100.257031] ata2.00: revalidation failed (errno=-5)
[  100.741023] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  100.761016] ata1.00: qc timeout (cmd 0xec)
[  100.761023] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  100.761025] ata1.00: revalidation failed (errno=-5)
[  101.245023] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  110.741015] ata2.00: qc timeout (cmd 0xa1)
[  110.741021] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  110.741024] ata2.00: revalidation failed (errno=-5)
[  111.225024] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  111.245016] ata1.00: qc timeout (cmd 0xec)
[  111.245024] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  111.245026] ata1.00: revalidation failed (errno=-5)
[  111.729024] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
...
[  141.224101] ata2.00: qc timeout (cmd 0xa1)
[  141.224110] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  141.224114] ata2.00: revalidation failed (errno=-5)
[  141.224116] ata2.00: disabled
[  141.224131] ata2: hard resetting link
[  141.709018] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  141.709022] ata2: EH complete
[  141.729016] ata1.00: qc timeout (cmd 0xec)
[  141.729021] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  141.729023] ata1.00: revalidation failed (errno=-5)
[  141.729025] ata1.00: disabled
[  141.729030] ata1: hard resetting link
[  142.317017] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  142.317021] ata1: EH complete
[  142.317055] sd 0:0:0:0: [sda] START_STOP FAILED
[  142.317057] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  142.317068] PM: Device 0:0:0:0 failed to resume: error 262144
[  142.828749] PM: resume devices took 48.708 seconds
[  142.828758] ------------[ cut here ]------------
[  142.828761] WARNING: at /build/buildd/linux-2.6.27/kernel/power/main.c:176 suspend_test_finish+0x74/0x80()
[  142.828764] Modules linked in: rfcomm sco bridge stp bnep l2cap bluetooth ppdev powernow_k8 cpufreq_ondemand cpufreq_powersave cpufreq_userspace cpufreq_stats cpufreq_conservative freq_table sbs sbshc container pci_slot ipv6 af_packet iptable_filter ip_tables x_tables parport_pc lp parport snd_hda_intel arc4 ecb snd_pcm_oss snd_mixer_oss joydev crypto_blkcipher acer_wmi snd_pcm led_class ath9k psmouse mac80211 pcspkr evdev serio_raw nvidia(P) snd_seq_dummy agpgart cfg80211 snd_seq_oss snd_seq_midi i2c_core snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd shpchp pci_hotplug soundcore snd_page_alloc video output battery wmi button ac ext3 jbd mbcache loop sd_mod sr_mod cdrom crc_t10dif sg usb_storage libusual ahci tg3 libphy libata scsi_mod dock ehci_hcd ohci_hcd usbcor
 e thermal processor fan fbcon tileblit font bitblit softcursor fuse
[  142.828821] Pid: 5796, comm: pm-suspend Tainted: P          2.6.27-9-generic #1
[  142.828825]  [<c037c4b6>] ? printk+0x1d/0x1f
[  142.828832]  [<c0131de9>] warn_on_slowpath+0x59/0x90
[  142.828838]  [<c014d255>] ? sched_clock_cpu+0xd5/0x170
[  142.828843]  [<c014c0af>] ? down_trylock+0x2f/0x40
[  142.828847]  [<c01324c2>] ? try_acquire_console_sem+0x12/0x40
[  142.828851]  [<c024e580>] ? kobject_put+0x20/0x50
[  142.828856]  [<c015d204>] suspend_test_finish+0x74/0x80
[  142.828860]  [<c015d2f6>] suspend_devices_and_enter+0xe6/0x190
[  142.828865]  [<c015d571>] enter_state+0xd1/0x100
[  142.828867]  [<c015d625>] state_store+0x85/0xd0
[  142.828870]  [<c015d5a0>] ? state_store+0x0/0xd0
[  142.828873]  [<c024e444>] kobj_attr_store+0x24/0x30
[  142.828876]  [<c01ff4c7>] sysfs_write_file+0x97/0x100
[  142.828880]  [<c01b24c0>] vfs_write+0xa0/0x110
[  142.828883]  [<c01ff430>] ? sysfs_write_file+0x0/0x100
[  142.828887]  [<c01b2602>] sys_write+0x42/0x70
[  142.828890]  [<c0103f7b>] sysenter_do_call+0x12/0x2f
[  142.828894]  =======================
[  142.828896] ---[ end trace 25d69a100d20ea19 ]---
[  142.829545] PM: Finishing wakeup.
[  142.829548] Restarting tasks ... done.
[  143.062508] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  143.062524] end_request: I/O error, dev sda, sector 67465536
[  143.062624] Buffer I/O error on device sda2, logical block 5811496
[  143.063189] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  143.063194] end_request: I/O error, dev sda, sector 67465536
[  143.063288] Buffer I/O error on device sda2, logical block 5811496
[  143.064581] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  143.064590] end_request: I/O error, dev sda, sector 67465536
[  143.064685] Buffer I/O error on device sda2, logical block 5811496
[  143.065017] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  143.065022] end_request: I/O error, dev sda, sector 67465536
[  143.065116] Buffer I/O error on device sda2, logical block 5811496
[  143.848550] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  143.848573] end_request: I/O error, dev sda, sector 27309280
[  143.848692] Buffer I/O error on device sda2, logical block 791964
[  143.848801] lost page write due to I/O error on sda2
[  143.848835] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  143.848844] end_request: I/O error, dev sda, sector 53386904
[  143.848950] Buffer I/O error on device sda2, logical block 4051667
[  143.849069] lost page write due to I/O error on sda2

The hardware inventory is:

00:00.0 RAM memory: nVidia Corporation MCP78S [GeForce 8200] Memory Controller (rev a2)
00:01.0 ISA bridge: nVidia Corporation Device 075e (rev a2)
00:01.1 SMBus: nVidia Corporation MCP78S [GeForce 8200] SMBus (rev a1)
00:01.3 Co-processor: nVidia Corporation MCP78S [GeForce 8200] Co-Processor (rev a2)
00:01.4 RAM memory: nVidia Corporation MCP78S [GeForce 8200] Memory Controller (rev a1)
00:02.0 USB Controller: nVidia Corporation MCP78S [GeForce 8200] OHCI USB 1.1 Controller (rev a1)
00:02.1 USB Controller: nVidia Corporation MCP78S [GeForce 8200] EHCI USB 2.0 Controller (rev a1)
00:04.0 USB Controller: nVidia Corporation MCP78S [GeForce 8200] OHCI USB 1.1 Controller (rev a1)
00:04.1 USB Controller: nVidia Corporation MCP78S [GeForce 8200] EHCI USB 2.0 Controller (rev a1)
00:07.0 Audio device: nVidia Corporation Realtek ALC1200 8-Channel High Definition Audio Codec (rev a1)
00:08.0 PCI bridge: nVidia Corporation MCP78S [GeForce 8200] PCI Bridge (rev a1)
00:09.0 SATA controller: nVidia Corporation Device 0ad5 (rev a2)
00:0b.0 PCI bridge: nVidia Corporation MCP78S [GeForce 8200] PCI Express Bridge (rev a1)
00:13.0 PCI bridge: nVidia Corporation Device 077a (rev a1)
00:14.0 PCI bridge: nVidia Corporation Device 077a (rev a1)
00:15.0 PCI bridge: nVidia Corporation Device 077a (rev a1)
00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 11h HyperTransport Configuration (rev 40)
00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 11h Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 11h DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 11h Miscellaneous Control
00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 11h Link Control
02:00.0 VGA compatible controller: nVidia Corporation GeForce 9100M G (rev a2)
08:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5764M Gigabit Ethernet PCIe (rev 10)
0b:00.0 Network controller: Atheros Communications Inc. AR928X Wireless Network Adapter (PCI-Express) (rev 01)

Through some poking around, I have come to discover that I need to boot 
the kernel with pci=nomsi in order to have the SATA disk work after a 
resume (I don't really need the option just to have it boot with this 
kernel though unlike previous 2.6.24 kernels).

This bug looks remarkably like http://bugzilla.kernel.org/show_bug.cgi?
id=11178 however I've checked the source for the kernel I'm using and it
has the patch from that bug in it already and I've even built a
2.6.28-rc8 kernel and I still have the same problem.

With the kernel booted with pci=nomsi, after a suspend/resume the SATA
disk works and this is what I get in my dmesg:

[  102.520563] PM: Syncing filesystems ... done.
[  102.521272] PM: Preparing system for mem sleep
[  102.522124] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  102.522951] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  102.523023] PM: Entering mem sleep
[  102.523026] Suspending console(s) (use no_console_suspend to debug)
[  102.527370] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  102.723576] sd 0:0:0:0: [sda] Stopping disk
[  103.804880] ath9k 0000:0b:00.0: PCI INT A disabled
[  103.956054] NVRM: RmPowerManagement: 4
[  106.088283] ahci 0000:00:09.0: PCI INT A disabled
[  106.136051] HDA Intel 0000:00:07.0: PCI INT A disabled
[  106.152068] ehci_hcd 0000:00:04.1: PCI INT B disabled
[  106.168061] ohci_hcd 0000:00:04.0: PCI INT A disabled
[  106.184033] ohci_hcd 0000:00:04.0: PME# enabled
[  106.184043] ohci_hcd 0000:00:04.0: wake-up capability enabled by ACPI
[  106.184047] ohci_hcd 0000:00:04.0: PME# enabled
[  106.184049] ohci_hcd 0000:00:04.0: wake-up capability enabled by ACPI
[  106.184088] ehci_hcd 0000:00:02.1: PCI INT B disabled
[  106.200060] ohci_hcd 0000:00:02.0: PCI INT A disabled
[  106.216032] ohci_hcd 0000:00:02.0: PME# enabled
[  106.216038] ohci_hcd 0000:00:02.0: wake-up capability enabled by ACPI
[  106.216042] ohci_hcd 0000:00:02.0: PME# enabled
[  106.216044] ohci_hcd 0000:00:02.0: wake-up capability enabled by ACPI
[  106.216331] PM: suspend devices took 3.696 seconds
[  106.216415] ACPI: Preparing to enter system sleep state S3
[  106.216641] Disabling non-boot CPUs ...
[  106.320038] CPU 1 is now offline
[  106.320042] SMP alternatives: switching to UP code
[  106.329827] CPU0 attaching NULL sched-domain.
[  106.329832] CPU1 attaching NULL sched-domain.
[  106.329879] CPU0 attaching sched-domain:
[  106.329882]  domain 0: span 0 level CPU
[  106.329885]   groups: 0
[  106.330142] CPU1 is down
[  106.330298] Extended CMOS year: 2000
[  106.330298] Back to C!
[  106.330298] Extended CMOS year: 2000
[  106.335097] Enabling non-boot CPUs ...
[  106.335362] SMP alternatives: switching to SMP code
[  106.345186] Booting processor 1/1 ip 6000
[  106.220874] Initializing CPU#1
[  106.220874] Calibrating delay using timer specific routine.. 3800.08 BogoMIPS (lpj=7600173)
[  106.220874] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  106.220874] CPU: L2 Cache: 512K (64 bytes/line)
[  106.220874] CPU 1(2) -> Core 1
[  106.436234] CPU1: AMD Athlon(tm) X2 Dual-Core QL-60 stepping 01
[  106.436278] CPU0 attaching NULL sched-domain.
[  106.440027] Switched to high resolution mode on CPU 1
[  106.440032] CPU0 attaching sched-domain:
[  106.440035]  domain 0: span 0-1 level CPU
[  106.440038]   groups: 0 1
[  106.440043] CPU1 attaching sched-domain:
[  106.440045]  domain 0: span 0-1 level CPU
[  106.440047]   groups: 1 0
[  106.440520] CPU1 is up
[  106.440524] ACPI: Waking up from system sleep state S3
[  106.832298] ACPI: EC: non-query interrupt received, switching to interrupt mode
[  106.855283] ohci_hcd 0000:00:02.0: wake-up capability disabled by ACPI
[  106.855289] ohci_hcd 0000:00:02.0: PME# disabled
[  106.855291] ohci_hcd 0000:00:02.0: wake-up capability disabled by ACPI
[  106.855295] ohci_hcd 0000:00:02.0: PME# disabled
[  106.868024] ohci_hcd 0000:00:02.0: PCI INT A -> Link[LUS0] -> GSI 20 (level, low) -> IRQ 20
[  106.868030] ohci_hcd 0000:00:02.0: setting latency timer to 64
[  106.908019] ehci_hcd 0000:00:02.1: PCI INT B -> Link[LUS2] -> GSI 18 (level, low) -> IRQ 18
[  106.908024] ehci_hcd 0000:00:02.1: setting latency timer to 64
[  106.908056] ohci_hcd 0000:00:04.0: wake-up capability disabled by ACPI
[  106.908060] ohci_hcd 0000:00:04.0: PME# disabled
[  106.908063] ohci_hcd 0000:00:04.0: wake-up capability disabled by ACPI
[  106.908067] ohci_hcd 0000:00:04.0: PME# disabled
[  106.924019] ohci_hcd 0000:00:04.0: PCI INT A -> Link[Z002] -> GSI 19 (level, low) -> IRQ 19
[  106.924024] ohci_hcd 0000:00:04.0: setting latency timer to 64
[  106.964019] ehci_hcd 0000:00:04.1: PCI INT B -> Link[Z003] -> GSI 17 (level, low) -> IRQ 17
[  106.964023] ehci_hcd 0000:00:04.1: setting latency timer to 64
[  106.980026] HDA Intel 0000:00:07.0: restoring config space at offset 0xf (was 0x5020100, writing 0x502010a)
[  106.980040] HDA Intel 0000:00:07.0: restoring config space at offset 0x4 (was 0x0, writing 0xc8000000)
[  106.980047] HDA Intel 0000:00:07.0: restoring config space at offset 0x1 (was 0xb00000, writing 0xb00002)
[  106.980062] HDA Intel 0000:00:07.0: PCI INT A -> Link[LAZA] -> GSI 22 (level, low) -> IRQ 22
[  106.980067] HDA Intel 0000:00:07.0: setting latency timer to 64
[  107.076422] pci 0000:00:08.0: setting latency timer to 64
[  107.092049] ahci 0000:00:09.0: PCI INT A -> Link[LSI0] -> GSI 16 (level, low) -> IRQ 16
[  107.092054] ahci 0000:00:09.0: setting latency timer to 64
[  107.092238] pci 0000:00:0b.0: setting latency timer to 64
[  107.092319] pcieport-driver 0000:00:13.0: restoring config space at offset 0x7 (was 0x1f1, writing 0x200001f1)
[  107.092392] pcieport-driver 0000:00:13.0: setting latency timer to 64
[  107.092544] pcieport-driver 0000:00:14.0: setting latency timer to 64
[  107.092628] pcieport-driver 0000:00:15.0: restoring config space at offset 0x7 (was 0x1f1, writing 0x200001f1)
[  107.092701] pcieport-driver 0000:00:15.0: setting latency timer to 64
[  107.092804] NVRM: RmPowerManagement: 5
[  107.749070] ata3: SATA link down (SStatus 0 SControl 300)
[  107.749100] ata5: SATA link down (SStatus 0 SControl 300)
[  107.749123] ata4: SATA link down (SStatus 0 SControl 300)
[  107.749145] ata6: SATA link down (SStatus 0 SControl 300)
[  107.913024] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  107.921435] ata2.00: configured for UDMA/133
[  107.921450] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  107.921452] ata2: irq_stat 0x00000040, connection status changed
[  107.930567] ata2.00: configured for UDMA/133
[  107.930570] ata2: EH complete
[  108.641023] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  108.649177] ata1.00: configured for UDMA/133
[  108.649186] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  108.649189] ata1: irq_stat 0x00000040, connection status changed
[  108.651789] ata1.00: configured for UDMA/133
[  108.651791] ata1: EH complete
[  108.651852] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  108.651874] sd 0:0:0:0: [sda] Write Protect is off
[  108.651877] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  108.651911] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  108.651945] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[  108.651963] sd 0:0:0:0: [sda] Write Protect is off
[  108.651966] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  108.651999] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  139.949279] tg3 0000:08:00.0: restoring config space at offset 0x3 (was 0x0, writing 0x10)
[  139.949288] tg3 0000:08:00.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100106)
[  139.966140] tg3: eth0: Link is down.
[  140.156023] ath9k 0000:0b:00.0: enabling device (0000 -> 0002)
[  140.156035] ath9k 0000:0b:00.0: PCI INT A -> Link[Z00O] -> GSI 21 (level, low) -> IRQ 21
[  140.156055] ath9k 0000:0b:00.0: restoring config space at offset 0xf (was 0x1ff, writing 0x10b)
[  140.156074] ath9k 0000:0b:00.0: restoring config space at offset 0x4 (was 0x4, writing 0xca400004)
[  140.156080] ath9k 0000:0b:00.0: restoring config space at offset 0x3 (was 0x0, writing 0x10)
[  140.156087] ath9k 0000:0b:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100107)
[  140.288630] sd 0:0:0:0: [sda] Starting disk
[  141.172704] PM: resume devices took 34.396 seconds
[  141.172713] ------------[ cut here ]------------
[  141.172716] WARNING: at /build/buildd/linux-2.6.27/kernel/power/main.c:176 suspend_test_finish+0x74/0x80()
[  141.172719] Modules linked in: rfcomm sco bridge stp bnep l2cap bluetooth ppdev powernow_k8 cpufreq_ondemand cpufreq_powersave cpufreq_userspace cpufreq_stats cpufreq_conservative freq_table sbs sbshc container pci_slot ipv6 af_packet iptable_filter ip_tables x_tables parport_pc lp parport snd_hda_intel arc4 snd_pcm_oss joydev snd_mixer_oss ecb crypto_blkcipher nvidia(P) snd_pcm ath9k pcspkr acer_wmi psmouse agpgart mac80211 serio_raw led_class evdev i2c_core snd_seq_dummy cfg80211 snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq shpchp pci_hotplug snd_timer snd_seq_device snd soundcore snd_page_alloc video output wmi button battery ac ext3 jbd mbcache loop sr_mod cdrom sd_mod crc_t10dif sg usb_storage libusual ahci libata scsi_mod dock tg3 libphy ehci_hcd ohci_hcd usbcor
 e thermal processor fan fbcon tileblit font bitblit softcursor fuse
[  141.172776] Pid: 5825, comm: pm-suspend Tainted: P          2.6.27-9-generic #1
[  141.172780]  [<c037c4b6>] ? printk+0x1d/0x1f
[  141.172787]  [<c0131de9>] warn_on_slowpath+0x59/0x90
[  141.172793]  [<c014d255>] ? sched_clock_cpu+0xd5/0x170
[  141.172798]  [<c014c0af>] ? down_trylock+0x2f/0x40
[  141.172802]  [<c01324c2>] ? try_acquire_console_sem+0x12/0x40
[  141.172806]  [<c024e580>] ? kobject_put+0x20/0x50
[  141.172811]  [<c015d204>] suspend_test_finish+0x74/0x80
[  141.172815]  [<c015d2f6>] suspend_devices_and_enter+0xe6/0x190
[  141.172819]  [<c015d571>] enter_state+0xd1/0x100
[  141.172822]  [<c015d625>] state_store+0x85/0xd0
[  141.172824]  [<c015d5a0>] ? state_store+0x0/0xd0
[  141.172827]  [<c024e444>] kobj_attr_store+0x24/0x30
[  141.172830]  [<c01ff4c7>] sysfs_write_file+0x97/0x100
[  141.172834]  [<c01b24c0>] vfs_write+0xa0/0x110
[  141.172838]  [<c01ff430>] ? sysfs_write_file+0x0/0x100
[  141.172841]  [<c01b2602>] sys_write+0x42/0x70
[  141.172844]  [<c0103f7b>] sysenter_do_call+0x12/0x2f
[  141.172849]  =======================
[  141.172851] ---[ end trace 18ad8b27ef1dd778 ]---
[  141.173284] PM: Finishing wakeup.
[  141.173286] Restarting tasks ... done.
[  141.752720] tg3: eth0: Link is up at 100 Mbps, full duplex.
[  141.752733] tg3: eth0: Flow control is on for TX and on for RX.

Any ideas?

b.

