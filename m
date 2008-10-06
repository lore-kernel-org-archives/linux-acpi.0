From: Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si 2636
Date: Mon, 06 Oct 2008 13:23:06 +0200
Message-ID: <48E9F51A.4080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:13777 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbYJFLXM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Oct 2008 07:23:12 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1611365ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2008 04:23:10 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello

I'm experiencing a problem with my new Fujitsu-Siemens AMILO Si 2636
laptop. When the system is under heavy load it locks up and a
message about soft lockup roll on the terminal. The message differs
from time to time but it's always a soft lockup caused by kacpid
and the associated call trace is always somewhere in the ACPI AML
parsing code. I'm guessing there is a bug in the AML parser or more
likely in the Amilo's AML code

The lockup only occur if ACPI is active and it seems to be related
to the thermal module. Most of the call traces contain the function
acpi_thermal_get_temperature but not all of them. I use the most
recent 1.0d 25.03.2008 BIOS.

I believe kernel bug #6433 is related to this. The circumstance and
call trace looks similar.
http://bugzilla.kernel.org/show_bug.cgi?id=6433

A typical message looks like this:
BUG: soft lockup - CPU#1 stuck for 61s! [kacpid:87]
Modules linked in: i2c_i801
CPU 1:
Modules linked in: i2c_i801
Pid: 87, comm: kacpid Tainted: G   M      2.6.27-rc8 #1
RIP: 0010:[<ffffffff80423809>]  [<ffffffff80423809>] acpi_ns_delete_namespace_by_owner+0x66/0xde
RSP: 0018:ffff88013fa19ce0  EFLAGS: 00000207
RAX: ffff88013f81a820 RBX: ffff88013f81a820 RCX: 0000000000000000
RDX: ffff88013f81a820 RSI: ffff88013f81a700 RDI: ffff88013f81a800
RBP: ffff880139370cf0 R08: 0000000000000000 R09: ffff880139370cf0
R10: ffff88013eaa6430 R11: ffff88013eaa7000 R12: ffff88013eaa6430
R13: ffff88013eaa7000 R14: ffff88013f81a5a0 R15: ffffffff80414149
FS:  0000000000000000(0000) GS:ffff88013f809680(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000004e3fd0 CR3: 000000013e9da000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400

Call Trace:
[<ffffffff80416ea4>] ? acpi_ds_terminate_control_method+0x6e/0xc1
[<ffffffff8042584c>] ? acpi_ps_parse_aml+0x18c/0x2c8
[<ffffffff80426c47>] ? acpi_ps_execute_method+0x135/0x1e2
[<ffffffff80423a13>] ? acpi_ns_evaluate+0x14f/0x1ac
[<ffffffff80423566>] ? acpi_evaluate_object+0x131/0x1df
[<ffffffff8022efe3>] ? __wake_up+0x43/0x70
[<ffffffff80414d55>] ? acpi_evaluate_integer+0x8c/0xc7
[<ffffffff80438edb>] ? acpi_thermal_get_temperature+0x2e/0x3b
[<ffffffff80439127>] ? acpi_thermal_check+0x84/0x3e2
[<ffffffff804143d2>] ? acpi_os_execute_deferred+0x0/0x2c
[<ffffffff804143f5>] ? acpi_os_execute_deferred+0x23/0x2c
[<ffffffff80249b39>] ? run_workqueue+0x79/0x100
[<ffffffff8024a560>] ? worker_thread+0x0/0x120
[<ffffffff8024a61f>] ? worker_thread+0xbf/0x120
[<ffffffff8024d7a0>] ? autoremove_wake_function+0x0/0x30
[<ffffffff8024a560>] ? worker_thread+0x0/0x120
[<ffffffff8024d38b>] ? kthread+0x4b/0x80
[<ffffffff8020c629>] ? child_rip+0xa/0x11
[<ffffffff8024d340>] ? kthread+0x0/0x80
[<ffffffff8020c61f>] ? child_rip+0x0/0x11

Environment:
I run gentoo with the 2.6.27-rc8 kernel and I have also tried the
2.6.25 and 2.6.24 kernels using 32 and 64-bit OS with the same result.

Steps to reproduce:
Boot a recent kernel on a Fujitsu-Siemens AMILO Si 2636 laptop
and put the system under heavy load. A kernel make -j3 works
but a make -j1 is not enough. Wait 5-10 min until lockup.

Outputs:
The output of useful programs including acpidump can be viewed
here http://www.cyd.liu.se/~tholi945/acpi-bug-2008-10-06/


/Thomas Lindroth
