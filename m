From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: Memory leak on acpi_add_single_object()
Date: Fri, 4 Sep 2009 15:34:03 -0700
Message-ID: <43e72e890909041534v4a4ec6ecpc6198be37adcfdef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934424AbZIDWeX@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-acpi@vger.kernel.org

Here are 3 acpi_add_single_object() kmemleak reports on 2.6.31-rc8 +
Catalin's kmemleak tree (git://linux-arm.org/linux-2.6 master).

unreferenced object 0xffff88003c405940 (size 64):
  comm "swapper", pid 1, jiffies 4294892466
  hex dump (first 32 bytes):
    00 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  ....8...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814e9d55>] kmemleak_alloc+0x25/0x60
    [<ffffffff81119fbb>] __kmalloc+0x16b/0x250
    [<ffffffff812bb379>] kzalloc+0xf/0x11
    [<ffffffff812bb983>] acpi_add_single_object+0x58e/0xd3c
    [<ffffffff812bc34c>] acpi_bus_scan+0x125/0x1af
    [<ffffffff81818842>] acpi_scan_init+0xc8/0xe9
    [<ffffffff818185fd>] acpi_init+0x21f/0x265
    [<ffffffff8100a047>] do_one_initcall+0x37/0x1a0
    [<ffffffff817efa16>] kernel_init+0x164/0x1ba
    [<ffffffff810130ca>] child_rip+0xa/0x20
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff88003c405980 (size 64):
  comm "swapper", pid 1, jiffies 4294892467
  hex dump (first 32 bytes):
    00 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  ....8...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814e9d55>] kmemleak_alloc+0x25/0x60
    [<ffffffff81119fbb>] __kmalloc+0x16b/0x250
    [<ffffffff812bb379>] kzalloc+0xf/0x11
    [<ffffffff812bb983>] acpi_add_single_object+0x58e/0xd3c
    [<ffffffff812bc34c>] acpi_bus_scan+0x125/0x1af
    [<ffffffff81818842>] acpi_scan_init+0xc8/0xe9
    [<ffffffff818185fd>] acpi_init+0x21f/0x265
    [<ffffffff8100a047>] do_one_initcall+0x37/0x1a0
    [<ffffffff817efa16>] kernel_init+0x164/0x1ba
    [<ffffffff810130ca>] child_rip+0xa/0x20
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff88003c4059c0 (size 64):
  comm "swapper", pid 1, jiffies 4294892470
  hex dump (first 32 bytes):
    00 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  ....8...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814e9d55>] kmemleak_alloc+0x25/0x60
    [<ffffffff81119fbb>] __kmalloc+0x16b/0x250
    [<ffffffff812bb379>] kzalloc+0xf/0x11
    [<ffffffff812bb983>] acpi_add_single_object+0x58e/0xd3c
    [<ffffffff812bc34c>] acpi_bus_scan+0x125/0x1af
    [<ffffffff81818842>] acpi_scan_init+0xc8/0xe9
    [<ffffffff818185fd>] acpi_init+0x21f/0x265
    [<ffffffff8100a047>] do_one_initcall+0x37/0x1a0
    [<ffffffff817efa16>] kernel_init+0x164/0x1ba
    [<ffffffff810130ca>] child_rip+0xa/0x20
    [<ffffffffffffffff>] 0xffffffffffffffff

  Luis
