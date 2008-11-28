From: Christian Iversen <ci@sikkerhed.org>
Subject: ACPI bug with Lenovo Thinkpad
Date: Fri, 28 Nov 2008 18:58:00 +0100
Message-ID: <49303128.5090708@sikkerhed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sikkerhed.org ([78.109.215.82]:45678 "EHLO
	mail.sikkerhed.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbYK1SWG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Nov 2008 13:22:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all

On my ubuntu hardy (8.04) with 2.6.24-22-generic (from ubuntu), I have a 
  reproducible problem with my lenovo thinkpad T61p 6460

I have an advanced minidock for the thinkpad. Normal docking and 
undocking work great. However, if the dock loses power while the 
thinkpad is docked, the computer freezes.

At that point, I can reconnect the power and wait a short while (in the 
order of 5-10 seconds) to resume normal operation. If I don't reconnect 
power (this I discovered when there was a local power outage), then the 
computer seems to be locked for a long time (in the order of 10-20 
minutes). However, it did finally start responding again, although I 
cannot remember if any external event triggered it (but it was before 
power had been restored).

You'll find below the debug messages from before the powerloss, and up 
to the point where the computer started responding again. As you can 
see, USB disconnects properly, and then there's a 773s (~12m) pause 
until the section beginning with "NMI: IOCK error" begins.

Does anyone know what could cause this, and how it could be fixed? It 
really seems like some part of the kernel is waiting for an event that 
will never occur, because power has been lost.

Any ideas?

...
[    6.359161] input: Lite-On Technology USB Productivity Option 
Keyboard( has the hub in # 1 ) as 
/devices/pci0000:00/0000:00:1a.7/usb6/6-4/6-4.3/6-4.3.1/6-4.3.1:1.0/input/input37
[    6.370264] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    6.403448] input,hidraw2: USB HID v1.10 Keyboard [Lite-On Technology 
USB Productivity Option Keyboard( has the hub in # 1 )] on 
usb-0000:00:1a.7-4.3.1
[    6.404515] input: Lite-On Technology USB Productivity Option 
Keyboard( has the hub in # 1 ) as 
/devices/pci0000:00/0000:00:1a.7/usb6/6-4/6-4.3/6-4.3.1/6-4.3.1:1.1/input/input38
[    6.433732] ADDRCONF(NETDEV_UP): eth0: link is not ready
[    6.433737] bridge-eth0: enabling the bridge
[    6.459645] bridge-eth0: up
[    6.467164] input,hidraw3: USB HID v1.10 Device [Lite-On Technology 
USB Productivity Option Keyboard( has the hub in # 1 )] on 
usb-0000:00:1a.7-4.3.1
[    8.546585] e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps 
Full Duplex, Flow Control: RX/TX
[    8.565488] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   10.125301] eth0: no IPv6 routers present
[ 3615.377397] usb 6-4: USB disconnect, address 50
[ 3615.377406] usb 6-4.3: USB disconnect, address 52
[ 3615.377410] usb 6-4.3.1: USB disconnect, address 54
[ 3615.452435] usb 6-4.4: USB disconnect, address 53
[ 3615.579331] e1000: eth0: e1000_watchdog: NIC Link is Down
[ 4388.503729] NMI: IOCK error (debug interrupt?)
[ 4388.503740] CPU 0
[ 4388.503743] Modules linked in: e1000 iwl4965 iwlwifi_mac80211 
cfg80211 vmnet(P) vmmon(P) iptable_nat nf_nat ipt_LOG usbhid hid 
binfmt_misc af_packet rfcomm l2cap bluetooth ipt_REJECT xt_tcpudp 
nf_conntrack_ipv4 xt_state nf_conntrack n
[ 4388.503903] Pid: 0, comm: swapper Tainted: P        2.6.24-21-generic #1
[ 4388.503908] RIP: 0010:[<ffffffff8024fac0>]  [<ffffffff8024fac0>] 
__queue_work+0x0/0x50

[ 4388.503923] RSP: 0018:ffffffff80635e30  EFLAGS: 00000002
[ 4388.503927] RAX: ffff810135045200 RBX: ffff810136b7cad0 RCX: 
0000000000000001
[ 4388.503931] RDX: 0000000000000000 RSI: ffff810136b7cad0 RDI: 
ffff810135045200
[ 4388.503936] RBP: ffffffff8038d69c R08: ffff810137401e38 R09: 
00000000347f7000
[ 4388.503941] R10: 0000000000000092 R11: 0000000000000286 R12: 
ffff810137401e00
[ 4388.503946] R13: 0000000000000004 R14: ffff810137225120 R15: 
0000000000000004
[ 4388.503951] FS:  0000000000000000(0000) GS:ffffffff805b9000(0000) 
knlGS:0000000000000000
[ 4388.503956] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 4388.503961] CR2: 000000300216c4f8 CR3: 000000000bb3c000 CR4: 
00000000000006e0
[ 4388.503965] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 4388.503970] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[ 4388.503975] Process swapper (pid: 0, threadinfo ffffffff805d6000, 
task ffffffff8057f3a0)
[ 4388.503979] Stack:  ffffffff8024fb77 ffff810136b7cac0 
ffffffff803736c9 ffff810135045536
[ 4388.503988]  ffff810137401e00 0000000000000012 ffff810135045536 
0000000000000002
[ 4388.503995]  ffffffff8038dfad ffff81013503fdb0 ffffffff80379b12 
00000000000001b0
[ 4388.504002] Call Trace:
[ 4388.504005]  <IRQ>  [<ffffffff8024fb77>] queue_work+0x37/0x50
[ 4388.504027]  [<ffffffff803736c9>] acpi_os_execute+0x98/0xb6
[ 4388.504049]  [<ffffffff8038dfad>] acpi_ec_gpe_handler+0x4f/0x81
[ 4388.504060]  [<ffffffff80379b12>] acpi_ev_gpe_dispatch+0x5b/0x145
[ 4388.504076]  [<ffffffff80379e77>] acpi_ev_gpe_detect+0xb1/0x104
[ 4388.504083]  [<ffffffff802475a7>] run_timer_softirq+0x27/0x230
[ 4388.504096]  [<ffffffff80377988>] acpi_ev_fixed_event_detect+0x34/0xc8
[ 4388.504123]  [<ffffffff80378386>] acpi_ev_sci_xrupt_handler+0x1a/0x22
[ 4388.504139]  [<ffffffff80372b71>] acpi_irq+0x11/0x1b
[ 4388.504146]  [<ffffffff80250d29>] rcu_pending+0x49/0x60
[ 4388.504152]  [<ffffffff8027f5a4>] handle_IRQ_event+0x34/0x70
[ 4388.504158]  [<ffffffff80250d7d>] rcu_needs_cpu+0x3d/0x50
[ 4388.504177]  [<ffffffff802810da>] handle_fasteoi_irq+0x8a/0x110
[ 4388.504200]  [<ffffffff8020ef6b>] do_IRQ+0x7b/0x100
[ 4388.504215]  [<ffffffff8020c891>] ret_from_intr+0x0/0xa
[ 4388.504222]  <EOI>  [<ffffffff8802e58b>] 
:processor:acpi_idle_enter_bm+0x26f/0x2da
[ 4388.504298]  [<ffffffff8802e581>] 
:processor:acpi_idle_enter_bm+0x265/0x2da
[ 4388.504305]  [<ffffffff80250d7d>] rcu_needs_cpu+0x3d/0x50
[ 4388.504320]  [<ffffffff8020b390>] default_idle+0x0/0x40
[ 4388.504334]  [<ffffffff803d6fc2>] cpuidle_idle_call+0xa2/0xe0
[ 4388.504339]  [<ffffffff8020b390>] default_idle+0x0/0x40
[ 4388.504344]  [<ffffffff803d6f20>] cpuidle_idle_call+0x0/0xe0
[ 4388.504353]  [<ffffffff8020b43f>] cpu_idle+0x6f/0xc0
[ 4388.504371]  [<ffffffff805e0885>] start_kernel+0x2c5/0x350
[ 4388.504393]  [<ffffffff805e012e>] _sinittext+0x12e/0x140
[ 4388.504417]
[ 4388.504419]
[ 4388.504420] Code: 48 83 ec 18 48 89 1c 24 4c 89 64 24 08 48 89 fb 49 
89 f4 4c
[ 4388.506802] iwl4965: Microcode SW error detected.  Restarting 0x82000000.
[ 4390.505149] iwl4965: Error sending REPLY_STATISTICS_CMD: time out 
after 500ms.
[ 4390.512453] thinkpad_acpi: fan watchdog: enabling fan
[ 4393.921897] ACPI: \_SB_.GDCK - undocking
[ 4520.822760] wlan0: Initial auth_alg=0
[ 4520.822773] wlan0: authenticate with AP 00:17:3f:55:08:9e
[ 4520.827359] wlan0: Initial auth_alg=0
[ 4520.827372] wlan0: authenticate with AP 00:17:3f:55:08:9e
[ 4520.827417] wlan0: RX authentication from 00:17:3f:55:08:9e (alg=0 
transaction=2 status=0)
[ 4520.827422] wlan0: authenticated
[ 4520.827426] wlan0: associate with AP 00:17:3f:55:08:9e
[ 4520.829250] wlan0: authentication frame received from 
00:17:3f:55:08:9e, but not in authenticate state - ignored
[ 4520.831641] wlan0: RX AssocResp from 00:17:3f:55:08:9e (capab=0x401 
status=0 aid=1)
[ 4520.831651] wlan0: associated
[ 4520.843417] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[ 4525.515109] time.c: can't update CMOS clock from 6 to 56
[ 4526.513576] time.c: can't update CMOS clock from 6 to 56
[ 4527.512068] time.c: can't update CMOS clock from 6 to 56
[ 4528.510519] time.c: can't update CMOS clock from 6 to 56
[ 4530.507474] time.c: can't update CMOS clock from 6 to 56
[ 4541.291843] wlan0: no IPv6 routers present



-- 
Med venlig hilsen / Best regards
Christian Iversen

Sikkerhed.org ApS
Fuglebakkevej 88                       E-mail:  support@sikkerhed.org
1. sal                                 Web:     www.sikkerhed.org
DK-2000 Frederiksberg                  Direkte: ci@sikkerhed.org
