From: Peter Klotz <peter.klotz@aon.at>
Subject: 2.6.28-rc3: Oops in _spin_unlock_irqrestore
Date: Tue, 11 Nov 2008 21:05:09 +0100
Message-ID: <4919E575.8000509@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from warsl404pip8.highway.telekom.at ([195.3.96.102]:21904 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751160AbYKKUFN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Nov 2008 15:05:13 -0500
Received: from 212-183-100-59.adsl.highway.telekom.at (HELO [192.168.0.100]) ([212.183.100.59])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub94.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 11 Nov 2008 20:05:10 -0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Got this in /var/log/messages
(Asus B50A laptop, Core 2 Duo, 2.6.28-rc3, x86_64):

Nov 11 01:34:25 asus kernel: [23962.426336] Pid: 0, comm: swapper Not 
tainted 2.6.28-rc3-custom #1
Nov 11 01:34:25 asus kernel: [23962.426341] RIP: 
0010:[<ffffffff804f18e3>]  [<ffffffff804f18e3>] 
_spin_unlock_irqrestore+0x13/0x20
Nov 11 01:34:25 asus kernel: [23962.426357] RSP: 0018:ffffffff80741da0 
EFLAGS: 00000282
Nov 11 01:34:25 asus kernel: [23962.426361] RAX: 0000000000000000 RBX: 
ffffffff80741da8 RCX: 0000000000000020
Nov 11 01:34:25 asus kernel: [23962.426366] RDX: 000000000015c004 RSI: 
0000000000000282 RDI: 0000000000000282
Nov 11 01:34:25 asus kernel: [23962.426371] RBP: ffffffff80741da8 R08: 
ffff880028025180 R09: 00000001005a43d6
Nov 11 01:34:25 asus kernel: [23962.426376] R10: ffff8800784efbc8 R11: 
00000000ffffffff R12: ffffffff80741d48
Nov 11 01:34:25 asus kernel: [23962.426380] R13: 0000000000b3d3a0 R14: 
ffffffff80269279 R15: ffffffff80741d18
Nov 11 01:34:25 asus kernel: [23962.426386] FS:  0000000000000000(0000) 
GS:ffffffff8073aa00(0000) knlGS:0000000000000000
Nov 11 01:34:25 asus kernel: [23962.426392] CS:  0010 DS: 0018 ES: 0018 
CR0: 000000008005003b
Nov 11 01:34:25 asus kernel: [23962.426396] CR2: 00007f38f7f3f000 CR3: 
0000000000201000 CR4: 00000000000026e0
Nov 11 01:34:25 asus kernel: [23962.426401] DR0: 0000000000000000 DR1: 
0000000000000000 DR2: 0000000000000000
Nov 11 01:34:25 asus kernel: [23962.426406] DR3: 0000000000000000 DR6: 
00000000ffff0ff0 DR7: 0000000000000400
Nov 11 01:34:25 asus kernel: [23962.426410] Call Trace:
Nov 11 01:34:25 asus kernel: [23962.426422]  [<ffffffff8026cfcf>] 
tick_broadcast_oneshot_control+0x8f/0x130
Nov 11 01:34:25 asus kernel: [23962.426430]  [<ffffffff8026cb9d>] 
tick_notify+0x2fd/0x430
Nov 11 01:34:25 asus kernel: [23962.426437]  [<ffffffff802653e9>] ? 
ktime_get_ts+0x59/0x60
Nov 11 01:34:25 asus kernel: [23962.426445]  [<ffffffff804f4e9f>] 
notifier_call_chain+0x3f/0x80
Nov 11 01:34:25 asus kernel: [23962.426452]  [<ffffffff80266481>] 
raw_notifier_call_chain+0x11/0x20
Nov 11 01:34:25 asus kernel: [23962.426460]  [<ffffffff8026c39b>] 
clockevents_notify+0x2b/0x90
Nov 11 01:34:25 asus kernel: [23962.426482]  [<ffffffffa00210c3>] 
acpi_state_timer_broadcast+0x41/0x43 [processor]
Nov 11 01:34:25 asus kernel: [23962.426502]  [<ffffffffa0021699>] 
acpi_idle_enter_bm+0x2ab/0x2da [processor]
Nov 11 01:34:25 asus kernel: [23962.426512]  [<ffffffff8043bd5a>] 
cpuidle_idle_call+0xaa/0x100
Nov 11 01:34:25 asus kernel: [23962.426520]  [<ffffffff8020af45>] 
cpu_idle+0x65/0xc0
Nov 11 01:34:25 asus kernel: [23962.426528]  [<ffffffff804dd7c1>] 
rest_init+0x61/0x70


Finally the system continuously logs "bad: scheduling from the idle 
thread!".

The same problem occurs in 2.6.27.5.

Can I provide you with any further information to analyze this problem?

Please CC me since I am not on the list.

Regards, Peter.
