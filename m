From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Crash in acpi_ps_peek_opcode when booting kernel
 3.19 as Xen dom0
Date: Thu, 5 Feb 2015 14:36:11 -0500
Message-ID: <20150205193610.GD11646@x230.dumpdata.com>
References: <54D37F1E.5060208@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36269 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbbBETgU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 14:36:20 -0500
Content-Disposition: inline
In-Reply-To: <54D37F1E.5060208@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Feb 05, 2015 at 03:33:02PM +0100, Stefan Bader wrote:
> While experimenting/testing various kernel versions I discovered that trying to
> boot a Haswell based hosts will always crash when booting as Xen dom0
> (Xen-4.4.1). The same crash happens since v3.19-rc1 and still does happen with
> v3.19-rc7. A bare metal boot is having no issues and also an Opteron based host
> is having no issues (dom0 and bare metal).
> Could be a table that the other host does not have and since its only happening
> in dom0 maybe some cpu capability that needs to be passed on?

Usually it means that the ACPI AML code is trying to do something with
the IOAPIC or something wihch is not accessible.

But this on the other hand looks to be trying to execute some AML code
that is unknown. Any chance you cna disassemble it and perhaps also
run with acpi debug options on to figure out where it blows up?

> 
> [    2.108038] ACPI: Core revision 20141107
> [    2.108153] ACPI Warning: Unsupported module-level executable opcode 0x91 at
> table offset 0x002B (20141107/psloop-225)
> [    2.108264] ACPI Warning: Unsupported module-level executable opcode 0x91 at
> table offset 0x0033 (20141107/psloop-225)
> [    2.108375] ACPI Warning: Unsupported module-level executable opcode 0x95 at
> table offset 0x0038 (20141107/psloop-225)
> [    2.108489] ACPI Warning: Unsupported module-level executable opcode 0x95 at
> table offset 0x0041 (20141107/psloop-225)
> [    2.108613] ACPI Warning: Unsupported module-level executable opcode 0x7D at
> table offset 0x040D (20141107/psloop-225)
> [    2.108751] BUG: unable to handle kernel paging request at ffffc90000ee74e0
> [    2.108835] IP: [<ffffffff814573db>] acpi_ps_peek_opcode+0xd/0x1f
> [    2.108902] PGD 1f4be067 PUD 1f4bd067 PMD 1488f067 PTE 0
> [    2.109018] Oops: 0000 [#1] SMP
> [    2.109094] Modules linked in:
> [    2.109153] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.19.0-031900rc7-generi
> c #201502020035
> [    2.109220] Hardware name: Intel Corporation Shark Bay Client platform/Flathe
> ad Creek Crb, BIOS HSWLPTU1.86C.0109.R03.1301282055 01/28/2013
> [    2.109295] task: ffffffff81c1c500 ti: ffffffff81c00000 task.ti: ffffffff81c0
> 0000
> [    2.109360] RIP: e030:[<ffffffff814573db>]  [<ffffffff814573db>] acpi_ps_peek
> _opcode+0xd/0x1f
> [    2.109445] RSP: e02b:ffffffff81c03ce8  EFLAGS: 00010283
> [    2.109490] RAX: 000000000000000c RBX: ffff880014887000 RCX: ffffffff81c03d50
> [    2.109539] RDX: ffffc90000ee74e0 RSI: ffff880014887030 RDI: ffff880014887030
> [    2.109587] RBP: ffffffff81c03ce8 R08: ffffea0000522600 R09: ffffffff81432c4f
> [    2.109635] R10: ffff880014899090 R11: 00000000000000ba R12: ffff880014887030
> [    2.109684] R13: ffff880014887000 R14: ffffffff81c03d50 R15: 000000000000000d
> [    2.109735] FS:  0000000000000000(0000) GS:ffff880018c00000(0000) knlGS:00000
> 00000000000
> [    2.109836] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.109881] CR2: ffffc90000ee74e0 CR3: 0000000001c15000 CR4: 0000000000042660
> [    2.109930] Stack:
> [    2.109968]  ffffffff81c03d38 ffffffff81456537 ffffffff81c03d28 ffffffff81457
> a40
> [    2.110104]  ffff880014887000 ffff880014887000 ffff8800148990c0 ffffc90000ee7
> 4e0
> [    2.110238]  ffff880014887030 0000000000000000 ffffffff81c03d78 ffffffff81456
> 760
> [    2.110373] Call Trace:
> [    2.110413]  [<ffffffff81456537>] acpi_ps_get_next_arg+0x114/0x1f9
> [    2.110461]  [<ffffffff81457a40>] ? acpi_ps_pop_scope+0x54/0x72
> [    2.110508]  [<ffffffff81456760>] acpi_ps_get_arguments+0x91/0x228
> [    2.110555]  [<ffffffff81456ad2>] acpi_ps_parse_loop+0x1db/0x311
> [    2.110602]  [<ffffffff81457705>] acpi_ps_parse_aml+0x96/0x275
> [    2.110649]  [<ffffffff8145322f>] acpi_ns_one_complete_parse+0xf7/0x114
> [    2.110698]  [<ffffffff817d149a>] ? _raw_spin_lock_irqsave+0x1a/0x60
> [    2.110746]  [<ffffffff8145326c>] acpi_ns_parse_table+0x20/0x38
> [    2.110792]  [<ffffffff81452c20>] acpi_ns_load_table+0x4c/0x90
> [    2.110840]  [<ffffffff817c50b5>] acpi_tb_load_namespace+0xa6/0x14a
> [    2.110889]  [<ffffffff81d83269>] acpi_load_tables+0xc/0x35
> [    2.110935]  [<ffffffff81454bf6>] ? acpi_ns_get_node+0xb7/0xc9
> [    2.110982]  [<ffffffff81d825cf>] acpi_early_init+0x73/0x105
> [    2.111029]  [<ffffffff81d3b083>] start_kernel+0x348/0x3f0
> [    2.111075]  [<ffffffff81d3abcd>] ? set_init_arg+0x56/0x56
> [    2.111121]  [<ffffffff81d3a5f8>] x86_64_start_reservations+0x2a/0x2c
> [    2.111169]  [<ffffffff81d3e88c>] xen_start_kernel+0x4f5/0x4f7
> [    2.111215] Code: 8a 87 60 05 87 81 5d c3 e8 73 cc 37 00 55 81 ff 00 01 00 00
>  19 c0 48 89 e5 83 c0 02 5d c3 e8 5d cc 3
> 



> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel

