From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: Re: Memory leak on acpi_add_single_object()
Date: Fri, 4 Sep 2009 17:15:47 -0700
Message-ID: <43e72e890909041715p203a06a8h7e836ecffdfc2eaa@mail.gmail.com>
References: <43e72e890909041534v4a4ec6ecpc6198be37adcfdef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f175.google.com ([209.85.223.175]:62307 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934059AbZIEAQF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2009 20:16:05 -0400
In-Reply-To: <43e72e890909041534v4a4ec6ecpc6198be37adcfdef@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>

On Fri, Sep 4, 2009 at 3:34 PM, Luis R. Rodriguez<mcgrof@gmail.com> wro=
te:
> Here are 3 acpi_add_single_object() kmemleak reports on 2.6.31-rc8 +
> Catalin's kmemleak tree (git://linux-arm.org/linux-2.6 master).
>
> unreferenced object 0xffff88003c405940 (size 64):
> =C2=A0comm "swapper", pid 1, jiffies 4294892466
> =C2=A0hex dump (first 32 bytes):
> =C2=A0 =C2=A000 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00 =C2=A0..=
=2E.8...........
> =C2=A0 =C2=A000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =C2=A0..=
=2E.............
> =C2=A0backtrace:
> =C2=A0 =C2=A0[<ffffffff814e9d55>] kmemleak_alloc+0x25/0x60
> =C2=A0 =C2=A0[<ffffffff81119fbb>] __kmalloc+0x16b/0x250
> =C2=A0 =C2=A0[<ffffffff812bb379>] kzalloc+0xf/0x11
> =C2=A0 =C2=A0[<ffffffff812bb983>] acpi_add_single_object+0x58e/0xd3c
> =C2=A0 =C2=A0[<ffffffff812bc34c>] acpi_bus_scan+0x125/0x1af
> =C2=A0 =C2=A0[<ffffffff81818842>] acpi_scan_init+0xc8/0xe9
> =C2=A0 =C2=A0[<ffffffff818185fd>] acpi_init+0x21f/0x265
> =C2=A0 =C2=A0[<ffffffff8100a047>] do_one_initcall+0x37/0x1a0
> =C2=A0 =C2=A0[<ffffffff817efa16>] kernel_init+0x164/0x1ba
> =C2=A0 =C2=A0[<ffffffff810130ca>] child_rip+0xa/0x20
> =C2=A0 =C2=A0[<ffffffffffffffff>] 0xffffffffffffffff
> unreferenced object 0xffff88003c405980 (size 64):
> =C2=A0comm "swapper", pid 1, jiffies 4294892467
> =C2=A0hex dump (first 32 bytes):
> =C2=A0 =C2=A000 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00 =C2=A0..=
=2E.8...........
> =C2=A0 =C2=A000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =C2=A0..=
=2E.............
> =C2=A0backtrace:
> =C2=A0 =C2=A0[<ffffffff814e9d55>] kmemleak_alloc+0x25/0x60
> =C2=A0 =C2=A0[<ffffffff81119fbb>] __kmalloc+0x16b/0x250
> =C2=A0 =C2=A0[<ffffffff812bb379>] kzalloc+0xf/0x11
> =C2=A0 =C2=A0[<ffffffff812bb983>] acpi_add_single_object+0x58e/0xd3c
> =C2=A0 =C2=A0[<ffffffff812bc34c>] acpi_bus_scan+0x125/0x1af
> =C2=A0 =C2=A0[<ffffffff81818842>] acpi_scan_init+0xc8/0xe9
> =C2=A0 =C2=A0[<ffffffff818185fd>] acpi_init+0x21f/0x265
> =C2=A0 =C2=A0[<ffffffff8100a047>] do_one_initcall+0x37/0x1a0
> =C2=A0 =C2=A0[<ffffffff817efa16>] kernel_init+0x164/0x1ba
> =C2=A0 =C2=A0[<ffffffff810130ca>] child_rip+0xa/0x20
> =C2=A0 =C2=A0[<ffffffffffffffff>] 0xffffffffffffffff
> unreferenced object 0xffff88003c4059c0 (size 64):
> =C2=A0comm "swapper", pid 1, jiffies 4294892470
> =C2=A0hex dump (first 32 bytes):
> =C2=A0 =C2=A000 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00 =C2=A0..=
=2E.8...........
> =C2=A0 =C2=A000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =C2=A0..=
=2E.............
> =C2=A0backtrace:
> =C2=A0 =C2=A0[<ffffffff814e9d55>] kmemleak_alloc+0x25/0x60
> =C2=A0 =C2=A0[<ffffffff81119fbb>] __kmalloc+0x16b/0x250
> =C2=A0 =C2=A0[<ffffffff812bb379>] kzalloc+0xf/0x11
> =C2=A0 =C2=A0[<ffffffff812bb983>] acpi_add_single_object+0x58e/0xd3c
> =C2=A0 =C2=A0[<ffffffff812bc34c>] acpi_bus_scan+0x125/0x1af
> =C2=A0 =C2=A0[<ffffffff81818842>] acpi_scan_init+0xc8/0xe9
> =C2=A0 =C2=A0[<ffffffff818185fd>] acpi_init+0x21f/0x265
> =C2=A0 =C2=A0[<ffffffff8100a047>] do_one_initcall+0x37/0x1a0
> =C2=A0 =C2=A0[<ffffffff817efa16>] kernel_init+0x164/0x1ba
> =C2=A0 =C2=A0[<ffffffff810130ca>] child_rip+0xa/0x20
> =C2=A0 =C2=A0[<ffffffffffffffff>] 0xffffffffffffffff

I get these even after issuing manual scans.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
