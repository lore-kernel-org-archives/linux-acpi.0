From: David Abrahams <dave@boost-consulting.com>
Subject: USB resume problem with IBM dock
Date: Thu, 12 Oct 2006 00:02:42 -0400
Message-ID: <87lknmnpul.fsf@pereiro.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:61027 "EHLO
	smtp02.lnh.mail.rcn.net") by vger.kernel.org with ESMTP
	id S1422764AbWJLEC4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 00:02:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kristen.c.accardi@intel.com, linux-acpi@vger.kernel.org


Hi,

I hope I've come to the right place; I'm going based on the
information in my kernel's MAINTAINERS file.

I have been using suspend2 with a 2.6.18 kernel, my Thinkpad T60p, and
a Thinkpad Advanced dock.  When resuming (from disk), suspend2 puts
all the USB devices into a suspended state so they're consistent with
the state at suspend time.  If I have any devices plugged into the
dock's USB ports, it's very common that the devices fail to enter a
suspended state (or so the APIs report).  When that happens, suspend2
forces a segfault and all heck breaks loose (log excerpt appended) --
suffice it to say I lose my suspended state, all the filesystems need
to be checked, and often it takes an additional reboot just to make
everything healthy again -- so it's really important to me to address
this problem.  Please let me know if there's anything I can do to help
track this down.


Thanks,
Dave

--- /var/log/syslog excerpt ---

  Oct 11 22:11:40 pereiro kernel: [    7.004000] Atomic restore preparation
  Oct 11 22:11:40 pereiro kernel: [    7.008000] Freezing cpus ...
  Oct 11 22:11:40 pereiro kernel: [    7.080000] usb 5-6.1: new low speed USB device using ehci_hcd and address 5
  Oct 11 22:11:40 pereiro kernel: [    7.128000] CPU 1 is now offline
  Oct 11 22:11:40 pereiro kernel: [    7.128000] SMP alternatives: switching to UP code
  Oct 11 22:11:40 pereiro kernel: [    7.128000] CPU1 is down
  Oct 11 22:11:40 pereiro kernel: [    7.192000] usb 5-6.1: configuration #1 chosen from 1 choice
  Oct 11 22:11:40 pereiro kernel: [    7.392000] usb 5-6.2: new full speed USB device using ehci_hcd and address 6
  Oct 11 22:11:40 pereiro kernel: [    7.484000] usb 5-6.2: configuration #1 chosen from 1 choice
  Oct 11 22:11:40 pereiro kernel: [    7.484000] suspend_device(): usb_generic_suspend+0x0/0x15c [usbcore]() returns -16
  Oct 11 22:11:40 pereiro kernel: [    7.484000] usbcore: registered new driver hiddev
  Oct 11 22:11:40 pereiro kernel: [    7.484000] Could not suspend device 5-6: error -16
  Oct 11 22:11:40 pereiro kernel: [    7.492000] Some devices failed to suspend
  Oct 11 22:11:40 pereiro kernel: [    7.492000] ------------[ cut here ]------------
  Oct 11 22:11:40 pereiro kernel: [    7.492000] kernel BUG at kernel/power/atomic_copy.c:496!
  Oct 11 22:11:40 pereiro kernel: [    7.492000] invalid opcode: 0000 [#1]
  Oct 11 22:11:40 pereiro kernel: [    7.492000] PREEMPT SMP 
  Oct 11 22:11:40 pereiro kernel: [    7.492000] Modules linked in: usbhid dm_mod ide_generic ehci_hcd uhci_hcd usbcore piix generic sd_mod thermal processor fan fbcon tileblit font bitblit softcursor
  Oct 11 22:11:40 pereiro kernel: [    7.492000] CPU:    0
  Oct 11 22:11:40 pereiro kernel: [    7.492000] EIP:    0060:[suspend_atomic_restore+487/544]    Not tainted VLI
  Oct 11 22:11:40 pereiro kernel: [    7.492000] EFLAGS: 00010246   (2.6.18-local-20060823 #2) 
  Oct 11 22:11:40 pereiro kernel: [    7.492000] EIP is at suspend_atomic_restore+0x1e7/0x220
  Oct 11 22:11:40 pereiro kernel: [    7.492000] eax: 00004010   ebx: 00000000   ecx: 00000000   edx: 00000002
  Oct 11 22:11:40 pereiro kernel: [    7.492000] esi: 00000001   edi: 00000001   ebp: c0393270   esp: dfcadef0
  Oct 11 22:11:40 pereiro kernel: [    7.492000] ds: 007b   es: 007b   ss: 0068
  Oct 11 22:11:40 pereiro kernel: [    7.492000] Process busybox (pid: 2428, ti=dfcac000 task=c21ed290 task.ti=dfcac000)
  Oct 11 22:11:40 pereiro kernel: [    7.492000] Stack: c034fc04 c034cd8f 00000001 00000001 c014c6ee 00000000 c014c921 00000000 
  Oct 11 22:11:40 pereiro kernel: [    7.492000]        c014c7a7 c014e9f3 00000000 c13fb860 fffa8278 00000000 00000000 00000001 
  Oct 11 22:11:40 pereiro kernel: [    7.492000]        df802a40 00000001 00000001 df802a54 c01cc84c c03931b8 c0393270 dfdc3000 
  Oct 11 22:11:40 pereiro kernel: [    7.492000] Call Trace:
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  [suspend_resume+110/272] suspend_resume+0x6e/0x110
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  [suspend_start_anything+81/192] suspend_start_anything+0x51/0xc0
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  [__suspend_try_resume+23/48] __suspend_try_resume+0x17/0x30
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  [suspend2_attr_store+99/688] suspend2_attr_store+0x63/0x2b0
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  [sysfs_write_file+156/240] sysfs_write_file+0x9c/0xf0
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  [vfs_write+222/448] vfs_write+0xde/0x1c0
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  [sys_write+75/128] sys_write+0x4b/0x80
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  [syscall_call+7/11] syscall_call+0x7/0xb
  Oct 11 22:11:40 pereiro kernel: [    7.492000] Code: 16 00 0f 0b 13 02 74 cd 34 c0 83 c4 08 b8 01 00 00 00 5e 5f c3 c7 04 24 04 fc 34 c0 e8 23 5f fd ff a1 04 2d 39 c0 f6 c4 10 75 17 <0f> 0b f0 01 74 cd 34 c0 e9 6a fe ff ff e8 37 82 ff ff e9 47 fe 
  Oct 11 22:11:40 pereiro kernel: [    7.492000] EIP: [suspend_atomic_restore+487/544] suspend_atomic_restore+0x1e7/0x220 SS:ESP 0068:dfcadef0
  Oct 11 22:11:40 pereiro kernel: [    7.492000]  <6>JFS: nTxBlock = 8192, nTxLock = 65536


-- 
Dave Abrahams
Boost Consulting
www.boost-consulting.com
