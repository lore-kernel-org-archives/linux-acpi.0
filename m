From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Subject: ipw2100 problems with acpi interrupt routing after S3
Date: Fri, 9 Jul 2004 18:29:58 +0200
Sender: ipw2100-devel-admin@lists.sourceforge.net
Message-ID: <200407091829.58692.stefandoesinger@gmx.at>
Reply-To: stefandoesinger@gmx.at
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ggs7Ai+Xvea+sdf"
Return-path: <ipw2100-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: ipw2100-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ipw2100-devel>,
	<mailto:ipw2100-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:ipw2100-devel@lists.sourceforge.net>
List-Help: <mailto:ipw2100-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ipw2100-devel>,
	<mailto:ipw2100-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ipw2100-devel>
To: acpi-devel@lists.sourceforge.net, ipw2100-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_Ggs7Ai+Xvea+sdf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I have problems with ipw2100 when I use acpi for IRQ routing. I don't know if 
it's a acpi bug or a ipw2100 bug, so I write to both lists.

The problem occurs after S3 resume, the system is an Acer Travelmate 803. 
System information is attached. The system works like a charm after resume if 
ipw2100 is not loaded. When loading ipw2100(version 0.48), acpi comlains that 
no one cared about IRQ11(the irq of the ipw card) and IRQ 10, which is not 
used by the wlan card, but used by many other devices. Both irqs are disabled 
afterwards. 
I tried with 2.6.7+acpi patch+the patch from acpi bug 2643 and 2.6.7-mm7+ bug 
2643 patch.

With 2.6.7, the system crashes with "Disabling IRQ # 11", 2.6.7-mm7 is still 
running afterwards, but in a pretty unuseable state. The provided dmesg is 
from 2.6.7-mm7, having ipw2100 loaded when suspending. If it's not loaded, 
the system works fine until I load it.

Passing pci=noacpi makes ipw2100 resume correctly, but the system is quite 
unstable and many devices tend to crash due to irq problems. The same problem 
also occurs when using ndiswrapper.

I don't know if it's an acpi or ipw2100 problem. On the one hand the problem 
occurs with ipw2100 and ndiswrapper, on the other hand the system works 
really fine without ipw2100. I don't know how much the linux and windows ipw 
driver have in common.

Thanks in advance,
Stefan



--Boundary-00=_Ggs7Ai+Xvea+sdf
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg-2.6.7-mm7"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-2.6.7-mm7"

 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
Simple Boot Flag at 0x37 set to 0x1
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p3 < p5 p6 p7 p8 p9 >
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
kjournald starting.  Commit interval 5 seconds
NET: Registered protocol family 1
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
Adding 1052216k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda9, internal journal
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
SCSI subsystem initialized
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev hda1.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
Real Time Clock Driver v1.12
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
b44.c:v0.94 (May 4, 2004)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:27:ea:5a
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: loading with WEP enabled.
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.48
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
Detected ipw2100 PCI device at 0000:02:04.0, mem: 0xD0206000-0xD0206FFF -> e08f2000, irq: 11
wlan0: Using hotplug firmware load.
Registered as wlan0
NET: Registered protocol family 17
ACPI: AC Adapter [ACAD] (on-line)
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2 C3)
[ACPI Debug] String: Length 0x23, "Current Temperature is ----------- "
[ACPI Debug] Integer: 0x0000000000000049
[ACPI Debug] String: Length 0x23, "Current Temperature is ----------- "
[ACPI Debug] Integer: 0x0000000000000049
acpi_bus-0266 [95] acpi_bus_set_power    : Error transitioning device [FAN1] to D0
acpi_thermal-0619 [94] acpi_thermal_active   : Unable to turn cooling device [dfe3f928] 'on'
acpi_bus-0266 [95] acpi_bus_set_power    : Error transitioning device [FAN0] to D0
acpi_thermal-0619 [94] acpi_thermal_active   : Unable to turn cooling device [dfe3e228] 'on'
ACPI: Thermal Zone [THRM] (73 C)
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
b44: eth0: Link is down.
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
[ACPI Debug] String: Length 0x23, "Current Temperature is ----------- "
[ACPI Debug] Integer: 0x000000000000003E
ieee80211_crypt: registered algorithm 'WEP'
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
[ACPI Debug] String: Length 0x23, "Current Temperature is ----------- "
[ACPI Debug] Integer: 0x0000000000000039
wlan0: Associated with 'doesinger' at 11Mbps, channel 9
wlan0: Waking net queue.
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
[ACPI Debug] String: Length 0x23, "Current Temperature is ----------- "
[ACPI Debug] Integer: 0x0000000000000034
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
[ACPI Debug] String: Length 0x23, "Current Temperature is ----------- "
[ACPI Debug] Integer: 0x0000000000000033
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
[ACPI Debug] String: Length 0x19, "Sleep Button Query: Fn+F4"
Module dummydriver init
dummy_probe
dummy_probe
dummy_probe
PM: Preparing system for suspend
Stopping tasks: ===========================|
[ACPI Debug] String: Length 0x16, ">>>> _PTS ------------"
[ACPI Debug] Integer: 0x0000000000000003
dummy_pm_suspend: not doing anything
dummy_pm_suspend: not doing anything
dummy_pm_suspend: not doing anything
PM: Entering state.
 hwsleep-0312 [104] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
irq 11: nobody cared!
 [<c010840a>] __report_bad_irq+0x2a/0x90
 [<c0108500>] note_interrupt+0x70/0xb0
 [<c01087e0>] do_IRQ+0x120/0x130
 [<c0106a38>] common_interrupt+0x18/0x20
 [<c0108390>] handle_IRQ_event+0x30/0x80
 [<c010874f>] do_IRQ+0x8f/0x130
 [<c0106a38>] common_interrupt+0x18/0x20
 [<c0120ace>] __do_softirq+0x2e/0x80
 [<c0120b47>] do_softirq+0x27/0x30
 [<c01087bb>] do_IRQ+0xfb/0x130
 [<c010c660>] time_resume+0x0/0x50
 [<c0106a38>] common_interrupt+0x18/0x20
 [<c010c660>] time_resume+0x0/0x50
 [<c010c69d>] time_resume+0x3d/0x50
 [<c020a273>] sysdev_resume+0x103/0x108
 [<c020dc05>] device_power_up+0x5/0xa
 [<c01348c6>] suspend_enter+0x36/0x50
 [<c0134989>] enter_state+0x69/0xb0
 [<c01ec3d9>] acpi_suspend+0x3e/0x4d
 [<c01ec4ed>] acpi_system_write_sleep+0x69/0x7d
 [<c01541c8>] vfs_write+0xb8/0x130
 [<c01542f2>] sys_write+0x42/0x70
 [<c01060cb>] syscall_call+0x7/0xb
handlers:
[<e09c36f0>] (ipw2100_interrupt+0x0/0x240 [ipw2100])
Disabling IRQ #11
PM: Finishing up.
dummy_pm_resume: not doing anything
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
dummy_pm_resume: not doing anything
dummy_pm_resume: not doing anything
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
wlan0: Using hotplug firmware load.
wlan0: ipw2100_hw_send_command timed out.
wlan0: Failed to start the card.
[ACPI Debug] String: Length 0x16, ">>>> _WAK ------------"
[ACPI Debug] Integer: 0x0000000000000003
irq 10: nobody cared!
 [<c010840a>] __report_bad_irq+0x2a/0x90
 [<c0108500>] note_interrupt+0x70/0xb0
 [<c01087e0>] do_IRQ+0x120/0x130
 [<c0106a38>] common_interrupt+0x18/0x20
 [<c0120ace>] __do_softirq+0x2e/0x80
 [<c0120b47>] do_softirq+0x27/0x30
 [<c01087bb>] do_IRQ+0xfb/0x130
 [<c0106a38>] common_interrupt+0x18/0x20
 [<c01c40cd>] acpi_os_write_port+0x22/0x39
 [<c01d5eec>] acpi_ex_system_io_space_handler+0xa1/0xc7
 [<c01d5e4b>] acpi_ex_system_io_space_handler+0x0/0xc7
 [<c01cb58d>] acpi_ev_address_space_dispatch+0x231/0x2b1
 [<c01d1c93>] acpi_ex_access_region+0xdb/0x183
 [<c01d1cb4>] acpi_ex_access_region+0xfc/0x183
 [<c01d1ed3>] acpi_ex_field_datum_io+0x15e/0x2b0
 [<c01d21f9>] acpi_ex_write_with_update_rule+0x1d4/0x1ef
 [<c01d22a3>] acpi_ex_get_buffer_datum+0x8f/0x97
 [<c01d280d>] acpi_ex_insert_into_field+0x115/0x2d4
 [<c01d0161>] acpi_ex_write_data_to_field+0x344/0x393
 [<c01d6684>] acpi_ex_store_object_to_node+0xda/0x1c2
 [<c01d616d>] acpi_ex_store+0x81/0x2f7
 [<c01d2ff0>] acpi_ex_opcode_1A_1T_1R+0x49c/0x5fc
 [<c01e8373>] acpi_ut_status_exit+0x49/0x55
 [<c01c77ad>] acpi_ds_exec_end_op+0x131/0x444
 [<c01e03ed>] acpi_ps_append_arg+0x1d/0x85
 [<c01dfd75>] acpi_ps_parse_loop+0x6e5/0xa85
 [<c01e01d4>] acpi_ps_parse_aml+0xbf/0x277
 [<c01e0e9e>] acpi_psx_execute+0x1e2/0x290
 [<c01dc40d>] acpi_ns_execute_control_method+0xdf/0xfe
 [<c01dc2f9>] acpi_ns_evaluate_by_handle+0xe2/0x117
 [<c01dc1c2>] acpi_ns_evaluate_by_name+0xd8/0x12d
 [<c01db4ee>] acpi_evaluate_object+0x11a/0x28d
 [<c01d9ce4>] acpi_leave_sleep_state+0x1a3/0x2c7
 [<c01ec370>] acpi_pm_finish+0x12/0x3d
 [<c0134917>] suspend_finish+0x37/0x40
 [<c013499f>] enter_state+0x7f/0xb0
 [<c01ec3d9>] acpi_suspend+0x3e/0x4d
 [<c01ec4ed>] acpi_system_write_sleep+0x69/0x7d
 [<c01541c8>] vfs_write+0xb8/0x130
 [<c01542f2>] sys_write+0x42/0x70
 [<c01060cb>] syscall_call+0x7/0xb
handlers:
[<e0a14d30>] (radeon_irq_handler+0x0/0xc0 [radeon])
Disabling IRQ #10
wlan0: Hardware fatal error detected.
wlan0: Scheduling firmware restart.
ipw2100: wlan0: Restarting adapter.
wlan0: Using hotplug firmware load.
Restarting tasks... done
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
[ACPI Debug] String: Length 0x23, "Current Temperature is ----------- "
[ACPI Debug] Integer: 0x0000000000000038
wlan0: ipw2100_hw_send_command timed out.
wlan0: Failed to start the card.
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000135
Module dummydriver exit
dummy_remove
dummy_remove
dummy_remove
wlan0: Hardware fatal error detected.
wlan0: Scheduling firmware restart.
ipw2100: wlan0: Restarting adapter.
wlan0: Using hotplug firmware load.
wlan0: ipw2100_hw_send_command timed out.
wlan0: Failed to start the card.
wlan0: Hardware fatal error detected.
wlan0: Scheduling firmware restart.
ipw2100: wlan0: Restarting adapter.
wlan0: Using hotplug firmware load.
wlan0: ipw2100_hw_send_command timed out.
wlan0: Failed to start the card.
wlan0: Hardware fatal error detected.
wlan0: Scheduling firmware restart.
ipw2100: wlan0: Restarting adapter.
wlan0: Using hotplug firmware load.
wlan0: ipw2100_hw_send_command timed out.
wlan0: Failed to start the card.
wlan0: Power down command failed: Error -5
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.48
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
irq 11: nobody cared!
 [<c010840a>] __report_bad_irq+0x2a/0x90
 [<c0108500>] note_interrupt+0x70/0xb0
 [<c01087e0>] do_IRQ+0x120/0x130
 [<c0106a38>] common_interrupt+0x18/0x20
 [<c0120ace>] __do_softirq+0x2e/0x80
 [<c0120b47>] do_softirq+0x27/0x30
 [<c01087bb>] do_IRQ+0xfb/0x130
 [<c0106a38>] common_interrupt+0x18/0x20
 [<c0108d7f>] setup_irq+0x7f/0xf0
 [<e09c26f0>] ipw2100_interrupt+0x0/0x240 [ipw2100]
 [<c01088b4>] request_irq+0x84/0xd0
 [<e09ca62a>] ipw2100_pci_init_one+0x40a/0x5c0 [ipw2100]
 [<e09c26f0>] ipw2100_interrupt+0x0/0x240 [ipw2100]
 [<c01c07a2>] pci_device_probe_static+0x52/0x70
 [<c01c07fc>] __pci_device_probe+0x3c/0x50
 [<c01c083c>] pci_device_probe+0x2c/0x50
 [<c020a76f>] bus_match+0x3f/0x70
 [<c020a89c>] driver_attach+0x5c/0xa0
 [<c020adc1>] bus_add_driver+0x91/0xb0
 [<c020b36f>] driver_register+0x2f/0x40
 [<c01c0abc>] pci_register_driver+0x5c/0x90
 [<e08f205a>] ipw2100_init+0x5a/0x90 [ipw2100]
 [<c0133679>] sys_init_module+0x119/0x230
 [<c01060cb>] syscall_call+0x7/0xb
handlers:
[<e09c26f0>] (ipw2100_interrupt+0x0/0x240 [ipw2100])
Disabling IRQ #11
Detected ipw2100 PCI device at 0000:02:04.0, mem: 0xD0206000-0xD0206FFF -> e09e2000, irq: 11
wlan0: Using hotplug firmware load.
wlan0: ipw2100_hw_send_command timed out.
wlan0: Failed to start the card.
Intel 810 + AC97 Audio, version 1.01, 11:57:29 Jul  9 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0x18c0 and 0x1c00, MEM 0xd0000c00 and 0xd0000800, IRQ 10
i810: Intel ICH4 mmio at 0xe09e2c00 and 0xe09e4800
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ALG64 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
i810_audio: drain_dac, dma timeout?

--Boundary-00=_Ggs7Ai+Xvea+sdf
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

0000:00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
00: 86 80 40 33 06 01 90 20 03 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Expansion ROM at 00003000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 41 33 07 01 a0 00 03 00 04 06 00 60 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
20: 10 d0 10 d0 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 1800 [size=32]
00: 86 80 c2 24 05 00 80 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1820 [size=32]
00: 86 80 c4 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]
00: 86 80 c7 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00

0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]
00: 86 80 cd 24 06 01 90 02 03 20 03 0c 00 00 00 00
10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 04 00 00

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d05fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 01 80 80 83 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 40 40 80 22
20: 20 d0 50 d0 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 cc 24 0f 00 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 ca 24 07 00 80 02 03 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 61 18 00 00 00 00 00 20 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

0000:00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1880 [size=32]
00: 86 80 c3 24 01 00 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 1c00
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c5 24 07 00 90 02 03 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 0c 00 d0 00 08 00 d0
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 03) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 2400
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c6 24 05 00 90 02 03 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000] (rev 01) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable)
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 66 4c 87 03 b0 02 01 00 00 03 08 42 00 00
10: 08 00 00 d8 01 30 00 00 00 00 10 d0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 08 00

0000:02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0204000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: e4 14 01 44 06 01 10 00 01 00 00 02 00 40 00 00
10: 00 40 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00

0000:02:04.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0206000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 86 80 43 10 16 01 90 02 04 00 80 02 08 40 00 00
10: 00 60 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 27 25
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 22

0000:02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0207000 (32-bit, non-prefetchable)
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: d0400000-d04ff000 (prefetchable)
	Memory window 1: d0300000-d03ff000 (prefetchable)
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004000-000040ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001
00: 17 12 14 71 87 01 10 04 20 00 07 06 00 40 82 00
10: 00 70 20 d0 a0 00 00 02 02 03 06 b0 00 00 40 d0
20: 00 f0 4f d0 00 00 30 d0 00 f0 3f d0 01 44 00 00
30: fd 44 00 00 01 40 00 00 fd 40 00 00 ff 01 c0 03
40: 25 10 1f 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:06.1 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [disabled]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
	16-bit legacy interface ports at 0001
00: 17 12 14 71 80 00 10 04 20 00 07 06 00 00 82 00
10: 00 10 00 20 a0 00 00 02 02 07 0a b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 00 01 00 00
40: 25 10 1f 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:06.2 System peripheral: O2 Micro, Inc.: Unknown device 7110
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0208000 (32-bit, non-prefetchable)
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 12 10 71 03 01 10 04 00 00 80 08 08 40 00 00
10: 00 80 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 0a 01 00 00

0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0209000 (32-bit, non-prefetchable)
	Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 26 80 16 01 10 02 00 10 00 0c 08 40 00 00
10: 00 90 20 d0 00 00 20 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 02 04


--Boundary-00=_Ggs7Ai+Xvea+sdf
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="dummydriver.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dummydriver.c"

/***************************************************************************
 *   Copyright (C) 2004 by Stefan D=F6singer                               =
  *
 *   stefandoesinger@gmx.at                                                *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 **************************************************************************=
*/
/*This driver provides an empty suspend and resume function for the sound c=
ard
and the modem built into the Acer Travelmate 800. This is to prevent the
default resume function of the kernel from crashing the system.*/
=20
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/pci.h>

MODULE_DESCRIPTION("My kernel module");
MODULE_AUTHOR("Stefan D=F6singer (stefandoesinger@gmx.at)");
MODULE_LICENSE("GPL");

static struct pci_device_id dummy_pci_tbl [] =3D {
	{0x8086, 0x24c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},	/*Sound card*/
	{0x8086, 0x24c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Modem */
//	{0x1217, 0x7114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* pcmcia */
//	{0x1217, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* unknown */
//	{0x104c, 0x8026, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* firewire */
//	{0x8086, 0x24c2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* usb */
//	{0x8086, 0x24c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* usb*/
//	{0x8086, 0x24c7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* usb*/
	{0x8086, 0x24cd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* usb */
	{0,}
};

static int dummy_pm_suspend(struct pci_dev *dev, u32 pm_state)
{
	printk("%s: not doing anything\n", __FUNCTION__);
	return 0;
}

static int dummy_pm_resume(struct pci_dev *dev)
{
	printk("%s: not doing anything\n", __FUNCTION__);
	return 0;
}

static void __devexit dummy_remove(struct pci_dev *pci_dev)
{
	printk("%s\n", __FUNCTION__);

	return;
}

static int __devinit dummy_probe(struct pci_dev *pci_dev, const struct pci_=
device_id *pci_id)
{
	printk("%s\n", __FUNCTION__);
	return 0;
}

static struct pci_driver dummy_pci_driver =3D {
	.name		=3D "dummy_driver",
	.id_table	=3D dummy_pci_tbl,
	.probe		=3D dummy_probe,
	.remove		=3D __devexit_p(dummy_remove),
#ifdef CONFIG_PM
	.suspend	=3D dummy_pm_suspend,
	.resume		=3D dummy_pm_resume,
#endif /* CONFIG_PM */
};

static int dummydriver_init_module(void)
{
	printk( KERN_DEBUG "Module dummydriver init\n" );
=09
	if (!pci_register_driver(&dummy_pci_driver))
	{
		pci_unregister_driver(&dummy_pci_driver);
                return -ENODEV;
	}
=09
	return 0;
}

static void dummydriver_exit_module(void)
{
	printk( KERN_DEBUG "Module dummydriver exit\n" );
	pci_unregister_driver(&dummy_pci_driver);
}

module_init(dummydriver_init_module);
module_exit(dummydriver_exit_module);

--Boundary-00=_Ggs7Ai+Xvea+sdf
Content-Type: application/x-gzip;
  name="acpidump.out.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="acpidump.out.gz"

QlpoOTFBWSZTWeCIa7MAUB7/gH31RERUf//3P///9b/v//pgQ577w+qpSoEbADQuBzgd7ze9g0Gh
9NKXuHyivWfd24YbdbrA73t2q2tr7YK59vdl6LHurKd3veV4Sl17tRPU++vc9YLvvTm9Vc3ddbz4
9B5DRpb7X3173t27y7ye1jTZu7B2cpvN3tvec8o22rvd63Muzr27rnu9nuJdm59d2473vvl5mw5F
s+70h718ntW9j0017th97X3G7vr1p3zd58+e5xX33le9xyjtjWUigJEiABGQaTCJgQJqPSn6k8UN
NAGg0AAACU0ECQBBoptBNT01R+U1PU8RPSA0NGQAAAAJNJIRGiaAynpDKeRNkieSGJoaaABo00A0
AyCT1SkhKTT9UyDQeoAAAAAAAAAAAAiSgRPRGRoAJoMp6AyJPap6NTGU8mjE00nqYjJoAiREImQN
BGU9DVQ/0TFT2pP1RsieoaAAAAAB0G2DxB75EGQ1CLUECik4SwposRLUUaYMIqqt+J0JJAFQ6USN
+C/qv59T3Z9H570+36/J+z9nUqq0MVWLFkKjRq2tYWlYkfv2oKoKVq6kNGSiZIUuQccKEoRZjAUG
oWNsKIwXBS42WUaXBI4lRixRueV02GMmUleu6ZPNW9SSoYW5hQzDEkWCwmUqCwxLCMbl3dFoa7HR
kNJS0agWUpSwKlCixFLMAzGDKBMdm81eWunXXZpUTIlK4PSViLFT4WyOUoiMERZ8fryEwSRSIikW
uRmbFu1KkTiSAcADJjRFU1eO15dreRtNSaa3mSCRhAwspMMwhELiwUpaDYlWWlGVRoUpQaEQUwJl
ZEdpqUzFSbZiXnXSiLWIFBCIQYFVgVyFVkWBmGGSikpjeLw4bq8x10kvHErjt0zOXYmO061u65vN
o23XjMjYSi0QoLGFGkZJopPXw+Pyfyvf31EmzKg0Wiitee3nkJRIfGq3y0oshGvLt43btzW8quu0
WpUgwGUBAyxgAgUBTKhgzEEtIKWqLZKyhSglFGiMhkDCZGETKBKpKgkEqDSzLIhChoWARaACy2AW
0MglqxGiSUybNZiyRsoiWAmZhmYlYzYWoi3jzymtu3dZXa8USWmbBJEBhLQbBWNZKmWUss1kKK88
k6leNcW11alXUySKWV1dzrtumotKU1kKQpZGZNTNy5G5qusmtFJU0mSkQpKj8V2lZRJUpG1eTW11
HXYsYEQqi0aoxaQtcQFhG1oCoWlLY2WshKRkUWMqjBd3UoHdopIoyaJ0qY3TJqKFIyx3cUGroliV
dtwZJEoQNcksuq6aczujC7nTnTWjaLe167+jv/aNmd48jBnLRgeCprpToG+IiLwQFBABvBU1yKqK
jSCgUOHa9X1+hy4Cnym1EbAVQ1hgUl4fucp9vo833Z/PrC6zAABTciCCLRjSCa0UsSECCq/kRVP8
xAf+w88EU1dJksQMgy8gcgQXAIr/o1meOwUcFgiD9ZL2AApYRfHEqIpogo/tloC3K/e2IDZ/p/4T
S0HCKZfCgOmIqHmEA/Lzk6uve8/C/NATEEhBAIEGMGRkRZASTY1SmtKT37cqNMxUMxWNtjWablV0
rMnXdC2UqSjZSSg22LRQhbSa7ulMaxbJDAwJjurdTMa5Jq4hmaNJpFDTuuRO6usxi5upJCoxVVYA
HZCfR9vx9dv1+/UmEIKLq5+o/EWf2/Z/uXiqKSgtJ/K/76qPxuq+K8INT9YEiD2AZafBkO7tC8lu
yWIfPJFH0S0U4URnvNchCEPf7vl21cP1IiJoPm7xcTmltz1QGdYXhYp4B2ACCCCCCCodRxqE6gGC
BETcWRpIpZqRY0llMdxFPYG24IBL5eti+U6cpmnr1QHlbz1W5bgH6WjJDnNcnWpKFXWYCgyy1CKk
oA2kaGWXJzhtr3m0mzm+YYgobwM+wM0CuNU0BYY7OhMwmSg46AtQlEUhhE+jV/Qoz8SKbnBXY+AC
DWSxYzLKco6cYKEqTQgGBhRArA5wO2UkUzFoiESCRjFgwRBHtKcENILNphtCIGmGiGqAWRjEjuxZ
OIDgoLGF2uGkALWCsV+wyTWeeO/BRYJtxJ+sADRM5VGCohyG/ZQx1Jvxb46NnjruOPVBk3eBGpep
hRHLyQxFiK83kSJkGGtVmzeqVjF6u8q+FcADVdkS2woMrIKEBActl0aDKqBSMKQQIzdmWCkQC4HM
2m5YU2wLGZRhZWU5jDAxEphmgwNUDJRBIW7yQNBrwyoHLcRBJdg6HBZsIuFiCXEYLMM0qwsQQGbo
RYkTkYYL3OfLaf6GxXW8m+boYh0EeqrjMZxEASTODQSTRSgSzDGzqYKFOpixYoJy5jF69/gAAADv
PbHak0mOSDCWQZaS1FgVRFg6gHQh0NbbKHNDqghis5CbRgggzJb4OwYNkSnnarebZXvXndWOSTYu
KZzyGGEQectgllhsJw6DbYIMwQuZC5MpolU7y0RhBBQBaVsmmqmt7dXJZqlWV6dIgSSIJCQEmseI
H6O99nMenwFb+r9gt4bysLP/nmYQOn7R+f3+p3rSi7uhC7nHv+mZbuqftZ7L7sRdEhxQzzxb9Hx5
2tf4zM/k6dpPHdG070PBQf4Etu+7ZbstX4dbRuXVluOCI3ufmrQkxjlA999MxKSJ1c+UxLSns+QO
7/Fxj+YQWCsak9CvShpP4dmG5bKQXHr1+7DEwxOXo9tVUquNWJH3hRSU4eMSHxcDz6Skx04okbNk
drYKe0ZXQrXzrs8XRupbXc2kwk9ZKjlqgsl0dvRXU/BdJAmBDFOMQs65+23Lh36ywcX1/TOVOvOk
WuU14cLLqjHgXU36z7Nttttttttttt3RNjNf1pa9QvOhjBTUZ14S7tpaHKKrDtz57FkXLKzQZKCI
dzxGpDLPz3yhj5Z67Lv2saBV5x1ckBrT61rXLB93p2tztrbBP0O3dDsHccWLMQeZTuKiP18B8ZuY
BSZ8PdMn3QQnpthf9NT8MJSc2QioKeQSHczdDmgVAu99ZUO3R1qq/JB8I91IwvKlmF4wi7J2m43Z
N9aLTTytnm23hppg2kl5P53Lm+YOXbuFZ5i8EyjihcB5JZxdnKr49PO7aa5ZyGHMP3xXq2KEE2i4
7uyahy0Me0YND1jtfeuLCeI9YGRshQwrBwtb4dhwGtJwDK8XHNOOIbtyl1sSXAoQ+kjpMNILykIK
zYYhUDbdaRSAxg2BCIDBhIdHcY4mtaSFdNyPox7IP/G2bdSHHwfvJYLu20gtqIykmcD974/CCivU
yIZo9X0RVUunCFj31WOZGbmCDnGqxUwWjPlOvh4YoWcbHY6EUUhJvM2fxpsIjjvfpfmQPPWrT7Lb
k2vGy2J3Eu0CLIHYx5h2++4fXHtax5EvS8c24TUce1x/LXX21fbm5A2UHYvnPNzx05URG1ba7MZT
Xc6LjHht295+KpGV9Zli0SOCMggL1udqFT7/FttkohtyM53yVkj7t5sSldu3ehzp0o5PYzlzpoqv
7V5Ts3LbOI5NQr9r0n/N0pnwbxrLhqT15S8L51X6dImiuvLZOicrlIDog6LTgvRNJ5zXLuJe1GOJ
r06dWbDvhjXgsF3LZ454dHjXH40ZIZGTxhst6qMy7ctFEdvUYN0m2EG+B3705wYOxXrsfJg5yZgb
h0BtbaSGHEzV0dguihuJtpnJNcnpUihDFC0I13pSsGHOQDOaF3Q3xHWboAeoiPb1AzR7PCClarkA
Qcrfkiu2ktr9spXzUbKrViC+oXEFdYg6QTdEBObo6Ddi9jar3QxMowsz88F7FU1mBS40P8k7w7Vs
RbW2aoa2XGfBEGzvG8dhxQmbuE+17mc4j8MBMzAbxBiTfDo05yRRI6BcOddK4cOvA3STTGjZ73so
SyVKU8FJaDhaWMA18HsTUuG0QbjG21ZZzfwwYFis8SFOTiitRe2N21X+qN+NX3cttq3dU5KsrucV
FcJ4F724bBV53PFpitK27NQkMjZknfjA+Bo9olIwYMkoIcG+xvG8YXcpLvNIbCicd1Ft4EsGipYw
Y7UEfcMHoDyPLx7nL2Ojn3eL4S79lfC9nvl+xb7Y4uucteNnTLpp6c9vDPIsZddK65+lUOvBMO7u
7t/Lml/SBbS3XPRaq0t8GuXWej1fe21rrZJdu33XL7G/c47pJJJISSS5TtQTVqkmW222xjbb/PHG
W7lDK6Ldo8DMwnms9ovml+oVmunLjM69Jq3XtOGo99tVpemf6MPN47+nltye9cvDz9PT0vz+/EpY
b98nfuxx1ttnT3WXYYXX14cuXhfToPDpksNHG6UvTPsicO0Qg4oI61H2mfIS95CG5lxr/lPkIR8B
xtB1HPfri8pOHFVVXRA6JxwuTJTdJM3olTE4htsnRIk9dN49espym5SjL6B+za4X0a28dmXzNp5v
wPD1EGHmPP57taHVoueDZI4NHEsxYeHdBspi0KnUWhrxTJNI53gvK+cpSldZUrAhQQ7JMxmUn5oC
gSqYiqDTfw8vLXci3YRhv7vDw8KO7k+Wc5x0JRMM4hA6EhJBUPAgdenXpvFEy8Wr1265qTi5BQCV
6G1ve6nPeXlBBqXGBiYl4yohQ3BWWLlixRYsPYsWLElCBIWwcT3PltT9iSiZWA22MuDhsEhYLnAQ
WDidDIQcRshz5IUv7fqne1OVBsRMy7hHjUy6q/yhJrs1UVh5FixaJLWWCpV2ebX6j28IsSInTkG9
wa8dcbasQLJYjBoXCsWLgSUkldn6XuJ6wcjVVhaylOHloIRGnkcTxpkHlus7Sq2ynTjX6vjSfhd8
6L45b8TSSSUZ3s4uTMcOD9piZa4rmwhDDmETzoT0JT0+OZzukPV8vFttttwOnEKbMksQYkYqKFTf
Vkh5WGzJWLA3ZJvEMREM6WBYtRG5tEDwJACK7puEeeXtYfOPK0sK9niI2lTMyoacPe1ixMoSKm17
vl8e94EmAjQBfHt29/XbrZbYocZhbczMLbmZhbczFw3dTLd+GHGC6/LjMPjM5MlqQk0WcBfQ5KAI
TNerQzu7AGa/bid9O7u7xlTM8Jv63bZc5jyxVeCQ3hmSL6tGY/IhL88226ibSll9zYd+sUOfjcWO
mCCijv+E6K4Iro7uMwIO+L+sPLz/Qyd7vBQ/L3qqqpoya7rR8jLZOs6wQO8+d3vs922GlnPlfWnm
vsAXKhHnelpjOSSV1QKNktEYT0CQJZkTD2aMdIBRUgIgi7z3voBQheb7+wry2LZG4dxUqXuQDNkh
bHJqpzflwsbO2xz6BA0uE94maYfqehmmqCBggDiy4uLXfg9duaTbHhvgnX7nT47rWmeWHVe/vgLn
hXKHSw6RJYQiBoyWePPeYqeJboDYewwdYlRRkQIO/vlPqnfpVzrvZGyppHZAtIdghIjDb35djbpC
1CArnlrh2tEyS6ZOqkqHhYUPDFTs07hTiikCIGB8eLsHXhQa0LlqYktwCRMzLnZ6fXtt42Nw67RS
SXRstrnQ3UY5jPTQ5XUTjSGNwSDwE2XFd6pi7nVdyYaUl8BGESCPVWdtu6CbFFJRtNUkPKQnopra
sxobB5rskAe/rDHUZZBMUiUEiCCQYQY2mOKCZScJTDxEM/D3zKSEEuOZdjJ2DQMyDv8bhtZ4b6Lu
3DXvyuRbdKWk4bbQDEMSmJM4jEcRIL6xda0gV1rGIVBoCrne8+D1eVGexl8a33eiIi+lbWvn4AAP
p/XjM7M0oqqqrrSurYjODRDYkvd5euQpWQ5Q+7397vNJJvCvDprbv8C99xpgNeCaAyrW22yW22zt
pr74mUJhjouSyN2EHRiAst7JIk2Jr06lRVU0Q0Hfmp1UojzLaCHoBBQebVgYwxWWeekXDGt6LA8v
hMzKHlFILHQmuu/opXotCEd1WkqCgIvYXgUgbAGBJbCoiVUQHHbndx28eO+wVrayQQgyQNBLnFeM
yHtlCBtNDSjI1rmMZ+bP65fhunZQu/pNB5tFrDgrVGvEgyO2FXi5Wa8NYlzTS+YxTwYqRU8BqGcN
isQEgWEpScY+yAqDyGToIqSCJmDchClei5AKK2ng3Fy4CArNryb02PZ2YZpflg+j+bk+Tm7nNEnD
fs4cTJYQHM40+DrfmsLqpxMo7Q9fNP3srk79eTz8Za2ZurF8XuX/Q+3ivEf7SRAkwWQ3Dckuqpb1
Nn+SrxfgrKS0v0pyY6M42fCBW3t17lOzi491F8wCYDracBmMnf8vq+tfFCyyyyyUpppSX58gZ8hk
AaAAwmMrGTPEZuJHmWVbiIZMpDVEkExiYbwfX9T66Y7DPI2zA0utHjUKlfTocDXhA8yoPQDruPNr
aaydn5ja7gjRQzjBVBVBfgZz91Pps5UTGVmFuGzd+XpWBkYXSb6OPNxmuERip39xX44HWHG2ZoBf
gEjTTjLXYTRnqYmxs9BRSVLdKUVuR+TPZk6eXPhvKI624E58qlbmPHlT5mM7j1oq8vd8ZLGwL7Z8
MqcJ2unwx31ToidQkfZb1uqVJ6+83fFXKrdtUolFj8Xo222NNtt8r4p+HT5qygfc955BP1hSc5r3
C/qAbNkbnPNP076iUOHbgCkb6EP1dyqUEjFn8PFHO0+sWBLCk9NV9Kmpft47dmVmNWa7qny1E5D8
X6vaXHNi44ytZbe6DbHdF3c118g8oCTHJ4My8RPufh+Lrx8Ovdo2ZKLnd2F2TVRGKSdiraC9M9RM
712ZWta1tXQMv3/un15Z/SQQf9kkKbCKKG+bRU/PsYOYEuIjzpQhKogQFcQpaIq0lW1NpbTbVYlP
n59Q7za9DBgMGEUikHvh6PiPpG5W/4HP69aScMQkfAzg+jY+9i9hzBzSf7jI82a1WS5Uog/Bn3fi
ttp5mbRHcQ5JOjtE2YDevlm3LMkxiIH+4CfDigYAwvi8w60pwbEOBnACAtm0eVt8Bkd2SKE0QWzE
iZhMFIYHwdaNBiSOFqMD7lMXRT4/ZQ42eLkbU2C/Q7y378PDhrQzlfCmDFYEaYPYpxiVHvj7rZEo
7dY69dF1+XzuvtFtC8wCgUVCx45wAtePbjzx6R02OULC0ZzP9YANfpr7pc8PusrSOLR2L4QcmBKp
zdjklK6CJwRRQsXNiHyA2HQv211gr+xLixTYhF7ASMQTQJHPCcuuPavbvt38N9tzbAqY0OlKFKNB
5sMIhksdBOTDl2dMOJvRUC+ykDPHPM0UM8EzxdGgk23gFsZ2op4zkD0aukCSE2DfBQ5R6IXDKGUl
LtEIHXjgkIZUwehnwmkgRRpONAJ2zCRSmkUcFkIENoOcIjTzUBncVgskD22kuw1wgUWbg1FM0UHZ
AA0M6IVzd80YYMDMVoYMDAxQFmrkO26MJCgzKWRGVPVzvO+TADfhTYyR2240amZnu3uMdbOAeZrX
581w58Wd+RDbchsge1Bg2Dt4S02Wl+E56UUmWdHSjzsqMGucBt52qqaqvalWXOW1G1yAJSKraQYJ
O4kSR2AgCBE3HZVz23eYFGdFJ2FWLZsiy4K3LxiEc9loUzxYWragdff8/WtuRl+YOHsiPVLeGzNQ
gNhHEXDTu9EVBCY0gsbH3d+L8M6AduJ6hQAQ0kKH5kFqEtEpBWCSQEiUMBgUhlXj3+ZXqm6HnFoJ
o9lB2MtnI9KW9qoJrNPduy5QMZcprF3IkmZ2jZbey35umCbFSXmYGeXbiw2QzofOcU0MYoRRjoKY
4cZkHYqh+QogVNZoeH459+/l37+eVlllllllllnMx3bJDlpDWkiUMQxk+2JoGMFkYhttXAXbKohG
rpmXF3KeOmuA1yUFTfF2JmOddat1AB7XJzYb5My+Ily0Y++y/wwixN0dHuftmpbeG7viIkSlKIiU
529/d8ZoQqsQ3e/ZJNi8N/sc53c/a14uQHCIGJDumlRPgQX2QUIxWKQTn9Z6kT1qWWigXkZEUEkR
F3vsaUtspsm2pX9Ge692U26imT1E2JnjUa6V551vF426aLkG3NssSYa3yc2hiyDGEUgIbBhM2qpg
GQCCEIqKbKKJbaylaQREqmqbNpWJWv6narFJe8/U4c6ebzWaGzLUoSvbrVdPibtipeN00zL2u3Kp
rNsi+K7W12lU1LbYJNJKlUY/36mY9RYAFoFGCqMrDgpRZAETilOLQRkihLASAbGQoJHVqBtNq5bF
qUrYiumRLRWGpXpd67dNLWUTrq1uFI00zJG2g2QITvXYKiZYrRmVVGjYxbG5QxJzXmsK4IxSXWJZ
BSOCA7ptUe8qu008utq7JltGovbKtblrTNlkVaTW1pTIVJbRq0G0al7zdpLVd89tKqyGgggjFYqO
1sU4NEKW8mSKVL023TG+TeeXaLW9NbbmsSUpbNlNlZNaloAgwDGaGBDYQ0AiISLA2Da2YEglG541
y7/Q+Gfr31CQoPG2zQxnyov4/ryJe01kbIwkMXvDH0w10fNZWENZYYR8J2i1icXlTV0pLWBpNgSB
tjTaJLlIKS7m4isVeOISmr5fbTShMmLO6YOJ+rUA33/jboqkk2A7oZp67901RWNIj7hb/rvvEuDE
fPjrv19OVX8CmwHASkRgQQWKbgQTTEIRhTRy7pRQGj7mIhwzekb2GVJaFBcxGbA3Ew6daDAhIutG
1onVDUjhId0FckCCSOFCSWMO0MMzrS6s0wwpSFSQsiAQDRwG8Bwhit/1Q3tan5WzASIA2CAWlSbS
qIp1665xIMHuo7o/bMbGv09fDQ+NB3m2CYWMhnJpG6t6yH3B3G6a23FJ0+v1r21X4b+GMYxjGc5z
k37xgO9Ak340zfW1DjWKTAkDJSioqTwaI+2liAIk+CS6D5dtm9SXXkYIz2F3VbKVoq1k6rFQvsKG
7W0o7JqCQvbyWlLUQikUgwSDBjjgHNo9bJ8r/mnGQ+5iIvTCn00Uoe323tQz8dLNtidk0WFkBw+H
t6x3dqRZtDPXzv9Dux0jUEWNE2NMIB1BASdfbPdj4dPYWDd0dKYQJfCixcHvicMdtglEAJlApRrm
C0Cql8iIQDuhKBm3lVOZg0jjm17UzJHTtWHOlRTYMwqjMv/b8rKDTzhCKWJpNhfARW4GDBAav1tH
uUAxIJ2lzl8fZ+KMeswRnGBMXfFcKC94mTzzXZiPr5238EiYPcyhIYJE1bOE2ES4JISax5QrueL7
RA8bUeTIDuM7o006XGGchxTsZJJWvXtALxw63vhQhvCFCQbGuzQHbgkssiGWxoUthM6bSiYbGkCo
kQhFyYst0e6u+QbbDDpnRkuBRK7vgCRlCWsKECRWKkIQ1fsowZyk7qxJzk8rZNKrppawG7tvEE+c
cpYR5JMCoMLxQKGUnTraS61oMJECanLAyy993PnataYrci++SA4TgUDV6Y1wGEN9S8ukH0N6+fA5
0kmwhxsoGFPG3aoiZ4HmK1wd2KmLTTqbbA64lTVlQ643mkOcgGTz6zqvdkJDHSb7OMUdoH2OCn1U
gFD9kzVNwAQ6+DGhVhz5d3RQ1I86vaIipEpSiIkimgtdsb95AOBTYfRFxvjS4TvDLFE+a9+G8+bx
uwF01fQVeQkTCdeEcUTs4Ln3w4+yBu0tCF/I47KpTMK66oiCRwFuVRWznRnv1Sp21UxAt7QGk5yV
fV56cKq9CuR2aO2yCVsCoVnGHrCmWwJFaNva/uqp21KADHSgkkGoh8oiImbZo8pTEtsxZchQrGFJ
XfiMJsKtGuLJooBthN7NnaflxrrWDobsvavySEA1cIK5hJgk2G2MpCgNYzFT5cpOAWHGJuNKJijj
FEbiiaGSnTuM+9mujWK3CY0yOeRY25pVJZ54kcovuYbbDjCezkMMYGIAPItfz7UTYGalYVrcMhJh
SHb2qqqiq0ggWBoJJhJmKqiqq0koFgctEJoITqAMJkkGJa7VquM2KRvrPabKRDBvTPPPX1UwfSJh
0150JwyQzttZO1ILOQz0+m82LMyw5A+3nYeUQh692p3Z1IQ1M6mYePu491t2IZmW2xxqu2++bw7Z
NF54aFGttzljw0yb9Ae8RMUmUgYb9ltqYYV7I4wthkXdpt1VlBjZcBt/D3e72eB5j07u+dXBz4Vy
YnukD77rHJeU/xkur8ZDrqwwA6sp8T8yH8x7OA7z5Pr8fp+becb9mULVS0ZaiVtFO6buQzT0cKQ1
O6f4Y+RRu+z4bMTnNh0XJYmrHG3HHEK2gbE2HMLvjIJtCbJSmgP3BPDc3a19VKT8X4fy/8LttD+t
IvVohsnh9oPQwP8GlFjLH2oQe/YYKYGrgMyucigwcwEfgxeL19SbcfxD9DptNY8i2ScVwAbzmPFZ
A6MkkhItwAYRHIkQLvO9XjIRnTJGmoB6A0J+o/bnqUFlR/r7dhU0gQFuvpYXlQJFUy0nK0MViNtt
tttpbbbbbtC7H6inPnYBucSyMEAIisCCCAjbY0AxiaYL5ravXebyPb29vb28T2fWr33RP4u/40hU
pk4dLk/4ssgnlllll7i15EeunpJpylvTJzaj3QdRzSiaM7IcvMPfNfEfukUmU6oAhFNDYVDmhzib
kyXtALwlPWww2fvZY+rG3gWH/PxzPiFQMuvtbbHATNoxJLdwz0H3FKPl8tu02mIv6ac82/arU0MB
7g0GM3cePkTNBiFVsbbbxqpJJKEDrLsbiXfbGRBF4x2zyeAA8KP49jboj94tjBQkUGCsFRJNgh7w
1Zbq4jfDkKCEDJv4aSS2eUbxiKfvkcJWev6a0Zs8bkJRSBjUDNKkpBWzm0BrijffAjbwjlVVOoCl
FiD3Hkzz30h+fBpKtA5QjMV6YNl47AqJrwTNHo0Y1Vcg5+4BNEnb50Y48OMZIblyYP7iwzzp1O+8
cR1AIgBCMiBJvWtMxTbCtxuk6bI3K99PyoV3bqXwHfy6zM+7Z9lejcbc0vtIA+ALibpQ0QJtjTY0
HjECiIKKKJFEDQDANH9E5zr7/DxDXg0QNGjZxN3GDizjV118ar6VYyIvnc6KLbr76CdwO5+Z2cQM
NKQhYj2cZko0j56N5BbHQMZhjHs+wxmEmrqEUgQuAcytp3d9avfVXIwqtU+K2YBQh5Nj3fWQ9a8I
Eem6BP6LKMUFip64SSWW3IyQrUDSGAxjTgoKeAg7BTVoAExCaEHNpN7Dbj1+nDAXLik1XA449UH4
oAZes+IlTiFd0NEHsA8x+87rsvu6bzx8E+ScxMG0blAzJSpjBTMl9HIKeHBHpr0zY2m/g0Tnv8eV
nnXXXXwiXiM86fOj750PvnljIukLYOX31pBmFPugCX/GZXKfa4EdPNCFRQXpoPUVIsm7sPWjYZ87
8G0E/AbIaQ4SwX92MwiAPGpxjbXUbYspO9d6FUCDJAHiCDvBfgBqH9zL+HZ67ujfFEKM3bOHc1Vt
nbssKWmEIRKHI9Zu9CRB6PaHLYTse29ggy4xqEKIB8aQtOK1wALU1MPyHM+n2CAG7ePvdwYpS/V1
c0qA9/3ct7fYhH1JMwD285x4vil6qtenf0lnsApO1VV1yFns27ZqQ54dpxLLK+tk59xXRKhyU205
NYNQZKo8IdKsBkiRgIeVGJ05l6d3V6rxDJEtSI302WFPeNgCDt6g8IHtVfh9VolHo/b3l+4weWNc
moVI+v3VNjOcJa+Wnb6OvxSGwifh9FCAzJsZct/vVhUUcKCEEjI/Q5AdeZ9nw+X6vr/L9/x9Wqqs
5znWb3ve98YDebI68hA+C4Ax8a8j5mOQ/KBMGvz9hSKJXD7qw3dieW6sgyev2QkyGTPh+HMXOLf5
GIsCiuNpgiMMKHLkooqrE6wQ5nJ15SB24Y7QjR43A2JJWIpGVVItQfLtfJ5m8wdHtf+oXhm3sQiw
2geNU0bdsAlkZEABACgBiYoPbYJUNaEVC1va3xFoFqoFMzJEEEE22qro8J3MnYO57z8JTmYZi4LO
8QujVrUqYfV9ejCaCjB3wLul1jYXN7QHM+hRhCpFX9sftT4v0tKf3cJYPC9hKGThzdcVTKbykbDX
bek7yEEDqHd34KsJybu72is2sSUixo4phsxBqGwzlteWqZuG5qEZqUDChhSgmILORmjJaUXVvKcZ
buEIHbZn3Nr5eb6ohIpaF8wR8QhsOP8PKiR0Bcfj8fnb89NcYxrrrprrrrrrrt7Hq6d/n9qXd+gf
Q7fer+Gx3I/TwUpO06zUPOBgHKRZJGT2ApN5wOlsHLWwaZkqLRaLaiyLKQNFgHNdefwlVxA2S1D1
npzzt9Lu7u7vxLxmszMzMzN+cFBYKCqj1yyCoMIjxQ5IEllEeUT1NJVJ4sgzHVJirExp5nM7fvBd
XzUNmlIwQgxEgEUCEWZjak2s0W2irZUraNplKjUWDbSzVFZW2Wk0bIykTNZmsxkUSkVkQEf8iViw
nqO4nTzlPwfm+54eGZmbHsD3oXiIHGx5g/1/smWxJRuZt6xv3435nVpl7RoM2MAJGAoICX0eMOJe
XBSCbnOYtBboKcxQKYMaYA3ncyo7EBJFhyFQLyUGWBKdTB5+TmqJJGEyGJd2jZEMXQc2hxGcNRDk
FlbUnmdx77plXVaqeyaGruSCQPxzVgt3Lr4LaOtimOMlmRMHCDIyAZUa6tbvTw1aF+kMKLlIuBlw
wLA85LlJgCRGaZR1rUK0LhLNSksspMwPyaIVUDA4LbRtYViU/T6bqrT5aaWTu8k8QOs96snjKiPg
NHXE08ZhwY+NBrLNB0PNIRZ1LkrFH51gVii3q2YEL6KxSXpmdWgSEi+SUS2+k8xKeba7TCwMig4w
NnJktBWQ9IWmxqsllplCKZERKxMEsghSgJUKsazJbmOZcVh4Eh5JKwPLEhpDc5+lo+rLg5l21z54
uEyzn0/ghw3Pa2Np6aKTTIYgaYNkvdrqCxF9k/BUpLokG3sXXAUllV9NEsQSd8zjWQmJUi2WGFfT
g3/JP7JEkfP6FJv6XAXFWIZKlRbKxYkYK9hJ1Pjnr34Qxh4HAzxV9c6iWetULDrDQrAsxRDW2TEQ
Py9WPI0GDUZrUPWHnB5z3kjrS3JZI+pnls2+wMABgwXewEVrkRRI6F4QxNAbV2TPI8XFyY7mkyWF
tDj0sh9TpnkhSJEGLN6FLQpaFLQstkpaFLQpaTY7OYbHbt4oovtHkdnIiIiI+X6r5vL4i+nr6V9z
9hTSqDTU8+aJHkBeVfhMSC0uhIVzS5BnlIluPQ16fXijPbsqb+NHarY0SklO4gD5+0AOKFuukCol
vXoZDZy/HpR3lHaphw4QhMpcyktC6svqgBxyC3xSgqA3qSV822HXf3BGdLAY0IwJENDVfIMGYlYO
Jaue06KalWuTmVaWb7C1hx2h0aA/fMkB+3iVTRAs+w2o3ApDRFPJEwMQA6RbKUsCJ7ziPW9Krgyw
Wo/fJ9fyVd3d3dyru7u7u7ymY3qqbm2P0/Urm0p+h2+699GR75BqZfOWLYYAckzDRTRrgMCZfqlN
EtNyJoNbGWAhLMEPMgM7HA8Y9pFNJzXTmqVR3OA6+vy8mGBddVaGsbA7B9AGD6UHy9olI1A0Z32u
Ylfrzup5zzj5cm3Q+3u57b+fMno4EaGHZDWiBiBtJgCRCVQEiZmG1EHW2ZLeyL3vOrSBW7z8M7Ft
WVueZMUbbmhlSRlyKLkR6kOmxNfQaxzJPM5nwvFV5SqQXR8seBsKzovLiGli+s2N8Qkbj8C3M7U4
fdxjAOk7g6TsSDa7eTWC1BaGIgCIiQ+O4Iu3pJYiWq3tT22GPmcjT3SiPCIbx2YsVY+2byUDWQOO
4EsQmm96N7A2jinMxZXCmvwMb7tUtV8nUFo9IB3wN4DC3lHjq662xyxPnpdaA6WIfZppq0Op9202
8C6I8DI2QmkdDjg447OJ0h0yq2oCxRYPrqmyYwawjBIoV4rEFDEVdOOtYbWrsXTUoQQ6AcT5zEyW
INZtGYwXm1ove4sXLrT1V5RUpucYci04dh20YN9uix4sRKG1GfgzT+tt87t/fFNht7ptuMX0jei8
YeKZ6qUkJmuzCohwuO5BclpkJJFEOQYw0oeoEPEBTvJjO3QXhXQQlFAhVOumdNb01BZV01i6chPm
btiwXEkUIeine0jNYCILwDDim70pdNRMKibwZu9JnmKs7GBJ+LRlm+Pv9/u+pYfQgfDx1lEqobs+
X41TXBS72E4ZDFmZ19Vqx76HMa2MjuCfTB/dEKHeYGeHZnyvk5FzSsSLUCZA2hGzIGMHMKjKU/QP
MrzptVUbsUDofM9KLQLRnDm9F5cWx0OHOdIFBRxvuE9m78mBkg3MN+TQaEkyD56tx3FWTHyxw6kQ
F5WLNkSZOk2cN3rehXgTKBLfkNMwtgkZ2qxWj7VGv2PjozlEVBsIkycRMJlO4QGxIL0VByKRjOIa
uolcm02mlqW8EqNDCzWmEBUhDDeCxwsC68qK5d1pPiITgIRisPeL5V9b53r0JJddwkl13CJxaqMR
nQmGYrAWDgeYT/FP20mdYUPeMq33mo5lsuB9HM8fI2Eunde0vyAbQxjbVVVZIRJGdBVkQnh6sb4H
k9vb87yMSDhDiTKC0BxnBtHS+Mq0XQZ0B/GK70Du5Xomsklq+sumDX2/VrtoWlZSr1JdvavZijM7
XqZZWW0iJMpFLXlfga2u3kkmJGC2lC0pD4B5Dz9eZcxpiIlMMMvLT+Df1nvsOX5o1LMLKIsPASnj
cHpbfRRlb7n79pMcudH2X4GBsGJDIZwgESER0VRFJFIAAzkNFEiEGDHnteosO0U5fhTuN03Wa760
/DsWKNiwEkPWxKtotgCWRK1VgZacYf8lsts+i6slZUrGv+W4V9HqugKL4AruQRJHGWixQvmT+Mx7
Hi+VHqPooT2wHgJ8SIN/o/l10o2KTwJImzXa+rB3qL4vSh2BwOn2nxUXq9f/BRCOwqCh9++PFzqK
PL8cvOGcDvYlKgGJANKsGP3bLk2dsD/Hcu6R3du+QB2ZHhBUwsTEvcxBlInymlr2XNBdgbMZsmOO
/gNO+nZmO5kzci96xREUTVAMgBapw5YHQzCbiadv0oCUc1wT3duEuSfgqChuniUbIxA5EE3yI6zf
vxB2VF6g+KVuHfiJECSQgSBaH+tpQ2qfVt9G7m3SyoslksxSSo2MTEqWr5XVU63cqRTqWSljlg2W
VJQoMCyZjRyBKUsEpIiDQGYFcmAxwgsBgBDYGRUKERnxgS4cJEhTa3gU1MaW0waK6a/QsrtqEV+v
EOJaNRVASizlNagYsEC2oCzeCWzeDh3LxRDHGBlCy36viaNJvM+WRuQUINtXbTVZtLUmtNtNTJZW
pCrefemrqtNuuu3LmVOFYk5FBEzERjGwq27MMMspKlkttYBvLARmGYgEUgHzGibGGzYyskQwKBUL
SDKLGmzOrVmmxhzq7c66SSSSarKWr/FbqAqBIpESQ8/6wJ6g8g91olsPHwzMzIB9ig8/bDHaR2Z7
xoL4cWfU4Aep56gMB/8gRQOrkMVENPzoO3wDvtE6E3D0AYw2NfbTMuJm8q5cAzfQC2q8iqhB0LgC
HR0the75dwFQQNpcwq3jIf7NAhn6B3PMoPtAfl5HLoAeRZ1KF+4NUAN4B2IgOqquYUYhwAAaEgom
lQd/d1H8wEPPmxrbUilals2tPo3v7dul2R8EyYWUEYsD2+72ba1rWZmYsmxsjSkLKa5qC9CphTzN
GAVU9JlM8bVCziBRpqa3cf6YhoILGEUdN9l7gmiQ8FVwoO4xvyta7XJRVEqvlx09DBqRE6UAPFcu
KAEBeIAHOgxeEERudKi2CjcrVj8zxbr0pzcaK+4C1EBvUHt5h5xF/bVUK9EV0UDqX8XzQHJkDxD7
tgDh6GXOrSGKjuDhnQ7nkRdug2UDvjuINsVXd78FEPHFEUNPPvcKqhTxAUOK3jnnqQUNKmRSBeu/
bcoo2AhIHR2c962osibWZi0ymT51+X2rfOvgor5K/UEEuwCxRCV+mAespbOGrVUAme3I4qD5RTxK
goVvUA9lEBsxxV4og8z0wDhS4ex2gUaBRQ484oFpmPMcvc1L7dScoZN5XF17NKm6KIWDgN+UJBYr
ZKmrctrpts0ktL6mpIchaCjvhTSKqZIoLCRiiu9kNSoB+6BB2sEPVyAevwBEcjx8yuIABFB0xdgP
Cdd8/lyN5BkR0NKr0p4fDrQUNobwH5kAKMUMLTksoR/RfpDoe1lALlDvSABCC1aHJiQISVk2IwWh
wqWgYRuhlSqiaF04DnMgGiOUV1AOLO4gEEBhIjIkUDOsE1Jpb0QHFQMtyuhTE27BxBRQ6ENgxtdn
FVWv/CiGCH6cCq5UG0etTSGgzqAHHMJr5APueIo8giGwwRQ/KqAIsiCC7Ab22pvKBlNt2lzAhiqa
kBQfl+dKrK8yL7kU9ogB7QEH2oInvUU96gfkCayP9k9p/c3T6z13/y0LoSzRIhoKiEUjopR0QG8L
SiCFqFAf/F3JFOFCQ4Ihrsw=

--Boundary-00=_Ggs7Ai+Xvea+sdf--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
