From: Dave Jones <davej@redhat.com>
Subject: battery unplug related oops. (2.6.24-rc3-git1)
Date: Mon, 26 Nov 2007 22:27:41 -0500
Message-ID: <20071127032741.GA3337@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58149 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851AbXK0D1n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Nov 2007 22:27:43 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lAR3RgUl022189
	for <linux-acpi@vger.kernel.org>; Mon, 26 Nov 2007 22:27:42 -0500
Received: from gelk.kernelslacker.org (vpn-14-143.rdu.redhat.com [10.11.14.143])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAR3Rg1g030646
	for <linux-acpi@vger.kernel.org>; Mon, 26 Nov 2007 22:27:42 -0500
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.14.1/8.13.8) with ESMTP id lAR3Rfck008024
	for <linux-acpi@vger.kernel.org>; Mon, 26 Nov 2007 22:27:41 -0500
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.14.1/8.14.1/Submit) id lAR3RfJk008023
	for linux-acpi@vger.kernel.org; Mon, 26 Nov 2007 22:27:41 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

https://bugzilla.redhat.com/show_bug.cgi?id=399111

Looks like a use-after-free ..


BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
printing eip: c050a0c5 *pde = 00000000 
Oops: 0000 [#1] SMP 
Modules linked in: i915 drm rfcomm l2cap bluetooth autofs4 ipv6 ipt_REJECT
nf_conntrack_ipv4 xt_state nf_conntrack xt_tcpudp iptable_filter ip_tables
x_tables cpufreq_ondemand acpi_cpufreq dm_mirror dm_mod snd_intel8x0
snd_seq_dummy snd_intel8x0m snd_ac97_codec ac97_bus snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm
ipw2200 ieee80211 ieee80211_crypt video snd_timer output snd button tg3 battery
iTCO_wdt ac power_supply soundcore iTCO_vendor_support joydev snd_page_alloc
pcspkr dcdbas sg ata_piix pata_acpi ata_generic libata sd_mod scsi_mod ext3 jbd
mbcache uhci_hcd ohci_hcd ehci_hcd

Pid: 66, comm: kacpi_notify Not tainted (2.6.24-0.41.rc3.git1.fc9 #1)
EIP: 0060:[<c050a0c5>] EFLAGS: 00010246 CPU: 0
EIP is at strlen+0xb/0x15
EAX: 00000000 EBX: c4d89548 ECX: ffffffff EDX: 000000d0
ESI: 000000d0 EDI: 6b6b6b6b EBP: df092ec8 ESP: df092ec4
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
Process kacpi_notify (pid: 66, ti=df092000 task=df07ae10 task.ti=df092000)
Stack: c4d89548 df092ee4 c0505df4 c0750860 00000001 00000000 c0750860 d60c3000 
       df092f34 c0506504 00000000 00000000 cf64f400 c7e7e044 c4d89548 c06f7958 
       00000001 e019c918 c07508e4 fffffff4 df0788e1 c7e7e014 00000000 00000014 
Call Trace:
 [<c040649a>] show_trace_log_lvl+0x1a/0x2f
 [<c040654a>] show_stack_log_lvl+0x9b/0xa3
 [<c04065f9>] show_registers+0xa7/0x178
 [<c04067f0>] die+0x126/0x211
 [<c0643542>] do_page_fault+0x553/0x631
 [<c0641be2>] error_code+0x72/0x78
 [<c0505df4>] kobject_get_path+0x21/0x89
 [<c0506504>] kobject_uevent_env+0xa0/0x36e
 [<c05067dc>] kobject_uevent+0xa/0xc
 [<e01cea0b>] acpi_battery_notify+0x76/0x7c [battery]
 [<c0534c26>] acpi_ev_notify_dispatch+0x4f/0x5a
 [<c052f3f5>] acpi_os_execute_notify+0x24/0x2f
 [<c043da7d>] run_workqueue+0xd9/0x1ac
 [<c043e599>] worker_thread+0xbb/0xc6
 [<c0441373>] kthread+0x3b/0x64
 [<c0405f1f>] kernel_thread_helper+0x7/0x10
 =======================
Code: 5d c3 55 89 e5 56 89 c6 89 d0 88 c4 ac 38 e0 74 09 84 c0 75 f7 be 01 00 00
00 89 f0 48 5e 5d c3 55 83 c9 ff 89 e5 57 89 c7 31 c0 <f2> ae f7 d1 49 5f 89 c8
5d c3 55 89 e5 57 89 c7 89 d0 31 d2 85 
EIP: [<c050a0c5>] strlen+0xb/0x15 SS:ESP 0068:df092ec4

-- 
http://www.codemonkey.org.uk
