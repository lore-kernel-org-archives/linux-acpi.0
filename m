From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: new kmemleak w/ latest ACPI updates
Date: Tue, 13 Apr 2010 10:03:16 +0800
Message-ID: <1271124196.3656.0.camel@minggr.sh.intel.com>
References: <201004102102.57235.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20519 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481Ab0DMCXS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Apr 2010 22:23:18 -0400
In-Reply-To: <201004102102.57235.toralf.foerster@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2010-04-11 at 03:02 +0800, Toralf F=C3=B6rster wrote:
> Hello,
>=20
> running git kernel v2.6.34-rc3-500-g0eddb51 I observe this new kmemle=
ak :
>=20
> unreferenced object 0xcd3fe6a0 (size 32):
>   comm "pm-suspend", pid 21698, jiffies 9344750 (age 1363.181s)
>   hex dump (first 32 bytes):
>     34 32 54 34 36 34 34 00 34 32 54 34 36 34 34 00  42T4644.42T4644.
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<c122cb0d>] kmemleak_alloc+0x3d/0x60
>     [<c109c8c2>] __kmalloc+0xf2/0x120
>     [<c1162c0f>] acpi_ut_create_buffer_object+0x49/0x83
>     [<c115303b>] acpi_ex_read_data_from_field+0xbe/0x12b
>     [<c1157988>] acpi_ex_resolve_node_to_value+0x154/0x1c8
>     [<c1153950>] acpi_ex_resolve_to_value+0x1bc/0x1c8
>     [<c114e9c3>] acpi_ds_evaluate_name_path+0x6e/0xe3
>     [<c114d8c0>] acpi_ds_exec_end_op+0x88/0x368
>     [<c115da04>] acpi_ps_parse_loop+0x701/0x855
>     [<c115cd0a>] acpi_ps_parse_aml+0x87/0x261
>     [<c115e0df>] acpi_ps_execute_method+0x18e/0x247
>     [<c1159dcf>] acpi_ns_evaluate+0xcb/0x17c
>     [<c115990c>] acpi_evaluate_object+0x10e/0x1eb
>     [<f80cb37a>] acpi_battery_update+0xb3/0x200 [battery]
>     [<f80cb54e>] acpi_battery_resume+0x20/0x24 [battery]
>     [<c114603a>] acpi_device_resume+0x1e/0x24
>=20
> which might be introduced by the ACPi changes since f5284e I think.
>=20

Hi,=20

I can't reproduce this.

Could you please send the acpidump output?

Thanks,
Lin Ming

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
