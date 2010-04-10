From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: new kmemleak w/ latest ACPI updates
Date: Sat, 10 Apr 2010 21:02:56 +0200
Message-ID: <201004102102.57235.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42738 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751992Ab0DJTDA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Apr 2010 15:03:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

running git kernel v2.6.34-rc3-500-g0eddb51 I observe this new kmemleak=
 :

unreferenced object 0xcd3fe6a0 (size 32):
  comm "pm-suspend", pid 21698, jiffies 9344750 (age 1363.181s)
  hex dump (first 32 bytes):
    34 32 54 34 36 34 34 00 34 32 54 34 36 34 34 00  42T4644.42T4644.
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<c122cb0d>] kmemleak_alloc+0x3d/0x60
    [<c109c8c2>] __kmalloc+0xf2/0x120
    [<c1162c0f>] acpi_ut_create_buffer_object+0x49/0x83
    [<c115303b>] acpi_ex_read_data_from_field+0xbe/0x12b
    [<c1157988>] acpi_ex_resolve_node_to_value+0x154/0x1c8
    [<c1153950>] acpi_ex_resolve_to_value+0x1bc/0x1c8
    [<c114e9c3>] acpi_ds_evaluate_name_path+0x6e/0xe3
    [<c114d8c0>] acpi_ds_exec_end_op+0x88/0x368
    [<c115da04>] acpi_ps_parse_loop+0x701/0x855
    [<c115cd0a>] acpi_ps_parse_aml+0x87/0x261
    [<c115e0df>] acpi_ps_execute_method+0x18e/0x247
    [<c1159dcf>] acpi_ns_evaluate+0xcb/0x17c
    [<c115990c>] acpi_evaluate_object+0x10e/0x1eb
    [<f80cb37a>] acpi_battery_update+0xb3/0x200 [battery]
    [<f80cb54e>] acpi_battery_resume+0x20/0x24 [battery]
    [<c114603a>] acpi_device_resume+0x1e/0x24

which might be introduced by the ACPi changes since f5284e I think.

--=20
MfG/Sincerely
Toralf F=F6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
