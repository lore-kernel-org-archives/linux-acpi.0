From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/30] eeepc-laptop: fix oops when changing backlight
 brightness during eeepc-laptop init
Date: Sat, 07 Feb 2009 01:41:37 -0500
Message-ID: <7695fb04aca62e2d8a7ca6ede50f6211e1d71e53.1233988827.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:12280 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbZBGGmN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:13 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00J7BNXU9U32@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:55 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Darren Salt <linux@youmustbejoking.demon.co.uk>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Darren Salt <linux@youmustbejoking.demon.co.uk>

I got the following oops while changing the backlight brightness during
startup.  When it happens, it prevents use of the hotkeys, Fn-Fx, and the
lid button.

It's a clear use-before-init, as I verified by testing with an
appropriately-placed "else printk".

BUG: unable to handle kernel NULL pointer dereference at 00000000
*pde = 00000000
Oops: 0002 [#1] PREEMPT SMP
Pid: 160, comm: kacpi_notify Not tainted (2.6.28.1-eee901 #4) 901
EIP: 0060:[<c0264e68>]  [<c0264e68>] eeepc_hotk_notify+26/da
EFLAGS: 00010246 CPU: 1
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 00000009 EBX: 00000000 ECX: 00000009 EDX: f70dbf64
ESI: 00000029 EDI: f7335188 EBP: c02112c9 ESP: f70dbf80
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
 f70731e0 f73acd50 c02164ac f7335180 f70aa040 c02112e6 f733518c c012b62f
 f70aa044 f70aa040 c012bdba f70aa04c 00000000 c012be6e 00000000 f70bdf80
 c012e198 f70dbfc4 f70dbfc4 f70aa040 c012bdba 00000000 c012e0c9 c012e091
Call Trace:
 [<c02164ac>] ? acpi_ev_notify_dispatch+4c/55
 [<c02112e6>] ? acpi_os_execute_deferred+1d/25
 [<c012b62f>] ? run_workqueue+71/f1
 [<c012bdba>] ? worker_thread+0/bf
 [<c012be6e>] ? worker_thread+b4/bf
 [<c012e198>] ? autoremove_wake_function+0/2b
 [<c012bdba>] ? worker_thread+0/bf
 [<c012e0c9>] ? kthread+38/5f
 [<c012e091>] ? kthread+0/5f
 [<c0103abf>] ? kernel_thread_helper+7/10
Code: 00 00 00 00 c3 83 3d 60 5c 50 c0 00 56 89 d6 53 0f 84 c4 00 00 00 8d 42
e0 83 f8 0f 77 0f 8b 1d 68 5c 50 c0 89 d8 e8 a9 fa ff ff <89> 03 8b 1d 60 5c
50 c0 89 f2 83 e2 7f 0f b7 4c 53 10 8d 41 01

Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 9d93cb9..8fb983f 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -510,7 +510,8 @@ static int eeepc_hotk_check(void)
 static void notify_brn(void)
 {
 	struct backlight_device *bd = eeepc_backlight_device;
-	bd->props.brightness = read_brightness(bd);
+	if (bd)
+		bd->props.brightness = read_brightness(bd);
 }
 
 static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
-- 
1.5.6.6

