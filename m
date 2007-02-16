From: "Henri Hunnekens" <henrihunnekens@gmail.com>
Subject: kernel BUG at drivers/acpi/osl.c:373! (acpi-cpufreq)
Date: Fri, 16 Feb 2007 16:03:29 +0100
Message-ID: <e9f486400702160703pb3912e3m874daae8665c5cbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:29750 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932393AbXBPPDb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 10:03:31 -0500
Received: by mu-out-0910.google.com with SMTP id g7so22803muf
        for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2007 07:03:30 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Dear Len,

Loading the acpi_cpufreq module reports a kernel bug using kernel
version 2.6.20.
versions 2.6.18 and older work fine.

Any idea what causes this problem?

Henri

kernel BUG at drivers/acpi/osl.c:373!
invalid opcode: 0000 [#1]
PREEMPT SMP
Modules linked in: acpi_cpufreq freq_table cap_over commoncap i2c_dev uhci_hcd i
2c_i801 i2c_core ehci_hcd
CPU:    0
EIP:    0060:[<c027dbd9>]    Not tainted VLI
EFLAGS: 00010297   (2.6.20-rc7-rt3 #1)
EIP is at acpi_os_write_port+0x2d/0x36
eax: 00000001   ebx: 00000832   ecx: 00000001   edx: 00000001
esi: de561920   edi: 00000000   ebp: dd3d1c90   esp: dd3d1c8c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process modprobe (pid: 2543, ti=dd3d0000 task=de656660 task.ti=dd3d0000)
Stack: 00000000 dd3d1cf0 e0074455 00000001 dd3d1ce0 c039bff2 dcf84940 00000000
      df40d000 00000001 00000001 dd3d1cd0 c016612f 00000002 00000001 dc010832
      00000001 00000000 002cc108 002cc108 c03f1302 00000000 df2d0d80 e00742d0
Call Trace:
 [<c010566a>] show_trace_log_lvl+0x1a/0x30
 [<c0105738>] show_stack_log_lvl+0xb8/0xf0
 [<c0105950>] show_registers+0x1e0/0x300
 [<c0105b95>] die+0x125/0x260
 [<c0105d52>] do_trap+0x82/0xd0
 [<c0106727>] do_invalid_op+0x97/0xb0
 [<c03f1c7c>] error_code+0x7c/0x84
 [<e0074455>] acpi_cpufreq_target+0x185/0x290 [acpi_cpufreq]
 [<c037881f>] __cpufreq_driver_target+0x3f/0x50
 [<c037a0de>] cpufreq_governor_performance+0x1e/0x30
 [<c0378984>] __cpufreq_governor+0x24/0xd0
 [<c0378e9b>] __cpufreq_set_policy+0xeb/0x140
 [<c03790fe>] cpufreq_set_policy+0x4e/0x80
 [<c0379d4a>] cpufreq_add_dev+0x31a/0x3e0
 [<c02bdfc9>] sysdev_driver_register+0x59/0xa0
 [<c037a027>] cpufreq_register_driver+0x67/0x100
 [<e007809d>] acpi_cpufreq_init+0x9d/0xa4 [acpi_cpufreq]
 [<c01423f7>] sys_init_module+0x137/0x1b90
 [<c0104620>] syscall_call+0x7/0xb
 =======================
Code: f9 10 89 e5 53 89 c3 89 d0 74 12 83 f9 20 74 16 83 f9 08 75 16 0f b6 c2 89
 da ee eb 12 0f b7 c2 89 da 66 ef eb 09 89 da ef eb 04 <0f> 0b eb fe 5b 31 c0 5d
 c3 55 89 e5 5d c3 55 85 c0 89 e5 89 c1
EIP: [<c027dbd9>] acpi_os_write_port+0x2d/0x36 SS:ESP 0068:dd3d1c8c
 Segmentation fault
