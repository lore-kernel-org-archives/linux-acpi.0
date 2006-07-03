From: <Rezwanul_Kabir@Dell.com>
Subject: Suspend/Resume (S3) issue on Dell M65 mobile precision
Date: Mon, 3 Jul 2006 01:30:27 -0500
Message-ID: <915F78A6712D2B4CAD03815A2917EF4EE4E287@ausx3mpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:37167 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750810AbWGCGa3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2006 02:30:29 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi

I am investigating power management support on Dell Mobile Precisions and found the following suspend-to-RAM issue on M65 system with 2.6.16.23 kernel.

Summary of the issue: I ran a script to suspend the system from the text console. In order to eliminate issues with in-kernel agpgart driver and Frame buffer driver, I booted the system with agp=off and console=normal. I also rmmod all usb drivers before going to suspend. The system successfully goes to sleep and the LED blinks slowly as expected. But when 
the system wakes up ( by pressing power button) the screen remains blank. However, I have verified that the system is in working state by SSHing into the system. I am guessing its some sort of video initialization issue but would like to know if you guys have 
any suggestions that I might try.

I'm providing /var/log/messages and output of lspci both before the suspend and when it wakes up with blank screen.I can provide disassembled DSDT table or any other information that anyone needs to understand the issue.

   Thanks in advance..
      -rez



1. Below is the /var/log/messages after enabling some debug options:

   Jul  3 00:11:57 localhost kernel: Freezing cpus ...
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 0
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 3
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 4
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 5
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 7
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 8
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 9
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 11
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 12
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 13
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 16
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 17
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 19
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 22
Jul  3 00:11:57 localhost kernel: Breaking affinity for irq 23
Jul  3 00:11:57 localhost kernel: CPU 1 is now offline
Jul  3 00:14:20 localhost kernel: CPU1 is down
Jul  3 00:14:20 localhost kernel: Stopping tasks: ====================================================|
Jul  3 00:14:20 localhost kernel: wakeup_devices-0032 [-805] enable_wakeup_device_p: ----Entry
Jul  3 00:14:20 localhost kernel: pnp: Device 00:0b disabled.
Jul  3 00:14:20 localhost kernel: wakeup_devices-0065 [-804] enable_wakeup_device  : ----Entry
Jul  3 00:14:20 localhost kernel: Intel machine check architecture supported.
Jul  3 00:14:20 localhost kernel: Intel machine check reporting enabled on CPU#0.
Jul  3 00:14:20 localhost kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul  3 00:14:20 localhost kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
Jul  3 00:14:20 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul  3 00:14:20 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
Jul  3 00:14:21 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
Jul  3 00:14:21 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
Jul  3 00:14:21 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
Jul  3 00:14:21 localhost kernel: tg3: eth0: Link is down.
Jul  3 00:14:21 localhost kernel: ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 19
Jul  3 00:14:21 localhost kernel: Yenta O2: res at 0x94/0xD4: 00/ea
Jul  3 00:14:21 localhost kernel: Yenta O2: enabling read prefetch/write burst
Jul  3 00:14:21 localhost kernel: ACPI: PCI Interrupt 0000:03:01.4[A] -> GSI 19 (level, low) -> IRQ 19
Jul  3 00:14:21 localhost kernel: pnp: Device 00:04 does not supported activation.
Jul  3 00:14:21 localhost kernel: pnp: Device 00:05 does not supported activation.
Jul  3 00:14:21 localhost kernel: pnp: Device 00:0b activated.
Jul  3 00:14:21 localhost kernel: ata1: dev 0 configured for UDMA/100
Jul  3 00:14:21 localhost kernel: Restarting tasks... done
Jul  3 00:14:21 localhost kernel: Thawing cpus ...
Jul  3 00:14:21 localhost kernel: Booting processor 1/1 eip 3000
Jul  3 00:14:21 localhost kernel: CPU 1 irqstacks, hard=c043b000 soft=c041b000
Jul  3 00:14:21 localhost kernel: Initializing CPU#1
Jul  3 00:14:21 localhost kernel: Debug: sleeping function called from invalid context at mm/page_alloc.c:918
Jul  3 00:14:21 localhost kernel: in_atomic():0, irqs_disabled():1
Jul  3 00:14:21 localhost kernel:  [<c0148838>] __alloc_pages+0x31/0x28d
Jul  3 00:14:21 localhost kernel:  [<c01224a3>] printk+0x14/0x18
Jul  3 00:14:21 localhost kernel:  [<c0148af6>] get_zeroed_page+0x31/0x3d
Jul  3 00:14:21 localhost kernel:  [<c0109492>] cpu_init+0x101/0x310
Jul  3 00:14:21 localhost kernel:  [<c0114fc1>] start_secondary+0xc/0x3c3
Jul  3 00:14:21 localhost kernel:  [<c01153e3>] cpu_exit_clear+0x22/0x4b
Jul  3 00:14:21 localhost kernel: Leaving ESR disabled.
Jul  3 00:14:21 localhost kernel: Calibrating delay using timer specific routine.. 4322.97 BogoMIPS (lpj=8645948)
Jul  3 00:14:21 localhost kernel: monitor/mwait feature present.
Jul  3 00:14:21 localhost kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Jul  3 00:14:21 localhost kernel: CPU: L2 cache: 2048K
Jul  3 00:14:21 localhost kernel: CPU: Physical Processor ID: 0
Jul  3 00:14:21 localhost kernel: CPU: Processor Core ID: 1
Jul  3 00:14:21 localhost kernel: Intel machine check architecture supported.
Jul  3 00:14:21 localhost kernel: Intel machine check reporting enabled on CPU#1.
Jul  3 00:14:21 localhost kernel: CPU1: Intel Genuine Intel(R) CPU           T2600  @ 2.16GHz stepping 08
Jul  3 00:14:21 localhost kernel: CPU1 is up
Jul  3 00:14:21 localhost kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Jul  3 00:14:21 localhost kernel: tg3: eth0: Flow control is on for TX and on for RX.
Jul  3 00:14:21 localhost kernel: wakeup_devices-0112    event-0051 [-799] system_read_event     : ----Entry
Jul  3 00:14:21 localhost kernel:    event-0084 [-799] system_read_event     : ----Exit- 0000000000000001
Jul  3 00:14:21 localhost kernel:    event-0051 [-799] system_read_event     : ----Entry

<snip>

Jul  3 00:14:24 localhost kernel:    event-0084 [-799] system_read_event     : ----Exit- 0000000000000001
Jul  3 00:14:24 localhost kernel: [-800] disable_wakeup_device : ----Entry
Jul  3 00:14:24 localhost kernel: USB Universal Host Controller Interface driver v2.3
Jul  3 00:14:24 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
Jul  3 00:14:24 localhost kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000bf80
Jul  3 00:14:25 localhost kernel: usb usb1: configuration #1 chosen from 1 choice
Jul  3 00:14:25 localhost kernel: hub 1-0:1.0: USB hub found
Jul  3 00:14:25 localhost kernel: hub 1-0:1.0: 2 ports detected
Jul  3 00:14:25 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 21
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000bf60
Jul  3 00:14:25 localhost kernel: usb usb2: configuration #1 chosen from 1 choice
Jul  3 00:14:25 localhost kernel: hub 2-0:1.0: USB hub found
Jul  3 00:14:25 localhost kernel: hub 2-0:1.0: 2 ports detected
Jul  3 00:14:25 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 22 (level, low) -> IRQ 22
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.2: irq 22, io base 0x0000bf40
Jul  3 00:14:25 localhost kernel: usb usb3: configuration #1 chosen from 1 choice
Jul  3 00:14:25 localhost kernel: hub 3-0:1.0: USB hub found
Jul  3 00:14:25 localhost kernel: hub 3-0:1.0: 2 ports detected
Jul  3 00:14:25 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 23
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
Jul  3 00:14:25 localhost kernel: uhci_hcd 0000:00:1d.3: irq 23, io base 0x0000bf20
Jul  3 00:14:25 localhost kernel: usb usb4: configuration #1 chosen from 1 choice
Jul  3 00:14:25 localhost kernel: hub 4-0:1.0: USB hub found
Jul  3 00:14:25 localhost kernel: hub 4-0:1.0: 2 ports detected
Jul  3 00:14:25 localhost kernel: usb 1-2: new full speed USB device using uhci_hcd and address 2
Jul  3 00:14:25 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
Jul  3 00:14:25 localhost kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jul  3 00:14:25 localhost kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jul  3 00:14:25 localhost kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
Jul  3 00:14:25 localhost kernel: ehci_hcd 0000:00:1d.7: irq 20, io mem 0xffa80000
Jul  3 00:14:25 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jul  3 00:14:25 localhost kernel: usb usb5: configuration #1 chosen from 1 choice
Jul  3 00:14:25 localhost kernel: hub 5-0:1.0: USB hub found
Jul  3 00:14:25 localhost kernel: hub 5-0:1.0: 8 ports detected
Jul  3 00:14:25 localhost kernel: Bluetooth: HCI USB driver ver 2.9
Jul  3 00:14:25 localhost kernel: usb 1-2: device not accepting address 2, error -71
Jul  3 00:14:25 localhost kernel: usbcore: registered new driver hci_usb
Jul  3 00:14:25 localhost kernel: ACPI: PCI Interrupt 0000:03:01.4[A] -> GSI 19 (level, low) -> IRQ 19
Jul  3 00:14:25 localhost kernel: ohci1394: fw-host0: Unexpected PCI resource length of 1000!
Jul  3 00:14:25 localhost kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[dcbff000-dcbff7ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
Jul  3 00:14:25 localhost kernel: usb 1-2: new full speed USB device using uhci_hcd and address 4
Jul  3 00:14:25 localhost kernel: usb 1-2: configuration #1 chosen from 1 choice
Jul  3 00:14:25 localhost kernel: hub 1-2:1.0: USB hub found
Jul  3 00:14:25 localhost kernel: hub 1-2:1.0: 4 ports detected
Jul  3 00:14:26 localhost kernel: usb 2-1: new full speed USB device using uhci_hcd and address 2
Jul  3 00:14:26 localhost kernel: usb 2-1: configuration #1 chosen from 1 choice
Jul  3 00:14:26 localhost kernel: hub 2-1:1.0: USB hub found
Jul  3 00:14:26 localhost kernel: hub 2-1:1.0: 3 ports detected
Jul  3 00:14:26 localhost kernel: usb 1-2.3: new full speed USB device using uhci_hcd and address 5
Jul  3 00:14:26 localhost kernel: usb 1-2.3: configuration #1 chosen from 1 choice
Jul  3 00:14:26 localhost hcid[1930]: HCI dev 0 registered
Jul  3 00:14:26 localhost hcid[1930]: HCI dev 0 up
Jul  3 00:14:26 localhost hcid[1930]: Starting security manager 0
Jul  3 00:14:26 localhost kernel: usb 2-1.1: new full speed USB device using uhci_hcd and address 3
Jul  3 00:14:27 localhost kernel: usb 2-1.1: configuration #1 chosen from 1 choice
Jul  3 00:14:27 localhost kernel: usb 2-1.2: new full speed USB device using uhci_hcd and address 4
Jul  3 00:14:27 localhost kernel: usb 2-1.2: configuration #1 chosen from 1 choice
Jul  3 00:15:02 localhost kernel:    event-0051 [-855] system_read_event     : ----Entry

<snip>

Jul  3 00:15:03 localhost kernel:    event-0084 [-855] system_read_event     : ----Exit- 0000000000000001
Jul  3 00:15:03 localhost shutdown[2851]: shutting down for system halt
Jul  3 00:15:03 localhost init: Switching to runlevel: 0
Jul  3 00:15:04 localhost avahi-daemon[2223]: Got SIGTERM, quitting.
Jul  3 00:15:04 localhost avahi-daemon[2223]: Leaving mDNS multicast group on interface eth0.IPv4 with address 192.168.1.51.
Jul  3 00:15:05 localhost smartd[2086]: smartd received signal 15: Terminated 
Jul  3 00:15:05 localhost smartd[2086]: smartd is exiting (exit status 0) 
Jul  3 00:15:06 localhost hcid[1930]: Got disconnected from the system message bus
Jul  3 00:15:06 localhost rpc.statd[1877]: Caught signal 15, un-registering and exiting.
Jul  3 00:15:06 localhost kernel: Kernel logging (proc) stopped.
Jul  3 00:15:06 localhost kernel: Kernel log daemon terminating.
Jul  3 00:15:07 localhost hcid[1930]: Can't open system message bus connection: Failed to connect to socket /var/run/dbus/system_bus_socket: Connection refused
Jul  3 00:15:07 localhost hcid[1930]: Can't open system message bus connection: Failed to connect to socket /var/run/dbus/system_bus_socket: Connection refused
Jul  3 00:15:08 localhost exiting on signal 15
Jul  3 00:21:11 localhost syslogd 1.4.1: restart.
Jul  3 00:21:12 localhost kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul  3 00:21:12 localhost kernel: ct libusual: registering. parent: <NULL>, set: module
Jul  3 00:21:12 localhost kernel: audit: initializing netlink socket (disabled)
Jul  3 00:21:12 localhost kernel: audit(1151885761.096:1): initialized
Jul  3 00:21:12 localhost kernel: highmem bounce pool size: 64 pages
Jul  3 00:21:12 localhost kernel: Total HugeTLB memory allocated, 0
Jul  3 00:21:12 localhost kernel: VFS: Disk quotas dquot_6.5.1
Jul  3 00:21:12 localhost kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Jul  3 00:21:12 localhost kernel: SELinux:  Registering netfilter hooks
Jul  3 00:21:12 localhost kernel: Initializing Cryptographic API
Jul  3 00:21:12 localhost kernel: io scheduler noop registered
Jul  3 00:21:12 localhost kernel: io scheduler anticipatory registered
Jul  3 00:21:12 localhost kernel: io scheduler deadline registered
Jul  3 00:21:12 localhost kernel: io scheduler cfq registered (default)
Jul  3 00:21:13 localhost rpc.statd[1868]: Version 1.0.8-rc2 Starting
Jul  3 00:21:14 localhost rpc.statd[1868]: gethostbyname error for localhost.localdomain
Jul  3 00:21:15 localhost kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul  3 00:21:15 localhost kernel: assign_interrupt_mode Found MSI capability
Jul  3 00:21:16 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul  3 00:21:16 localhost kernel: assign_interrupt_mode Found MSI capability
Jul  3 00:21:16 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
Jul  3 00:21:16 localhost kernel: assign_interrupt_mode Found MSI capability
Jul  3 00:21:17 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
Jul  3 00:21:17 localhost kernel: assign_interrupt_mode Found MSI capability
Jul  3 00:21:17 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
Jul  3 00:21:17 localhost kernel: assign_interrupt_mode Found MSI capability
Jul  3 00:21:17 localhost kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jul  3 00:21:17 localhost kernel: tbinstal-0125 [19] tb_install_table      : ----Entry
Jul  3 00:21:17 localhost kernel:  tbutils-0074 [20] tb_is_table_installed : ----Entry
Jul  3 00:21:17 localhost kernel:  tbutils-0119 [20] tb_is_table_installed : ----Exit- AE_OK
Jul  3 00:21:17 localhost kernel: tbinstal-0246 [20] tb_init_table_descript: ----Entry 00000005
Jul  3 00:21:17 localhost kernel: tbinstal-0339 [20] tb_init_table_descript: ----Exit- AE_OK
Jul  3 00:21:17 localhost kernel: tbinstal-0156 [19] tb_install_table      : SSDT located at f7d5fa2c
Jul  3 00:21:17 localhost kernel: tbinstal-0160 [19] tb_install_table      : ----Exit- AE_OK
Jul  3 00:21:17 localhost kernel: tbinstal-0125 [19] tb_install_table      : ----Entry
Jul  3 00:21:17 localhost kernel:  tbutils-0074 [20] tb_is_table_installed : ----Entry
Jul  3 00:21:17 localhost kernel:  tbutils-0119 [20] tb_is_table_installed : ----Exit- AE_OK
Jul  3 00:21:17 localhost kernel: tbinstal-0246 [20] tb_init_table_descript: ----Entry 00000005
Jul  3 00:21:17 localhost kernel: tbinstal-0339 [20] tb_init_table_descript: ----Exit- AE_OK
Jul  3 00:21:17 localhost kernel: tbinstal-0156 [19] tb_install_table      : SSDT located at f7d43aa0
Jul  3 00:21:17 localhost kernel: tbinstal-0160 [19] tb_install_table      : ----Exit- AE_OK
Jul  3 00:21:17 localhost kernel: ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Jul  3 00:21:17 localhost kernel: ACPI: Processor [CPU0] (supports 8 throttling states)
Jul  3 00:21:17 localhost kernel: tbinstal-0125 [19] tb_install_table      : ----Entry
Jul  3 00:21:17 localhost kernel:  tbutils-0074 [20] tb_is_table_installed : ----Entry
Jul  3 00:21:17 localhost kernel:  tbutils-0119 [20] tb_is_table_installed : ----Exit- AE_OK
Jul  3 00:21:17 localhost kernel: tbinstal-0246 [20] tb_init_table_descript: ----Entry 00000005
Jul  3 00:21:17 localhost kernel: tbinstal-0339 [20] tb_init_table_descript: ----Exit- AE_OK
Jul  3 00:21:17 localhost hcid[1921]: Bluetooth HCI daemon
Jul  3 00:21:17 localhost kernel: tbinstal-0156 [19] tb_install_table      : SSDT located at f7d26080
Jul  3 00:21:17 localhost kernel: tbinstal-0160 [19] tb_install_table      : ----Exit- AE_OK
Jul  3 00:21:17 localhost hcid[1921]: HCI dev 0 up
Jul  3 00:21:17 localhost sdpd[1924]: Bluetooth SDP daemon 
Jul  3 00:21:17 localhost kernel: tbinstal-0125 [19] tb_install_table      : ----Entry
Jul  3 00:21:18 localhost hcid[1921]: Starting security manager 0
Jul  3 00:21:18 localhost kernel:  tbutils-0074 [20] tb_is_table_installed : ----Entry
Jul  3 00:21:18 localhost kernel:  tbutils-0119 [20] tb_is_table_installed : ----Exit- AE_OK
Jul  3 00:21:18 localhost kernel: tbinstal-0246 [20] tb_init_table_descript: ----Entry 00000005
Jul  3 00:21:18 localhost kernel: tbinstal-0339 [20] tb_init_table_descript: ----Exit- AE_OK
Jul  3 00:21:18 localhost kernel: tbinstal-0156 [19] tb_install_table      : SSDT located at f7d4ae5c
Jul  3 00:21:18 localhost kernel: tbinstal-0160 [19] tb_install_table      : ----Exit- AE_OK
Jul  3 00:21:18 localhost kernel: ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
Jul  3 00:21:18 localhost kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
Jul  3 00:21:18 localhost kernel: ACPI: Thermal Zone [THM] (48 C)
Jul  3 00:21:18 localhost kernel: isapnp: Scanning for PnP cards...
Jul  3 00:21:18 localhost kernel: isapnp: No Plug & Play device found
Jul  3 00:21:18 localhost kernel: Real Time Clock Driver v1.12ac
Jul  3 00:21:18 localhost kernel: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Jul  3 00:21:18 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul  3 00:21:18 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul  3 00:21:18 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Jul  3 00:21:18 localhost kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
Jul  3 00:21:18 localhost kernel: 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul  3 00:21:18 localhost kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Jul  3 00:21:18 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul  3 00:21:18 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul  3 00:21:18 localhost kernel: ide0: I/O resource 0x1F0-0x1F7 not free.
Jul  3 00:21:18 localhost kernel: ide0: ports already in use, skipping probe
Jul  3 00:21:18 localhost kernel: hdc: HL-DT-STCD-RW/DVD-ROM GCC-4244N, ATAPI CD/DVD-ROM drive
Jul  3 00:21:18 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul  3 00:21:18 localhost kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Jul  3 00:21:18 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Jul  3 00:21:18 localhost kernel: ide-floppy driver 0.99.newide
Jul  3 00:21:18 localhost kernel: ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 19
Jul  3 00:21:18 localhost kernel: Yenta: CardBus bridge found at 0000:03:01.0 [1028:01c8]
Jul  3 00:21:18 localhost kernel: Yenta O2: res at 0x94/0xD4: 00/ea
Jul  3 00:21:18 localhost kernel: Yenta O2: enabling read prefetch/write burst
Jul  3 00:21:18 localhost kernel: Yenta: ISA IRQ mask 0x0cb8, PCI irq 19
Jul  3 00:21:18 localhost kernel: Socket status: 30000006
Jul  3 00:21:18 localhost kernel: pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
Jul  3 00:21:18 localhost kernel: cs: IO port probe 0x2000-0x2fff: clean.
Jul  3 00:21:18 localhost kernel: pcmcia: parent PCI bridge Memory window: 0xdcb00000 - 0xdcbfffff
Jul  3 00:21:18 localhost kernel: pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
Jul  3 00:21:18 localhost hidd[1974]: Bluetooth HID daemon
Jul  3 00:21:19 localhost kernel: usbcore: registered new driver libusual
Jul  3 00:21:19 localhost kernel: usbcore: registered new driver hiddev
Jul  3 00:21:19 localhost kernel: usbcore: registered new driver usbhid
Jul  3 00:21:19 localhost kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Jul  3 00:21:19 localhost kernel: mice: PS/2 mouse device common for all mice
Jul  3 00:21:19 localhost kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul  3 00:21:19 localhost kernel: md: bitmap version 4.39
Jul  3 00:21:19 localhost kernel: NET: Registered protocol family 2
Jul  3 00:21:19 localhost smartd[2074]: smartd version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce Allen 
Jul  3 00:21:19 localhost kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Jul  3 00:21:19 localhost kernel: input: PS/2 Mouse as /class/input/input1
Jul  3 00:21:19 localhost kernel: input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
Jul  3 00:21:19 localhost kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul  3 00:21:19 localhost kernel: TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
Jul  3 00:21:19 localhost kernel: TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
Jul  3 00:21:19 localhost kernel: TCP: Hash tables configured (established 131072 bind 65536)
Jul  3 00:21:19 localhost kernel: TCP reno registered
Jul  3 00:21:19 localhost kernel: TCP bic registered
Jul  3 00:21:19 localhost kernel: Initializing IPsec netlink socket
Jul  3 00:21:19 localhost kernel: NET: Registered protocol family 1
Jul  3 00:21:19 localhost kernel: NET: Registered protocol family 17
Jul  3 00:21:19 localhost smartd[2074]: Home page is http://smartmontools.sourceforge.net/  
Jul  3 00:21:19 localhost smartd[2074]: Opened configuration file /etc/smartd.conf 
Jul  3 00:21:19 localhost smartd[2074]: Configuration file /etc/smartd.conf parsed. 
Jul  3 00:21:19 localhost kernel: Using IPI No-Shortcut mode
Jul  3 00:21:19 localhost smartd[2074]: Device: /dev/sda, opened 
Jul  3 00:21:19 localhost smartd[2074]: Device: /dev/sda, not found in smartd database. 
Jul  3 00:21:19 localhost kernel: ACPI wakeup devices: 
Jul  3 00:21:19 localhost kernel:  LID PBTN PCI0 USB0 USB1 USB2 USB3 EHCI AZAL PCIE RP01 RP02  NIC RP04 RP05 RP06 
Jul  3 00:21:19 localhost kernel: ACPI: (supports S0 S3 S4 S5)
Jul  3 00:21:19 localhost smartd[2074]: Device: /dev/sda, is SMART capable. Adding to "monitor" list. 
Jul  3 00:21:19 localhost kernel: Freeing unused kernel memory: 212k freed
Jul  3 00:21:19 localhost smartd[2074]: Monitoring 1 ATA and 0 SCSI devices 
Jul  3 00:21:19 localhost kernel: Write protecting the kernel read-only data: 407k
Jul  3 00:21:19 localhost smartd[2077]: smartd has fork()ed into background mode. New PID=2077. 
Jul  3 00:21:20 localhost kernel: SCSI subsystem initialized
Jul  3 00:21:20 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
Jul  3 00:21:20 localhost kernel: ata: 0x170 IDE port busy
Jul  3 00:21:20 localhost kernel: ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
Jul  3 00:21:20 localhost kernel: ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
Jul  3 00:21:20 localhost kernel: ata1: dev 0 configured for UDMA/100
Jul  3 00:21:20 localhost kernel: scsi0 : ata_piix
Jul  3 00:21:20 localhost hpiod: 0.9.11 accepting connections at 50000... 
Jul  3 00:21:20 localhost kernel:   Vendor: ATA       Model: Hitachi HTS54108  Rev: MB4O
Jul  3 00:21:20 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Jul  3 00:21:20 localhost kernel: SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Jul  3 00:21:20 localhost kernel: sda: Write Protect is off
Jul  3 00:21:20 localhost kernel: SCSI device sda: drive cache: write back
Jul  3 00:21:20 localhost kernel: SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Jul  3 00:21:20 localhost kernel: sda: Write Protect is off
Jul  3 00:21:20 localhost kernel: SCSI device sda: drive cache: write back
Jul  3 00:21:20 localhost kernel:  sda: sda1 sda2
Jul  3 00:21:20 localhost kernel: sd 0:0:0:0: Attached scsi disk sda
Jul  3 00:21:20 localhost kernel: device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
Jul  3 00:21:21 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jul  3 00:21:21 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul  3 00:21:21 localhost kernel: SELinux:  Disabled at runtime.
Jul  3 00:21:21 localhost kernel: SELinux:  Unregistering netfilter hooks
Jul  3 00:21:21 localhost kernel: hw_random: cannot enable RNG, aborting
Jul  3 00:21:21 localhost kernel: tg3.c:v3.49 (Feb 2, 2006)
Jul  3 00:21:21 localhost kernel: ACPI: PCI Interrupt 0000:09:00.0[A] -> GSI 18 (level, low) -> IRQ 18
Jul  3 00:21:21 localhost kernel: eth0: Tigon3 [partno(BCM5752KFBG) rev 6002 PHY(5752)] (PCI Express) 10/100/1000BaseT Ethernet 00:15:c5:07:bc:91
Jul  3 00:21:21 localhost kernel: eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
Jul  3 00:21:21 localhost kernel: eth0: dma_rwctrl[76180000] dma_mask[64-bit]
Jul  3 00:21:21 localhost kernel: cs: IO port probe 0x100-0x3af: clean.
Jul  3 00:21:21 localhost kernel: cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3ff
Jul  3 00:21:21 localhost kernel: cs: IO port probe 0x820-0x8ff: clean.
Jul  3 00:21:21 localhost kernel: cs: IO port probe 0xc00-0xcf7: clean.
Jul  3 00:21:21 localhost kernel: cs: IO port probe 0xa00-0xaff: clean.
Jul  3 00:21:21 localhost kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Jul  3 00:21:21 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
Jul  3 00:21:21 localhost kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jul  3 00:21:21 localhost kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jul  3 00:21:21 localhost kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Jul  3 00:21:21 localhost kernel: ehci_hcd 0000:00:1d.7: irq 20, io mem 0xffa80000
Jul  3 00:21:21 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jul  3 00:21:21 localhost kernel: usb usb1: configuration #1 chosen from 1 choice
Jul  3 00:21:21 localhost kernel: hub 1-0:1.0: USB hub found
Jul  3 00:21:21 localhost kernel: hub 1-0:1.0: 8 ports detected
Jul  3 00:21:21 localhost kernel: USB Universal Host Controller Interface driver v2.3
Jul  3 00:21:21 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
Jul  3 00:21:21 localhost kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jul  3 00:21:21 localhost kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Jul  3 00:21:21 localhost kernel: uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000bf80
Jul  3 00:21:22 localhost kernel: usb usb2: configuration #1 chosen from 1 choice
Jul  3 00:21:22 localhost kernel: hub 2-0:1.0: USB hub found
Jul  3 00:21:22 localhost kernel: hub 2-0:1.0: 2 ports detected
Jul  3 00:21:22 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 21
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000bf60
Jul  3 00:21:22 localhost kernel: usb usb3: configuration #1 chosen from 1 choice
Jul  3 00:21:22 localhost kernel: hub 3-0:1.0: USB hub found
Jul  3 00:21:22 localhost kernel: hub 3-0:1.0: 2 ports detected
Jul  3 00:21:22 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 22 (level, low) -> IRQ 22
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.2: irq 22, io base 0x0000bf40
Jul  3 00:21:22 localhost kernel: usb usb4: configuration #1 chosen from 1 choice
Jul  3 00:21:22 localhost kernel: hub 4-0:1.0: USB hub found
Jul  3 00:21:22 localhost kernel: hub 4-0:1.0: 2 ports detected
Jul  3 00:21:22 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 23
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Jul  3 00:21:22 localhost kernel: uhci_hcd 0000:00:1d.3: irq 23, io base 0x0000bf20
Jul  3 00:21:22 localhost kernel: usb usb5: configuration #1 chosen from 1 choice
Jul  3 00:21:22 localhost kernel: hub 5-0:1.0: USB hub found
Jul  3 00:21:22 localhost kernel: hub 5-0:1.0: 2 ports detected
Jul  3 00:21:22 localhost kernel: ACPI: PCI Interrupt 0000:03:01.4[A] -> GSI 19 (level, low) -> IRQ 19
Jul  3 00:21:22 localhost kernel: ohci1394: fw-host0: Unexpected PCI resource length of 1000!
Jul  3 00:21:22 localhost kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[dcbff000-dcbff7ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
Jul  3 00:21:22 localhost kernel: usb 2-2: new full speed USB device using uhci_hcd and address 2
Jul  3 00:21:22 localhost kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
Jul  3 00:21:23 localhost kernel: usb 2-2: configuration #1 chosen from 1 choice
Jul  3 00:21:23 localhost kernel: hub 2-2:1.0: USB hub found
Jul  3 00:21:23 localhost kernel: hub 2-2:1.0: 4 ports detected
Jul  3 00:21:23 localhost kernel: usb 3-1: new full speed USB device using uhci_hcd and address 2
Jul  3 00:21:23 localhost kernel: usb 3-1: configuration #1 chosen from 1 choice
Jul  3 00:21:23 localhost kernel: hub 3-1:1.0: USB hub found
Jul  3 00:21:23 localhost kernel: hub 3-1:1.0: 3 ports detected
Jul  3 00:21:23 localhost kernel: usb 2-2.3: new full speed USB device using uhci_hcd and address 3
Jul  3 00:21:23 localhost kernel: Non-volatile memory driver v1.2
Jul  3 00:21:23 localhost kernel: usb 2-2.3: configuration #1 chosen from 1 choice
Jul  3 00:21:23 localhost kernel: Floppy drive(s): fd0 is 1.44M
Jul  3 00:21:23 localhost kernel: Bluetooth: Core ver 2.8
Jul  3 00:21:23 localhost kernel: NET: Registered protocol family 31
Jul  3 00:21:23 localhost kernel: Bluetooth: HCI device and connection manager initialized
Jul  3 00:21:23 localhost kernel: Bluetooth: HCI socket layer initialized
Jul  3 00:21:23 localhost kernel: usb 3-1.1: new full speed USB device using uhci_hcd and address 3
Jul  3 00:21:23 localhost kernel: Bluetooth: HCI USB driver ver 2.9
Jul  3 00:21:23 localhost kernel: lp: driver loaded but no devices found
Jul  3 00:21:23 localhost kernel: usb 3-1.1: configuration #1 chosen from 1 choice
Jul  3 00:21:23 localhost kernel: ACPI: AC Adapter [AC] (on-line)
Jul  3 00:21:23 localhost kernel: usb 3-1.2: new full speed USB device using uhci_hcd and address 4
Jul  3 00:21:23 localhost kernel: usb 3-1.2: configuration #1 chosen from 1 choice
Jul  3 00:21:23 localhost kernel: ACPI: Battery Slot [BAT0] (battery present)
Jul  3 00:21:23 localhost kernel: usbcore: registered new driver hci_usb
Jul  3 00:21:23 localhost kernel: ACPI: Battery Slot [BAT1] (battery absent)
Jul  3 00:21:23 localhost kernel: ACPI: Lid Switch [LID]
Jul  3 00:21:23 localhost kernel: ACPI: Power Button (CM) [PBTN]
Jul  3 00:21:23 localhost kernel: ACPI: Sleep Button (CM) [SBTN]
Jul  3 00:21:23 localhost kernel: Using specific hotkey driver
Jul  3 00:21:24 localhost kernel: ibm_acpi: ec object not found
Jul  3 00:21:24 localhost kernel: ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
Jul  3 00:21:24 localhost kernel: ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
Jul  3 00:21:24 localhost kernel: ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
Jul  3 00:21:24 localhost kernel: md: Autodetecting RAID arrays.
Jul  3 00:21:24 localhost kernel: md: autorun ...
Jul  3 00:21:24 localhost kernel: md: ... autorun DONE.
Jul  3 00:21:24 localhost kernel: EXT3 FS on dm-0, internal journal
Jul  3 00:21:24 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jul  3 00:21:24 localhost kernel: EXT3 FS on sda1, internal journal
Jul  3 00:21:24 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul  3 00:21:24 localhost kernel: Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2031608k
Jul  3 00:21:24 localhost kernel: floppy0: no floppy controllers found
Jul  3 00:21:24 localhost kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Jul  3 00:21:24 localhost kernel: tg3: eth0: Flow control is on for TX and on for RX.
Jul  3 00:21:24 localhost kernel: Bluetooth: L2CAP ver 2.8
Jul  3 00:21:24 localhost kernel: Bluetooth: L2CAP socket layer initialized
Jul  3 00:21:24 localhost kernel: Bluetooth: RFCOMM socket layer initialized
Jul  3 00:21:24 localhost kernel: Bluetooth: RFCOMM TTY layer initialized
Jul  3 00:21:24 localhost kernel: Bluetooth: RFCOMM ver 1.7
Jul  3 00:21:24 localhost kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Jul  3 00:21:24 localhost python: hpssd [ERROR] Server exited with error: Unable to bind to socket
Jul  3 00:21:25 localhost kernel: NET: Registered protocol family 10
Jul  3 00:21:25 localhost kernel: lo: Disabled Privacy Extensions
Jul  3 00:21:25 localhost kernel: IPv6 over IPv4 tunneling driver
Jul  3 00:21:25 localhost gpm[2135]: *** info [startup.c(95)]: 
Jul  3 00:21:25 localhost gpm[2135]: Started gpm successfully. Entered daemon mode.


2. Here's the the output of `lspci -vvv` before suspend:

00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev 03)
	Subsystem: Dell Unknown device 01c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics Port (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dd000000-dfefffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 1, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
	Subsystem: Dell Unknown device 01c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at dfffc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 2, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dcf00000-dcffffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 3, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dce00000-dcefffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 4, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=0d, subordinate=0e, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: dcc00000-dcdfffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000d0100000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 5, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at bf80 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at bf60 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 22
	Region 4: I/O ports at bf40 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 4: I/O ports at bf20 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ffa80000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: dcb00000-dcbfffff
	Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 01)
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01) (prog-if 80 [Master])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at bfa0 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 3
	Region 4: I/O ports at 10c0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation Unknown device 01dc (rev a1) (prog-if 00 [VGA])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at de000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at df000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <256ns, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 128 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

03:01.0 CardBus bridge: O2 Micro, Inc. Unknown device 7135 (rev 21)
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dcb00000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 52000000-53fff000
	I/O window 0: 00002000-000020ff
	I/O window 1: 00002400-000024ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

03:01.4 FireWire (IEEE 1394): O2 Micro, Inc. Unknown device 00f7 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size 10
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dcbff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at dcbfe800 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5752 Gigabit Ethernet PCI Express (rev 02)
	Subsystem: Dell Unknown device 01c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at dcef0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: ffbffefdf7ff26d8  Data: ffff
	Capabilities: [d0] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 512 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <2us, L1 <64us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Virtual Channel

0c:00.0 Network controller: Intel Corporation Unknown device 4222 (rev 02)
	Subsystem: Intel Corporation Unknown device 1020
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at dcfff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <64us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 51-b7-4f-ff-ff-02-13-00


3. Here's the output of `lspci -vvv` when I ssh into the system after wakeup 
 (with blank screen):

00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev 03)
	Subsystem: Dell Unknown device 01c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics Port (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dd000000-dfefffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 1, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
	Subsystem: Dell Unknown device 01c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at dfffc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 2, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dcf00000-dcffffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 3, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dce00000-dcefffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 4, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=0d, subordinate=0e, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: dcc00000-dcdfffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000d0100000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 5, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at bf80 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at bf60 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 22
	Region 4: I/O ports at bf40 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 4: I/O ports at bf20 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ffa80000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: dcb00000-dcbfffff
	Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 01)
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01) (prog-if 80 [Master])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at bfa0 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 3
	Region 4: I/O ports at 10c0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation Unknown device 01dc (rev a1) (prog-if 00 [VGA])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at de000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at df000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <256ns, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 128 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

03:01.0 CardBus bridge: O2 Micro, Inc. Unknown device 7135 (rev 21)
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dcb00000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 52000000-53fff000
	I/O window 0: 00002000-000020ff
	I/O window 1: 00002400-000024ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

03:01.4 FireWire (IEEE 1394): O2 Micro, Inc. Unknown device 00f7 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Dell Unknown device 01c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size 10
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dcbff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at dcbfe800 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5752 Gigabit Ethernet PCI Express (rev 02)
	Subsystem: Dell Unknown device 01c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at dcef0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: ff3ffefff7ff26d8  Data: fffb
	Capabilities: [d0] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 512 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <2us, L1 <64us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Virtual Channel

0c:00.0 Network controller: Intel Corporation Unknown device 4222 (rev 02)
	Subsystem: Intel Corporation Unknown device 1020
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at dcfff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <64us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 51-b7-4f-ff-ff-02-13-00




  


