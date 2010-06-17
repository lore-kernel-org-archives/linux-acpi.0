From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Battery related crash on resume
Date: Thu, 17 Jun 2010 12:38:00 +0300
Message-ID: <1276767480.5627.0.camel@maxim-laptop>
References: <1276460976.2659.3.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:40470 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795Ab0FQJiL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2010 05:38:11 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1924167fga.1
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2010 02:38:10 -0700 (PDT)
In-Reply-To: <1276460976.2659.3.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2010-06-13 at 23:29 +0300, Maxim Levitsky wrote: 
> Just got this:
> 
> Suspended the system, inserted battery (to charge it), walked away for a
> hour, resumed the system:
> 
> I use 2.6.35-rc3 + linux-acpi-next/release + wireless-testing/master +
> few my own patches.
> 
> <6>[ 2763.330466] [drm] nouveau 0000:01:00.0: 0xB6F9: parsing clock script 1
> <6>[ 2763.533828] ata3: SATA link down (SStatus 0 SControl 300)
> <6>[ 2763.552678] ata2: SATA link down (SStatus 0 SControl 300)
> <6>[ 2763.570498] ata4.00: configured for UDMA/33
> <0>[ 2763.650740] ------------[ cut here ]------------
> <2>[ 2763.650751] kernel BUG at /home/maxim/software/kernel/linux-2.6/kernel/workqueue.c:312!
> <0>[ 2763.650762] invalid opcode: 0000 [#1] PREEMPT SMP 
> <0>[ 2763.650772] last sysfs file: /sys/power/state
> <4>[ 2763.650779] CPU 0 
> <4>[ 2763.650784] Modules linked in: lirc_ene0100 af_packet iwl3945 iwlcore uvcvideo videodev mac80211 snd_hda_codec_realtek v4l2_compat_ioctl32 usb_storage uhci_hcd snd_hda_intel usb_libusual ehci_hcd snd_hda_codec joydev usbcore cpufreq_powersave tg3 cfg80211 cpufreq_conservative snd_hwdep r852 sdhci_pci sdhci psmouse cpufreq_userspace snd_pcm acpi_cpufreq mperf iTCO_wdt iTCO_vendor_support mmc_core libphy sm_common nand video coretemp ac nand_ids nand_ecc mtd snd_page_alloc sg battery lirc_dev serio_raw evdev nouveau ttm drm_kms_helper drm i2c_algo_bit
> <4>[ 2763.650886] 
> <4>[ 2763.650893] Pid: 145, comm: kacpi_notify Not tainted 2.6.35-rc3+ #73 Nettiling/Aspire 5720     
> <4>[ 2763.650904] RIP: 0010:[<ffffffff81056424>]  [<ffffffff81056424>] queue_work_on+0x44/0x50
> <4>[ 2763.650923] RSP: 0018:ffff88006ffa7cd0  EFLAGS: 00010213
> <4>[ 2763.650931] RAX: ffff88006c273908 RBX: ffff88006fc195a0 RCX: 0000000000000000
> <4>[ 2763.650941] RDX: ffff88006c273900 RSI: ffff88006fc195a0 RDI: 0000000000000000
> <4>[ 2763.650950] RBP: ffff88006ffa7cd0 R08: 0000000000000000 R09: 0000000000000000
> <4>[ 2763.650959] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88006c273900
> <4>[ 2763.650968] R13: 0000000000000081 R14: ffffffff81211889 R15: ffff88006ffb0000
> <4>[ 2763.650979] FS:  0000000000000000(0000) GS:ffff880002400000(0000) knlGS:0000000000000000
> <4>[ 2763.650989] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> <4>[ 2763.650998] CR2: 00007f9073d926b0 CR3: 000000000155d000 CR4: 00000000000006f0
> <4>[ 2763.651007] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> <4>[ 2763.651016] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> <4>[ 2763.651026] Process kacpi_notify (pid: 145, threadinfo ffff88006ffa6000, task ffff88006ffb0000)
> <0>[ 2763.651036] Stack:
> <4>[ 2763.651040]  ffff88006ffa7cf0 ffffffff81056479 ffff88006c273898 ffff88006fc3e000
> <4>[ 2763.651052] <0> ffff88006ffa7d00 ffffffff810564c3 ffff88006ffa7d30 ffffffff812c6d1e
> <4>[ 2763.651065] <0> ffff88006fc3e000 0000000000000081 ffffffff81211889 ffff88006c273800
> <0>[ 2763.651079] Call Trace:
> <4>[ 2763.651089]  [<ffffffff81056479>] queue_work+0x29/0x60
> <4>[ 2763.651099]  [<ffffffff810564c3>] schedule_work+0x13/0x20
> <4>[ 2763.651111]  [<ffffffff812c6d1e>] power_supply_changed+0x1e/0x70
> <4>[ 2763.651124]  [<ffffffff81211889>] ? acpi_os_execute_deferred+0x0/0x31
> <4>[ 2763.651140]  [<ffffffffa006b6de>] acpi_battery_notify+0x76/0x7e [battery]
> <4>[ 2763.651152]  [<ffffffff812148da>] acpi_device_notify+0x14/0x16
> <4>[ 2763.651163]  [<ffffffff81223244>] acpi_ev_notify_dispatch+0x62/0x7a
> <4>[ 2763.651175]  [<ffffffff812118ad>] acpi_os_execute_deferred+0x24/0x31
> <4>[ 2763.651186]  [<ffffffff81055eb0>] worker_thread+0x220/0x390
> <4>[ 2763.651197]  [<ffffffff81055e5e>] ? worker_thread+0x1ce/0x390
> <4>[ 2763.651209]  [<ffffffff8105ace0>] ? autoremove_wake_function+0x0/0x40
> <4>[ 2763.651221]  [<ffffffff81055c90>] ? worker_thread+0x0/0x390
> <4>[ 2763.651231]  [<ffffffff8105a85e>] kthread+0xae/0xc0
> <4>[ 2763.651244]  [<ffffffff81003b94>] kernel_thread_helper+0x4/0x10
> <4>[ 2763.651255]  [<ffffffff8105a7b0>] ? kthread+0x0/0xc0
> <4>[ 2763.651265]  [<ffffffff81003b90>] ? kernel_thread_helper+0x0/0x10
> <0>[ 2763.651273] Code: 75 29 44 8b 46 20 45 85 c0 75 24 48 8b 06 48 63 ff 48 89 d6 48 03 04 fd 20 3a 5b 81 48 89 c7 e8 03 ff ff ff b8 01 00 00 00 c9 c3 <0f> 0b eb fe 8b 3d 92 d8 55 00 eb d4 55 48 89 f2 48 89 e5 48 8b 
> <1>[ 2763.651351] RIP  [<ffffffff81056424>] queue_work_on+0x44/0x50
> <4>[ 2763.651362]  RSP <ffff88006ffa7cd0>
> <4>[ 2763.655505] ---[ end trace 67498c368c7e7da0 ]---
> <0>[ 2763.655514] Kernel panic - not syncing: Fatal exception
> <4>[ 2763.655523] Pid: 145, comm: kacpi_notify Tainted: G      D     2.6.35-rc3+ #73
> <4>[ 2763.655532] Call Trace:
> <4>[ 2763.655543]  [<ffffffff8139fb38>] panic+0x90/0x10a
> <4>[ 2763.655554]  [<ffffffff8100737c>] oops_end+0xcc/0xe0
> <4>[ 2763.655563]  [<ffffffff81007586>] die+0x56/0x90
> <4>[ 2763.655574]  [<ffffffff81004364>] do_trap+0xc4/0x170
> <4>[ 2763.655585]  [<ffffffff81211889>] ? acpi_os_execute_deferred+0x0/0x31
> <4>[ 2763.655597]  [<ffffffff81211889>] ? acpi_os_execute_deferred+0x0/0x31
> <4>[ 2763.655607]  [<ffffffff81004810>] do_invalid_op+0x90/0xb0
> <4>[ 2763.655618]  [<ffffffff81056424>] ? queue_work_on+0x44/0x50
> <4>[ 2763.655629]  [<ffffffff813a41d3>] ? _raw_spin_unlock_irqrestore+0x33/0x60
> <4>[ 2763.655640]  [<ffffffff810304be>] ? __wake_up+0x4e/0x70
> <4>[ 2763.655651]  [<ffffffff81003a15>] invalid_op+0x15/0x20
> <4>[ 2763.655662]  [<ffffffff81211889>] ? acpi_os_execute_deferred+0x0/0x31
> <4>[ 2763.655673]  [<ffffffff81056424>] ? queue_work_on+0x44/0x50
> <4>[ 2763.655684]  [<ffffffff81056479>] queue_work+0x29/0x60
> <4>[ 2763.655694]  [<ffffffff810564c3>] schedule_work+0x13/0x20
> <4>[ 2763.655704]  [<ffffffff812c6d1e>] power_supply_changed+0x1e/0x70
> <4>[ 2763.655716]  [<ffffffff81211889>] ? acpi_os_execute_deferred+0x0/0x31
> <4>[ 2763.655730]  [<ffffffffa006b6de>] acpi_battery_notify+0x76/0x7e [battery]
> <4>[ 2763.655742]  [<ffffffff812148da>] acpi_device_notify+0x14/0x16
> <4>[ 2763.655752]  [<ffffffff81223244>] acpi_ev_notify_dispatch+0x62/0x7a
> <4>[ 2763.655764]  [<ffffffff812118ad>] acpi_os_execute_deferred+0x24/0x31
> <4>[ 2763.655775]  [<ffffffff81055eb0>] worker_thread+0x220/0x390
> <4>[ 2763.655785]  [<ffffffff81055e5e>] ? worker_thread+0x1ce/0x390
> <4>[ 2763.655797]  [<ffffffff8105ace0>] ? autoremove_wake_function+0x0/0x40
> <4>[ 2763.655808]  [<ffffffff81055c90>] ? worker_thread+0x0/0x390
> <4>[ 2763.655818]  [<ffffffff8105a85e>] kthread+0xae/0xc0
> <4>[ 2763.655830]  [<ffffffff81003b94>] kernel_thread_helper+0x4/0x10
> <4>[ 2763.655840]  [<ffffffff8105a7b0>] ? kthread+0x0/0xc0
> <4>[ 2763.655851]  [<ffffffff81003b90>] ? kernel_thread_helper+0x0/0x10
> <3>[ 2763.655880] [drm:drm_fb_helper_panic] *ERROR* panic occurred, switching back to text console
> <0>[ 2763.655904] Rebooting in 20 seconds..

Just happened again with same conditions.

Best regards,
Maxim Levitsky


