From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to generic
 suspend functionality
Date: Sat, 05 Jun 2010 00:27:06 +0300
Message-ID: <1275686826.5034.3.camel@maxim-laptop>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
	 <1275230238.14907.8.camel@maxim-laptop>
	 <alpine.LFD.2.00.1006041508190.4073@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:58654 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab0FDV1M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 17:27:12 -0400
In-Reply-To: <alpine.LFD.2.00.1006041508190.4073@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Fri, 2010-06-04 at 15:11 -0400, Len Brown wrote: 
> > Since the other patch 'ACPI / EC / PM: Fix race between EC transactions
> > and system suspend' is now merged, this should be rebased on top of it
> > (I did the opposite....)
> 
> Maxim,
> Since your system needs both these fixes, and they are merged together
> in the acpi git tree, it would be great if you could test that tree
> and let me know if we got it right.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test

Done!
Works correctly.

Small unrelated note (this happened with my rebased version, yesterday,
while doing stress testing):
Can't think of why ioremap could fail... maybe memory allocation
failure, but seems strange.

<3>[ 1737.071949] ioremap error for 0x7fe99000-0x7fe9a000, requested 0x10, got 0x0
<1>[ 1737.071983] BUG: unable to handle kernel NULL pointer dereference at (null)
<1>[ 1737.071990] IP: [<ffffffff811d697b>] memcpy+0xb/0xb0
<4>[ 1737.072000] PGD 6e2be067 PUD 64a8d067 PMD 0 
<0>[ 1737.072007] Oops: 0000 [#1] PREEMPT SMP 
<0>[ 1737.072012] last sysfs file: /sys/power/state
<4>[ 1737.072017] CPU 0 
<4>[ 1737.072019] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat mmc_block af_packet snd_hda_codec_realtek usb_storage usb_libusual cpufreq_powersave snd_hda_intel cpufreq_conservative snd_hda_codec uvcvideo cpufreq_userspace r852 acpi_cpufreq mperf sm_common snd_hwdep nand iwl3945 iTCO_wdt videodev nand_ids v4l2_compat_ioctl32 sdhci_pci iwlcore nand_ecc tg3 uhci_hcd lirc_ene0100 iTCO_vendor_support snd_pcm joydev sdhci mac80211 ehci_hcd mmc_core battery sg ac video lirc_dev coretemp libphy mtd snd_page_alloc usbcore evdev psmouse cfg80211 serio_raw nouveau ttm drm_kms_helper drm i2c_algo_bit
<4>[ 1737.072085] 
<4>[ 1737.072089] Pid: 10027, comm: pm-suspend Not tainted 2.6.35-rc1+ #51 Nettiling/Aspire 5720     
<4>[ 1737.072095] RIP: 0010:[<ffffffff811d697b>]  [<ffffffff811d697b>] memcpy+0xb/0xb0
<4>[ 1737.072102] RSP: 0018:ffff880043029d80  EFLAGS: 00010246
<4>[ 1737.072107] RAX: ffff8800517bc000 RBX: ffff88006ff8aa40 RCX: 0000000000000200
<4>[ 1737.072112] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8800517bc000
<4>[ 1737.072116] RBP: ffff880043029d98 R08: 0000000000000000 R09: 0000000000000000
<4>[ 1737.072121] R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000003
<4>[ 1737.072126] R13: 00000000003fffff R14: ffffffff813ba4f8 R15: 0000000000000003
<4>[ 1737.072132] FS:  00007f953038f700(0000) GS:ffff880002400000(0000) knlGS:0000000000000000
<4>[ 1737.072137] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
<4>[ 1737.072142] CR2: 0000000000000000 CR3: 000000006f35b000 CR4: 00000000000006f0
<4>[ 1737.072147] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<4>[ 1737.072152] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
<4>[ 1737.072157] Process pm-suspend (pid: 10027, threadinfo ffff880043028000, task ffff88003e730000)
<0>[ 1737.072162] Stack:
<4>[ 1737.072165]  ffffffff8108225d 0000000000000000 0000000000000000 ffff880043029db8
<4>[ 1737.072171] <0> ffffffff81213432 0000000000000010 0000000000000000 ffff880043029dd8
<4>[ 1737.072179] <0> ffffffff812135e0 0000000000000003 0000000000000000 ffff880043029e08
<0>[ 1737.072187] Call Trace:
<4>[ 1737.072193]  [<ffffffff8108225d>] ? suspend_nvs_save+0x4d/0x70
<4>[ 1737.072199]  [<ffffffff81213432>] __acpi_pm_prepare+0x1b/0x2e
<4>[ 1737.072205]  [<ffffffff812135e0>] acpi_pm_prepare+0xe/0x1f
<4>[ 1737.072212]  [<ffffffff8107d618>] suspend_devices_and_enter+0x108/0x220
<4>[ 1737.072219]  [<ffffffff8107d85a>] enter_state+0x12a/0x150
<4>[ 1737.072225]  [<ffffffff8107ce61>] state_store+0x91/0x100
<4>[ 1737.072231]  [<ffffffff811cd9d7>] kobj_attr_store+0x17/0x20
<4>[ 1737.072238]  [<ffffffff81144e02>] sysfs_write_file+0xf2/0x170
<4>[ 1737.072245]  [<ffffffff810dce78>] vfs_write+0xb8/0x170
<4>[ 1737.072253]  [<ffffffff813a1c2a>] ? lockdep_sys_exit_thunk+0x35/0x67
<4>[ 1737.072259]  [<ffffffff810dd00c>] sys_write+0x4c/0x80
<4>[ 1737.072266]  [<ffffffff81002deb>] system_call_fastpath+0x16/0x1b
<0>[ 1737.072271] Code: 89 70 58 19 c0 41 c6 40 4c 04 83 e0 fc 83 c0 08 41 88 40 4d c9 c3 90 90 90 90 90 90 90 90 90 90 48 89 f8 89 d1 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3 a4 c3 8b 1e 4c 8b 46 08 4c 89 1f 4c 89 47 08 
<1>[ 1737.072321] RIP  [<ffffffff811d697b>] memcpy+0xb/0xb0
<4>[ 1737.072327]  RSP <ffff880043029d80>
<0>[ 1737.072330] CR2: 0000000000000000
<4>[ 1737.073047] ---[ end trace c49c9aa5a3d831e9 ]---
<0>[ 1737.073052] Kernel panic - not syncing: Fatal exception
<4>[ 1737.073057] Pid: 10027, comm: pm-suspend Tainted: G      D     2.6.35-rc1+ #51
<4>[ 1737.073062] Call Trace:
<4>[ 1737.073067]  [<ffffffff8139e3c7>] panic+0x90/0x10a
<4>[ 1737.073073]  [<ffffffff8100737c>] oops_end+0xcc/0xe0
<4>[ 1737.073079]  [<ffffffff81027c13>] no_context+0xf3/0x260
<4>[ 1737.073086]  [<ffffffff8106c25e>] ? put_lock_stats+0xe/0x30
<4>[ 1737.073092]  [<ffffffff81027e95>] __bad_area_nosemaphore+0x115/0x1d0
<4>[ 1737.073098]  [<ffffffff81027fa9>] bad_area+0x49/0x60
<4>[ 1737.073103]  [<ffffffff810281c4>] ? do_page_fault+0xe4/0x390
<4>[ 1737.073109]  [<ffffffff8102840f>] do_page_fault+0x32f/0x390
<4>[ 1737.073115]  [<ffffffff811dc60f>] ? debug_check_no_obj_freed+0x17f/0x200
<4>[ 1737.073122]  [<ffffffff81098130>] ? call_rcu+0x10/0x20
<4>[ 1737.073128]  [<ffffffff810d8d13>] ? put_object+0x33/0x50
<4>[ 1737.073134]  [<ffffffff8102b0fd>] ? free_memtype+0xdd/0x140
<4>[ 1737.073140]  [<ffffffff813a2fdf>] page_fault+0x1f/0x30
<4>[ 1737.073146]  [<ffffffff811d697b>] ? memcpy+0xb/0xb0
<4>[ 1737.073152]  [<ffffffff8108225d>] ? suspend_nvs_save+0x4d/0x70
<4>[ 1737.073157]  [<ffffffff81213432>] __acpi_pm_prepare+0x1b/0x2e
<4>[ 1737.073163]  [<ffffffff812135e0>] acpi_pm_prepare+0xe/0x1f
<4>[ 1737.073169]  [<ffffffff8107d618>] suspend_devices_and_enter+0x108/0x220
<4>[ 1737.073175]  [<ffffffff8107d85a>] enter_state+0x12a/0x150
<4>[ 1737.073181]  [<ffffffff8107ce61>] state_store+0x91/0x100
<4>[ 1737.073187]  [<ffffffff811cd9d7>] kobj_attr_store+0x17/0x20
<4>[ 1737.073192]  [<ffffffff81144e02>] sysfs_write_file+0xf2/0x170
<4>[ 1737.073199]  [<ffffffff810dce78>] vfs_write+0xb8/0x170
<4>[ 1737.073204]  [<ffffffff813a1c2a>] ? lockdep_sys_exit_thunk+0x35/0x67
<4>[ 1737.073211]  [<ffffffff810dd00c>] sys_write+0x4c/0x80
<4>[ 1737.073217]  [<ffffffff81002deb>] system_call_fastpath+0x16/0x1b
<3>[ 1737.073231] [drm:drm_fb_helper_panic] *ERROR* panic occurred, switching back to text console
<0>[ 1737.073296] Rebooting in 20 seconds..
maxim@maxim-laptop:~$ 


