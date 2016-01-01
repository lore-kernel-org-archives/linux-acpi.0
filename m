From: Thomas Meyer <thomas@m3y3r.de>
Subject: [ACPI] BUG: KASan: out of bounds on stack in vsnprintf
Date: Fri, 01 Jan 2016 17:39:09 +0100
Message-ID: <1451666349.9687.2.camel@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I started to run my kernels with KASan enabled and found this after res=
ume from ram on a 4.3.3 kernel:

Jan 01 15:16:59 localhost.localdomain kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 01 15:16:59 localhost.localdomain kernel: BUG: KASan: out of bounds=
 on stack in vsnprintf+0x14c4/0x1a00 at addr ffff8800b5957838
Jan 01 15:16:59 localhost.localdomain kernel: Read of size 8 by task sy=
stemd-sleep/5375
Jan 01 15:16:59 localhost.localdomain kernel: page:ffffea0002d655c0 cou=
nt:0 mapcount:0 mapping:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(null) index:0x0
Jan 01 15:17:00 localhost.localdomain kernel: flags: 0x4000000000000000=
()
Jan 01 15:17:01 localhost.localdomain kernel: page dumped because: kasa=
n: bad access detected
Jan 01 15:17:01 localhost.localdomain kernel: CPU: 0 PID: 5375 Comm: sy=
stemd-sleep Not tainted 4.3.3 #15
Jan 01 15:17:01 localhost.localdomain kernel: Hardware name: Acer Aspir=
e 1810T/JM11-MS, BIOS v1.3310 03/25/2010
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59578=
38 000000006c6dad1e ffff8800b59575f8 ffffffff81937da7
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59576=
80 ffff8800b5957670 ffffffff8143b533 0000000000000002
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A000000000000000=
00 0000000000000046 ffffffff81b12196 0000000300000206
Jan 01 15:17:01 localhost.localdomain kernel: Call Trace:
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
7da7>] dump_stack+0x4b/0x74
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
b533>] kasan_report_error+0x3b3/0x3e0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b1=
2196>] ? acpi_ns_search_and_enter+0xa7/0x3b5
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
b70c>] __asan_report_load8_noabort+0x5c/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
2b14>] ? vsnprintf+0x14c4/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
2b14>] vsnprintf+0x14c4/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
1650>] ? pointer.isra.22+0x980/0x980
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811b=
6690>] ? up+0x70/0xb0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
ae34>] ? kasan_slab_free+0x44/0x50
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
3094>] vsprintf+0x14/0x20
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4b49>] acpi_os_vprintf+0x16/0x2b
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4bfc>] acpi_os_printf+0x9e/0xca
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4b5e>] ? acpi_os_vprintf+0x2b/0x2b
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b3=
383b>] acpi_exception+0xb2/0x132
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b3=
3789>] ? acpi_bios_warning+0x117/0x117
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
bf5b>] ? acpi_ns_evaluate+0xb3/0x853
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
ab0e>] ? kasan_kmalloc+0x5e/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
8d98>] acpi_get_sleep_type_data+0x549/0x568
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
76fd>] acpi_hw_legacy_wake_prep+0x83/0x227
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
767a>] ? acpi_hw_legacy_sleep+0x3bd/0x3bd
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
8415>] ? acpi_write_bit_register+0x288/0x2ce
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
818d>] ? acpi_read_bit_register+0x196/0x196
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
9069>] acpi_hw_sleep_dispatch+0xb0/0xb5
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
9080>] acpi_leave_sleep_state_prep+0x12/0x14
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
8ec7>] acpi_suspend_enter+0x10e/0x19a
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
8db9>] ? trace_suspend_resume+0xe0/0xe0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
2344>] suspend_devices_and_enter+0x964/0xdf0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8135=
eebd>] ? printk+0xa3/0xd3
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
19e0>] ? arch_suspend_enable_irqs+0x10/0x10
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e2f0>] ? sysfs_kf_bin_read+0x2c0/0x2c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
2cc9>] pm_suspend+0x4f9/0x690
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e2f0>] ? sysfs_kf_bin_read+0x2c0/0x2c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811b=
fcf5>] state_store+0x85/0x90
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
d250>] ? kobj_attr_show+0x60/0x60
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
d286>] kobj_attr_store+0x36/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e41c>] sysfs_kf_write+0x12c/0x1f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
c2b8>] kernfs_fop_write+0x1f8/0x3a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
eb8a>] __vfs_write+0xea/0x400
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
eaa0>] ? __vfs_read+0x3f0/0x3f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff813d=
e3f9>] ? handle_mm_fault+0x1579/0x34a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff813f=
302f>] ? do_mmap+0x66f/0x900
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff817c=
7ca5>] ? selinux_file_permission+0x2d5/0x430
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff817a=
8eaa>] ? security_file_permission+0x6a/0x1a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
ffa7>] ? rw_verify_area+0xb7/0x290
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
0594>] vfs_write+0x134/0x4c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
32b2>] SyS_write+0x112/0x240
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
31a0>] ? SyS_read+0x240/0x240
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8265=
3ad7>] entry_SYSCALL_64_fastpath+0x12/0x6a
Jan 01 15:17:01 localhost.localdomain kernel: Memory state around the b=
uggy address:
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59577=
00: 00 00 00 f1 f1 f1 f1 00 f4 f4 f4 f3 f3 f3 f3 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59577=
80: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
Jan 01 15:17:01 localhost.localdomain kernel: >ffff8800b5957800: 00 f4 =
f3 f3 f3 f3 f1 f1 f1 f1 00 00 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0^
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59578=
80: f1 f1 f1 f1 00 00 00 f4 f3 f3 f3 f3 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59579=
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 01 15:17:01 localhost.localdomain kernel: ACPI Exception: AE_NOT_FO=
UND, While evaluating Sleep State [\_S0_]
Jan 01 15:17:01 localhost.localdomain kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 01 15:17:01 localhost.localdomain kernel: BUG: KASan: out of bounds=
 on stack in vsnprintf+0x1902/0x1a00 at addr ffff8800b5957838
Jan 01 15:17:01 localhost.localdomain kernel: Read of size 4 by task sy=
stemd-sleep/5375
Jan 01 15:17:01 localhost.localdomain kernel: page:ffffea0002d655c0 cou=
nt:0 mapcount:0 mapping:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(null) index:0x0
Jan 01 15:17:01 localhost.localdomain kernel: flags: 0x4000000000000000=
()
Jan 01 15:17:01 localhost.localdomain kernel: page dumped because: kasa=
n: bad access detected
Jan 01 15:17:01 localhost.localdomain kernel: CPU: 0 PID: 5375 Comm: sy=
stemd-sleep Not tainted 4.3.3 #15
Jan 01 15:17:01 localhost.localdomain kernel: Hardware name: Acer Aspir=
e 1810T/JM11-MS, BIOS v1.3310 03/25/2010
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59578=
38 000000006c6dad1e ffff8800b59575f8 ffffffff81937da7
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59576=
80 ffff8800b5957670 ffffffff8143b533 ffff8800b59576f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0dffffc00000000=
00 0000000000000046 ffff8800b5957828 ffff8800b5957718
Jan 01 15:17:01 localhost.localdomain kernel: Call Trace:
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
7da7>] dump_stack+0x4b/0x74
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
b533>] kasan_report_error+0x3b3/0x3e0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
1a0e>] ? vsnprintf+0x3be/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
b69c>] __asan_report_load4_noabort+0x5c/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
2f52>] ? vsnprintf+0x1902/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
2f52>] vsnprintf+0x1902/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
1650>] ? pointer.isra.22+0x980/0x980
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
ac66>] ? memcpy+0x36/0x40
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
3094>] vsprintf+0x14/0x20
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4b49>] acpi_os_vprintf+0x16/0x2b
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4bfc>] acpi_os_printf+0x9e/0xca
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4b5e>] ? acpi_os_vprintf+0x2b/0x2b
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b3=
387a>] acpi_exception+0xf1/0x132
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b3=
3789>] ? acpi_bios_warning+0x117/0x117
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
bf5b>] ? acpi_ns_evaluate+0xb3/0x853
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
ab0e>] ? kasan_kmalloc+0x5e/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
8d98>] acpi_get_sleep_type_data+0x549/0x568
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
76fd>] acpi_hw_legacy_wake_prep+0x83/0x227
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
767a>] ? acpi_hw_legacy_sleep+0x3bd/0x3bd
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
8415>] ? acpi_write_bit_register+0x288/0x2ce
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
818d>] ? acpi_read_bit_register+0x196/0x196
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
9069>] acpi_hw_sleep_dispatch+0xb0/0xb5
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
9080>] acpi_leave_sleep_state_prep+0x12/0x14
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
8ec7>] acpi_suspend_enter+0x10e/0x19a
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
8db9>] ? trace_suspend_resume+0xe0/0xe0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
2344>] suspend_devices_and_enter+0x964/0xdf0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8135=
eebd>] ? printk+0xa3/0xd3
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
19e0>] ? arch_suspend_enable_irqs+0x10/0x10
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e2f0>] ? sysfs_kf_bin_read+0x2c0/0x2c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
2cc9>] pm_suspend+0x4f9/0x690
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e2f0>] ? sysfs_kf_bin_read+0x2c0/0x2c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811b=
fcf5>] state_store+0x85/0x90
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
d250>] ? kobj_attr_show+0x60/0x60
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
d286>] kobj_attr_store+0x36/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e41c>] sysfs_kf_write+0x12c/0x1f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
c2b8>] kernfs_fop_write+0x1f8/0x3a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
eb8a>] __vfs_write+0xea/0x400
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
eaa0>] ? __vfs_read+0x3f0/0x3f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff813d=
e3f9>] ? handle_mm_fault+0x1579/0x34a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff813f=
302f>] ? do_mmap+0x66f/0x900
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff817c=
7ca5>] ? selinux_file_permission+0x2d5/0x430
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff817a=
8eaa>] ? security_file_permission+0x6a/0x1a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
ffa7>] ? rw_verify_area+0xb7/0x290
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
0594>] vfs_write+0x134/0x4c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
32b2>] SyS_write+0x112/0x240
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
31a0>] ? SyS_read+0x240/0x240
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8265=
3ad7>] entry_SYSCALL_64_fastpath+0x12/0x6a
Jan 01 15:17:01 localhost.localdomain kernel: Memory state around the b=
uggy address:
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59577=
00: 00 00 00 f1 f1 f1 f1 00 f4 f4 f4 f3 f3 f3 f3 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59577=
80: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
Jan 01 15:17:01 localhost.localdomain kernel: >ffff8800b5957800: 00 f4 =
f3 f3 f3 f3 f1 f1 f1 f1 00 00 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0^
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59578=
80: f1 f1 f1 f1 00 00 00 f4 f3 f3 f3 f3 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59579=
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 01 15:17:01 localhost.localdomain kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 01 15:17:01 localhost.localdomain kernel: BUG: KASan: out of bounds=
 on stack in vsnprintf+0x14c4/0x1a00 at addr ffff8800b5957840
Jan 01 15:17:01 localhost.localdomain kernel: Read of size 8 by task sy=
stemd-sleep/5375
Jan 01 15:17:01 localhost.localdomain kernel: page:ffffea0002d655c0 cou=
nt:0 mapcount:0 mapping:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(null) index:0x0
Jan 01 15:17:01 localhost.localdomain kernel: flags: 0x4000000000000000=
()
Jan 01 15:17:01 localhost.localdomain kernel: page dumped because: kasa=
n: bad access detected
Jan 01 15:17:01 localhost.localdomain kernel: CPU: 0 PID: 5375 Comm: sy=
stemd-sleep Not tainted 4.3.3 #15
Jan 01 15:17:01 localhost.localdomain kernel: Hardware name: Acer Aspir=
e 1810T/JM11-MS, BIOS v1.3310 03/25/2010
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59578=
40 000000006c6dad1e ffff8800b59575f8 ffffffff81937da7
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59576=
80 ffff8800b5957670 ffffffff8143b533 0000000000000008
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0dffffc00000000=
00 0000000000000046 ffffed0016b2af10 0000000041b58ab3
Jan 01 15:17:01 localhost.localdomain kernel: Call Trace:
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
7da7>] dump_stack+0x4b/0x74
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
b533>] kasan_report_error+0x3b3/0x3e0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8195=
e680>] ? dentry_name.isra.13+0x720/0x720
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
b70c>] __asan_report_load8_noabort+0x5c/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
2b14>] ? vsnprintf+0x14c4/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
2b14>] vsnprintf+0x14c4/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
1650>] ? pointer.isra.22+0x980/0x980
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
ac66>] ? memcpy+0x36/0x40
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
3094>] vsprintf+0x14/0x20
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4b49>] acpi_os_vprintf+0x16/0x2b
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4bfc>] acpi_os_printf+0x9e/0xca
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4b5e>] ? acpi_os_vprintf+0x2b/0x2b
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b3=
387a>] acpi_exception+0xf1/0x132
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b3=
3789>] ? acpi_bios_warning+0x117/0x117
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
bf5b>] ? acpi_ns_evaluate+0xb3/0x853
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
ab0e>] ? kasan_kmalloc+0x5e/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
8d98>] acpi_get_sleep_type_data+0x549/0x568
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
76fd>] acpi_hw_legacy_wake_prep+0x83/0x227
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
767a>] ? acpi_hw_legacy_sleep+0x3bd/0x3bd
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
8415>] ? acpi_write_bit_register+0x288/0x2ce
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
818d>] ? acpi_read_bit_register+0x196/0x196
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
9069>] acpi_hw_sleep_dispatch+0xb0/0xb5
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
9080>] acpi_leave_sleep_state_prep+0x12/0x14
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
8ec7>] acpi_suspend_enter+0x10e/0x19a
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
8db9>] ? trace_suspend_resume+0xe0/0xe0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
2344>] suspend_devices_and_enter+0x964/0xdf0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8135=
eebd>] ? printk+0xa3/0xd3
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
19e0>] ? arch_suspend_enable_irqs+0x10/0x10
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e2f0>] ? sysfs_kf_bin_read+0x2c0/0x2c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
2cc9>] pm_suspend+0x4f9/0x690
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e2f0>] ? sysfs_kf_bin_read+0x2c0/0x2c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811b=
fcf5>] state_store+0x85/0x90
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
d250>] ? kobj_attr_show+0x60/0x60
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
d286>] kobj_attr_store+0x36/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e41c>] sysfs_kf_write+0x12c/0x1f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
c2b8>] kernfs_fop_write+0x1f8/0x3a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
eb8a>] __vfs_write+0xea/0x400
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
eaa0>] ? __vfs_read+0x3f0/0x3f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff813d=
e3f9>] ? handle_mm_fault+0x1579/0x34a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff813f=
302f>] ? do_mmap+0x66f/0x900
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff817c=
7ca5>] ? selinux_file_permission+0x2d5/0x430
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff817a=
8eaa>] ? security_file_permission+0x6a/0x1a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
ffa7>] ? rw_verify_area+0xb7/0x290
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
0594>] vfs_write+0x134/0x4c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
32b2>] SyS_write+0x112/0x240
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
31a0>] ? SyS_read+0x240/0x240
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8265=
3ad7>] entry_SYSCALL_64_fastpath+0x12/0x6a
Jan 01 15:17:01 localhost.localdomain kernel: Memory state around the b=
uggy address:
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59577=
00: 00 00 00 f1 f1 f1 f1 00 f4 f4 f4 f3 f3 f3 f3 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59577=
80: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
Jan 01 15:17:01 localhost.localdomain kernel: >ffff8800b5957800: 00 f4 =
f3 f3 f3 f3 f1 f1 f1 f1 00 00 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0^
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59578=
80: f1 f1 f1 f1 00 00 00 f4 f3 f3 f3 f3 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59579=
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 01 15:17:01 localhost.localdomain kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 01 15:17:01 localhost.localdomain kernel: BUG: KASan: out of bounds=
 on stack in vsnprintf+0x1902/0x1a00 at addr ffff8800b5957848
Jan 01 15:17:01 localhost.localdomain kernel: Read of size 4 by task sy=
stemd-sleep/5375
Jan 01 15:17:01 localhost.localdomain kernel: page:ffffea0002d655c0 cou=
nt:0 mapcount:0 mapping:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(null) index:0x0
Jan 01 15:17:01 localhost.localdomain kernel: flags: 0x4000000000000000=
()
Jan 01 15:17:01 localhost.localdomain kernel: page dumped because: kasa=
n: bad access detected
Jan 01 15:17:01 localhost.localdomain kernel: CPU: 0 PID: 5375 Comm: sy=
stemd-sleep Not tainted 4.3.3 #15
Jan 01 15:17:01 localhost.localdomain kernel: Hardware name: Acer Aspir=
e 1810T/JM11-MS, BIOS v1.3310 03/25/2010
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59578=
48 000000006c6dad1e ffff8800b59575f8 ffffffff81937da7
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59576=
80 ffff8800b5957670 ffffffff8143b533 0000000000000010
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0dffffc00000000=
00 0000000000000046 ffffed0016b2af08 6666662041b58ab3
Jan 01 15:17:01 localhost.localdomain kernel: Call Trace:
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
7da7>] dump_stack+0x4b/0x74
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
b533>] kasan_report_error+0x3b3/0x3e0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
b69c>] __asan_report_load4_noabort+0x5c/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
2f52>] ? vsnprintf+0x1902/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
2f52>] vsnprintf+0x1902/0x1a00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
1650>] ? pointer.isra.22+0x980/0x980
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
ac66>] ? memcpy+0x36/0x40
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8196=
3094>] vsprintf+0x14/0x20
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4b49>] acpi_os_vprintf+0x16/0x2b
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4bfc>] acpi_os_printf+0x9e/0xca
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
4b5e>] ? acpi_os_vprintf+0x2b/0x2b
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b3=
387a>] acpi_exception+0xf1/0x132
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b3=
3789>] ? acpi_bios_warning+0x117/0x117
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
bf5b>] ? acpi_ns_evaluate+0xb3/0x853
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8143=
ab0e>] ? kasan_kmalloc+0x5e/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
8d98>] acpi_get_sleep_type_data+0x549/0x568
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
76fd>] acpi_hw_legacy_wake_prep+0x83/0x227
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
767a>] ? acpi_hw_legacy_sleep+0x3bd/0x3bd
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
8415>] ? acpi_write_bit_register+0x288/0x2ce
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
818d>] ? acpi_read_bit_register+0x196/0x196
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
9069>] acpi_hw_sleep_dispatch+0xb0/0xb5
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81b0=
9080>] acpi_leave_sleep_state_prep+0x12/0x14
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
8ec7>] acpi_suspend_enter+0x10e/0x19a
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff81ab=
8db9>] ? trace_suspend_resume+0xe0/0xe0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
2344>] suspend_devices_and_enter+0x964/0xdf0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8135=
eebd>] ? printk+0xa3/0xd3
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
19e0>] ? arch_suspend_enable_irqs+0x10/0x10
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e2f0>] ? sysfs_kf_bin_read+0x2c0/0x2c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811c=
2cc9>] pm_suspend+0x4f9/0x690
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e2f0>] ? sysfs_kf_bin_read+0x2c0/0x2c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff811b=
fcf5>] state_store+0x85/0x90
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
d250>] ? kobj_attr_show+0x60/0x60
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8193=
d286>] kobj_attr_store+0x36/0x70
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
e41c>] sysfs_kf_write+0x12c/0x1f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff815d=
c2b8>] kernfs_fop_write+0x1f8/0x3a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
eb8a>] __vfs_write+0xea/0x400
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
eaa0>] ? __vfs_read+0x3f0/0x3f0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff813d=
e3f9>] ? handle_mm_fault+0x1579/0x34a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff813f=
302f>] ? do_mmap+0x66f/0x900
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff817c=
7ca5>] ? selinux_file_permission+0x2d5/0x430
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff817a=
8eaa>] ? security_file_permission+0x6a/0x1a0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8146=
ffa7>] ? rw_verify_area+0xb7/0x290
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
0594>] vfs_write+0x134/0x4c0
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
32b2>] SyS_write+0x112/0x240
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8147=
31a0>] ? SyS_read+0x240/0x240
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0[<ffffffff8265=
3ad7>] entry_SYSCALL_64_fastpath+0x12/0x6a
Jan 01 15:17:01 localhost.localdomain kernel: Memory state around the b=
uggy address:
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59577=
00: 00 00 00 f1 f1 f1 f1 00 f4 f4 f4 f3 f3 f3 f3 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59577=
80: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
Jan 01 15:17:01 localhost.localdomain kernel: >ffff8800b5957800: 00 f4 =
f3 f3 f3 f3 f1 f1 f1 f1 00 00 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59578=
80: f1 f1 f1 f1 00 00 00 f4 f3 f3 f3 f3 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0ffff8800b59579=
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Jan 01 15:17:01 localhost.localdomain kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 01 15:17:01 localhost.localdomain kernel:=C2=A0=C2=A0(20150818/hwxf=
ace-580)
Jan 01 15:17:01 localhost.localdomain kernel: ACPI : EC: EC started
Jan 01 15:17:01 localhost.localdomain kernel: PM: Restoring platform NV=
S memory
