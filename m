From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: kernel oops after resume from S4
Date: Mon, 23 Feb 2004 10:54:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040223095403.GA27359@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

on this particular machine (HP compaq nx5000, centrino with intel graphics)
i get a reproducible oops after resume from S4 (swsusp). Kernel is 2.6.3, it
also happens on init=/bin/bash with no modules loaded. psmouse is compiled
into the kernel. After this, the machine seems to work fine, although having
lost the Touchpad.

Feb 23 10:35:23 x kernel: Stopping tasks: =================================|
Feb 23 10:35:23 x kernel: Freeing memory: .........|
Feb 23 10:35:23 x kernel: hdc: start_power_step(step: 0)
Feb 23 10:35:23 x kernel: hdc: completing PM request, suspend
Feb 23 10:35:23 x kernel: hda: start_power_step(step: 0)
Feb 23 10:35:23 x kernel: hda: completing PM request, suspend
Feb 23 10:35:23 x kernel: /critical section: Counting pages to copy[nosave c03bc000] (pages needed: 5857+512=6369 free: 190750)
Feb 23 10:35:23 x kernel: Alloc pagedir
Feb 23 10:35:23 x kernel: [nosave c03bc000]<4>Freeing prev allocated pagedir
Feb 23 10:35:23 x kernel: hda: Wakeup request inited, waiting for !BSY...
Feb 23 10:35:23 x kernel: hda: start_power_step(step: 1000)
Feb 23 10:35:23 x kernel: blk: queue efaf8600, I/O limit 4095Mb (mask 0xffffffff)
Feb 23 10:35:23 x kernel: hda: completing PM request, resume
Feb 23 10:35:23 x kernel: hdc: Wakeup request inited, waiting for !BSY...
Feb 23 10:35:23 x kernel: hdc: start_power_step(step: 1000)
Feb 23 10:35:23 x kernel: hdc: completing PM request, resume
Feb 23 10:35:23 x kernel: Fixing swap signatures... ok
Feb 23 10:35:23 x kernel: Badness in redraw_screen at drivers/char/vt.c:607
Feb 23 10:35:23 x kernel: Call Trace:
Feb 23 10:35:23 x kernel:  [redraw_screen+361/448] redraw_screen+0x169/0x1c0
Feb 23 10:35:23 x kernel:  [<c020dcb9>] redraw_screen+0x169/0x1c0
Feb 23 10:35:23 x kernel:  [do_magic_resume_2+156/192] do_magic_resume_2+0x9c/0xc0
Feb 23 10:35:23 x kernel:  [<c0132e4c>] do_magic_resume_2+0x9c/0xc0
Feb 23 10:35:23 x kernel:  [do_magic+287/304] do_magic+0x11f/0x130
Feb 23 10:35:23 x kernel:  [<c027afbf>] do_magic+0x11f/0x130
Feb 23 10:35:23 x kernel:  [software_suspend+147/224] software_suspend+0x93/0xe0
Feb 23 10:35:23 x kernel:  [<c01323e3>] software_suspend+0x93/0xe0
Feb 23 10:35:23 x kernel:  [acpi_system_write_sleep+179/206] acpi_system_write_sleep+0xb3/0xce
Feb 23 10:35:23 x kernel:  [<c01f4a95>] acpi_system_write_sleep+0xb3/0xce
Feb 23 10:35:23 x kernel:  [vfs_write+170/240] vfs_write+0xaa/0xf0
Feb 23 10:35:23 x kernel:  [<c014f8ea>] vfs_write+0xaa/0xf0
Feb 23 10:35:23 x kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Feb 23 10:35:23 x kernel:  [<c014f9cd>] sys_write+0x2d/0x50
Feb 23 10:35:23 x kernel:  [sysenter_past_esp+82/121] sysenter_past_esp+0x52/0x79
Feb 23 10:35:23 x kernel:  [<c0108e29>] sysenter_past_esp+0x52/0x79
Feb 23 10:35:23 x kernel: 
Feb 23 10:35:23 x kernel: Badness in set_origin at drivers/char/vt.c:579
Feb 23 10:35:23 x kernel: Call Trace:
Feb 23 10:35:23 x kernel:  [set_origin+165/176] set_origin+0xa5/0xb0
Feb 23 10:35:23 x kernel:  [<c020c555>] set_origin+0xa5/0xb0
Feb 23 10:35:23 x kernel:  [redraw_screen+181/448] redraw_screen+0xb5/0x1c0
Feb 23 10:35:23 x kernel:  [<c020dc05>] redraw_screen+0xb5/0x1c0
Feb 23 10:35:23 x kernel:  [do_magic_resume_2+156/192] do_magic_resume_2+0x9c/0xc0
Feb 23 10:35:23 x kernel:  [<c0132e4c>] do_magic_resume_2+0x9c/0xc0
Feb 23 10:35:23 x kernel:  [do_magic+287/304] do_magic+0x11f/0x130
Feb 23 10:35:23 x kernel:  [<c027afbf>] do_magic+0x11f/0x130
Feb 23 10:35:23 x kernel:  [software_suspend+147/224] software_suspend+0x93/0xe0
Feb 23 10:35:23 x kernel:  [<c01323e3>] software_suspend+0x93/0xe0
Feb 23 10:35:23 x kernel:  [acpi_system_write_sleep+179/206] acpi_system_write_sleep+0xb3/0xce
Feb 23 10:35:23 x kernel:  [<c01f4a95>] acpi_system_write_sleep+0xb3/0xce
Feb 23 10:35:23 x kernel:  [vfs_write+170/240] vfs_write+0xaa/0xf0
Feb 23 10:35:23 x kernel:  [<c014f8ea>] vfs_write+0xaa/0xf0
Feb 23 10:35:23 x kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Feb 23 10:35:23 x kernel:  [<c014f9cd>] sys_write+0x2d/0x50
Feb 23 10:35:23 x kernel:  [sysenter_past_esp+82/121] sysenter_past_esp+0x52/0x79
Feb 23 10:35:23 x kernel:  [<c0108e29>] sysenter_past_esp+0x52/0x79
Feb 23 10:35:23 x kernel: 
Feb 23 10:35:23 x kernel: Badness in set_palette at drivers/char/vt.c:2888
Feb 23 10:35:23 x kernel: Call Trace:
Feb 23 10:35:23 x kernel:  [set_palette+89/96] set_palette+0x59/0x60
Feb 23 10:35:23 x kernel:  [<c020c6b9>] set_palette+0x59/0x60
Feb 23 10:35:23 x kernel:  [redraw_screen+203/448] redraw_screen+0xcb/0x1c0
Feb 23 10:35:23 x kernel:  [<c020dc1b>] redraw_screen+0xcb/0x1c0
Feb 23 10:35:23 x kernel:  [do_magic_resume_2+156/192] do_magic_resume_2+0x9c/0xc0
Feb 23 10:35:23 x kernel:  [<c0132e4c>] do_magic_resume_2+0x9c/0xc0
Feb 23 10:35:23 x kernel:  [do_magic+287/304] do_magic+0x11f/0x130
Feb 23 10:35:23 x kernel:  [<c027afbf>] do_magic+0x11f/0x130
Feb 23 10:35:23 x kernel:  [software_suspend+147/224] software_suspend+0x93/0xe0
Feb 23 10:35:23 x kernel:  [<c01323e3>] software_suspend+0x93/0xe0
Feb 23 10:35:23 x kernel:  [acpi_system_write_sleep+179/206] acpi_system_write_sleep+0xb3/0xce
Feb 23 10:35:23 x kernel:  [<c01f4a95>] acpi_system_write_sleep+0xb3/0xce
Feb 23 10:35:23 x kernel:  [vfs_write+170/240] vfs_write+0xaa/0xf0
Feb 23 10:35:23 x kernel:  [<c014f8ea>] vfs_write+0xaa/0xf0
Feb 23 10:35:23 x kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Feb 23 10:35:23 x kernel:  [<c014f9cd>] sys_write+0x2d/0x50
Feb 23 10:35:23 x kernel:  [sysenter_past_esp+82/121] sysenter_past_esp+0x52/0x79
Feb 23 10:35:23 x kernel:  [<c0108e29>] sysenter_past_esp+0x52/0x79
Feb 23 10:35:23 x kernel: 
Feb 23 10:35:23 x kernel: Restarting tasks... done
Feb 23 10:35:23 x kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000066e
Feb 23 10:35:23 x kernel:  printing eip:
Feb 23 10:35:23 x kernel: c026fa2b
Feb 23 10:35:23 x kernel: *pde = 00000000
Feb 23 10:35:23 x kernel: Oops: 0000 [#1]
Feb 23 10:35:23 x kernel: CPU:    0
Feb 23 10:35:23 x kernel: EIP:    0060:[psmouse_reconnect+11/224]    Not tainted
Feb 23 10:35:23 x kernel: EIP:    0060:[<c026fa2b>]    Not tainted
Feb 23 10:35:23 x kernel: EFLAGS: 00010282
Feb 23 10:35:23 x kernel: EIP is at psmouse_reconnect+0xb/0xe0
Feb 23 10:35:23 x kernel: eax: 00000000   ebx: 00000000   ecx: 0007a120   edx: 00000008
Feb 23 10:35:23 x kernel: esi: 00000007   edi: c038cfa4   ebp: c038cf94   esp: efba1f8c
Feb 23 10:35:23 x kernel: ds: 007b   es: 007b   ss: 0068
Feb 23 10:35:23 x kernel: Process kseriod (pid: 198, threadinfo=efba0000 task=efbc86b0)
Feb 23 10:35:23 x kernel: Stack: efee4000 00000007 c026fab6 ef928180 ed10c368 ed10c360 c02717b4 c041e8e8 
Feb 23 10:35:23 x kernel:        efba0000 ffffe000 00008000 efba0000 c0271818 00000000 efbc86b0 c011a870 
Feb 23 10:35:23 x kernel:        00100100 00200200 00000000 00000000 00000000 c02717d0 00000000 00000000 
Feb 23 10:35:23 x kernel: Call Trace:
Feb 23 10:35:23 x kernel:  [psmouse_reconnect+150/224] psmouse_reconnect+0x96/0xe0
Feb 23 10:35:23 x kernel:  [<c026fab6>] psmouse_reconnect+0x96/0xe0
Feb 23 10:35:23 x kernel:  [serio_handle_events+196/224] serio_handle_events+0xc4/0xe0
Feb 23 10:35:23 x kernel:  [<c02717b4>] serio_handle_events+0xc4/0xe0
Feb 23 10:35:23 x kernel:  [serio_thread+72/246] serio_thread+0x48/0xf6
Feb 23 10:35:23 x kernel:  [<c0271818>] serio_thread+0x48/0xf6
Feb 23 10:35:23 x kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Feb 23 10:35:23 x kernel:  [<c011a870>] default_wake_function+0x0/0x20
Feb 23 10:35:23 x kernel:  [serio_thread+0/246] serio_thread+0x0/0xf6
Feb 23 10:35:23 x kernel:  [<c02717d0>] serio_thread+0x0/0xf6
Feb 23 10:35:23 x kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Feb 23 10:35:23 x kernel:  [<c0107005>] kernel_thread_helper+0x5/0x10
Feb 23 10:35:23 x kernel: 
Feb 23 10:35:23 x kernel: Code: 8a 93 6e 06 00 00 81 e2 ff 00 00 00 85 c0 89 d6 0f 84 a7 00 

i'm using vesa framebuffer.
I don't know if the "Badness..." are related to the oops, it also happens 
with "vga=0".
I know this is probably not an ACPI issue, but whom do i report it? Is it
a bug in the psmouse driver? Bugzilla.kernel.org?
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
