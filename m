From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] Crash in acpi_ps_peek_opcode when booting kernel
 3.19 as Xen dom0
Date: Mon, 09 Feb 2015 14:49:58 +0100
Message-ID: <54D8BB06.3080507@suse.com>
References: <54D37F1E.5060208@canonical.com>	<20150205193610.GD11646@x230.dumpdata.com>	<54D8B12D.90902@canonical.com> <54D8B73B.5030703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33405 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759882AbbBINuB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Feb 2015 08:50:01 -0500
In-Reply-To: <54D8B73B.5030703@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, David Vrabel <david.vrabel@citrix.com>

On 02/09/2015 02:33 PM, Stefan Bader wrote:
> On 09.02.2015 14:07, Stefan Bader wrote:
>> On 05.02.2015 20:36, Konrad Rzeszutek Wilk wrote:
>>> On Thu, Feb 05, 2015 at 03:33:02PM +0100, Stefan Bader wrote:
>>>> While experimenting/testing various kernel versions I discovered t=
hat trying to
>>>> boot a Haswell based hosts will always crash when booting as Xen d=
om0
>>>> (Xen-4.4.1). The same crash happens since v3.19-rc1 and still does=
 happen with
>>>> v3.19-rc7. A bare metal boot is having no issues and also an Opter=
on based host
>>>> is having no issues (dom0 and bare metal).
>>>> Could be a table that the other host does not have and since its o=
nly happening
>>>> in dom0 maybe some cpu capability that needs to be passed on?
>>>
>>> Usually it means that the ACPI AML code is trying to do something w=
ith
>>> the IOAPIC or something wihch is not accessible.
>>>
>>> But this on the other hand looks to be trying to execute some AML c=
ode
>>> that is unknown. Any chance you cna disassemble it and perhaps also
>>> run with acpi debug options on to figure out where it blows up?
>>
>> The weird thing here is that bare-metal on the same machine does wor=
k. And
>> previous kernels did work as well. So I think we can assume the ACPI=
 tables are
>> ok. It could even be a red-herring. Well, likely is as booting with =
acpi=3Doff
>> does hang instead of crashing.
>>
>> Since I got no clue, I did what we always do when we are dumbfound, =
I went ahead
>> and bisected 3.18..3.19-rc1. Unfortunately the very last kernel I bu=
ild was
>> something in between good and bad. Good as it did not crash exactly =
but bad as
>> it did not come up in a usable state. So I would not be sure the cla=
imed to be
>> offending commit is right. Could be one in the range of:
>>
>> G  * xen: use common page allocation function in p2m.c
>>     * xen: Delay remapping memory of pv-domain
>> g  * xen: Delay m2p_override initialization
>> -> * xen: Delay invalidating extra memory
>> B  * x86: Introduce function to get pmd entry pointer
>>
>> (G) really good, (g) somewhat not bad, (B) bad, (->) claimed first b=
roken.
>
> Oh, since that all sounds related to E820 in some way:
>
> (XEN) Xen-e820 RAM map:
> (XEN)  0000000000000000 - 000000000009a400 (usable)
> (XEN)  000000000009a400 - 00000000000a0000 (reserved)
> (XEN)  00000000000e0000 - 0000000000100000 (reserved)
> (XEN)  0000000000100000 - 0000000030a48000 (usable)
> (XEN)  0000000030a48000 - 0000000030a49000 (reserved)

Hmm, this memory hole is at a rather low address. Could it be some
vital data (one of kernel, page tables, initrd or p2m map) is located
at this address?

This would be a problem similar to the one I ran into when trying to
test on a machine with 1TB of memory, where the p2m map was too big
to fit into contiguous memory.

Could you check the addresses where the hypervisor puts this data for
Dom0?


Juergen

> (XEN)  0000000030a49000 - 00000000a27f4000 (usable)
> (XEN)  00000000a27f4000 - 00000000a2ab4000 (reserved)
> (XEN)  00000000a2ab4000 - 00000000a2fb4000 (ACPI NVS)
> (XEN)  00000000a2fb4000 - 00000000a2feb000 (ACPI data)
> (XEN)  00000000a2feb000 - 00000000a3000000 (usable)
> (XEN)  00000000a3000000 - 00000000afa00000 (reserved)
> (XEN)  00000000e0000000 - 00000000f0000000 (reserved)
> (XEN)  00000000fec00000 - 00000000fec01000 (reserved)
> (XEN)  00000000fed00000 - 00000000fed04000 (reserved)
> (XEN)  00000000fed10000 - 00000000fed1a000 (reserved)
> (XEN)  00000000fed1c000 - 00000000fed20000 (reserved)
> (XEN)  00000000fed84000 - 00000000fed85000 (reserved)
> (XEN)  00000000fee00000 - 00000000fee01000 (reserved)
> (XEN)  00000000ffc00000 - 0000000100000000 (reserved)
> (XEN)  0000000100000000 - 000000024e600000 (usable)
>
> and how it looks with a 3.18 boot:
>
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] Xen: [mem 0x0000000000000000-0x0000000000099fff] usabl=
e
> [    0.000000] Xen: [mem 0x000000000009a400-0x00000000000fffff] reser=
ved
> [    0.000000] Xen: [mem 0x0000000000100000-0x0000000030a47fff] usabl=
e
> [    0.000000] Xen: [mem 0x0000000030a48000-0x0000000030a48fff] reser=
ved
> [    0.000000] Xen: [mem 0x0000000030a49000-0x00000000a27f3fff] usabl=
e
> [    0.000000] Xen: [mem 0x00000000a27f4000-0x00000000a2ab3fff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000a2ab4000-0x00000000a2fb3fff] ACPI =
NVS
> [    0.000000] Xen: [mem 0x00000000a2fb4000-0x00000000a2feafff] ACPI =
data
> [    0.000000] Xen: [mem 0x00000000a2feb000-0x00000000a2ffffff] usabl=
e
> [    0.000000] Xen: [mem 0x00000000a3000000-0x00000000af9fffff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000fed00000-0x00000000fed03fff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000fed10000-0x00000000fed19fff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000fed1c000-0x00000000fed1ffff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000fed84000-0x00000000fed84fff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000fee00000-0x00000000feefffff] reser=
ved
> [    0.000000] Xen: [mem 0x00000000ffc00000-0x00000000ffffffff] reser=
ved
> [    0.000000] Xen: [mem 0x0000000100000000-0x00000001bdc59fff] usabl=
e
> [    0.000000] Xen: [mem 0x00000001bdc5a000-0x000000024e5fffff] unusa=
ble
>
> Not sure that helps much. I probably have to try comparing later outp=
ut. But
> that will need a bit of time.
>
> -Stefan
>
>>
>> So it seems one of the delaying changes has a very bad effect on tha=
t Sharkbay.
>> A bit odd since none of those sounds Intel/AMD geared. Could only be=
 a different
>> usage of memory (my AMD box has considerably more memory and also no=
 CPU with
>> GPU functionality as the Haswell).
>>
>> J=FCrgen, maybe some description that might trigger an idea for you.=
=2E.?
>>
>> -Stefan
>>
>> ---
>>
>> git bisect start
>> # good: [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18
>> git bisect good b2776bf7149bddd1f4161f14f79520f17fc1d71d
>> # bad: [97bf6af1f928216fd6c5a66e8a57bfa95a659672] Linux 3.19-rc1
>> git bisect bad 97bf6af1f928216fd6c5a66e8a57bfa95a659672
>> # good: [70e71ca0af244f48a5dcf56dc435243792e3a495] Merge
>> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
>> git bisect good 70e71ca0af244f48a5dcf56dc435243792e3a495
>> # good: [988adfdffdd43cfd841df734664727993076d7cb] Merge branch 'drm=
-next' of
>> git://people.freedesktop.org/~airlied/linux
>> git bisect good 988adfdffdd43cfd841df734664727993076d7cb
>> # good: [b024793188002b9eed452b5f6a04d45003ed5772] staging: rtl8723a=
u:
>> phy_SsPwrSwitch92CU() was never called with bRegSSPwrLvl !=3D 1
>> git bisect good b024793188002b9eed452b5f6a04d45003ed5772
>> # bad: [66dcff86ba40eebb5133cccf450878f2bba102ef] Merge tag 'for-lin=
us' of
>> git://git.kernel.org/pub/scm/virt/kvm/kvm
>> git bisect bad 66dcff86ba40eebb5133cccf450878f2bba102ef
>> # bad: [d6666be6f0c43efb9475d1d35fbef9f8be61b7b1] Merge tag 'for-lin=
us-20141215'
>> of git://git.infradead.org/linux-mtd
>> git bisect bad d6666be6f0c43efb9475d1d35fbef9f8be61b7b1
>> # bad: [94bbdb63d7ed5ca56b788e43d0ca4a8f9494c9e7] Merge tag 'fixes-f=
or-linus' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>> git bisect bad 94bbdb63d7ed5ca56b788e43d0ca4a8f9494c9e7
>> # good: [2dbfca5a181973558277b28b1f4c36362291f5e0] Merge branch 'for=
-next' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/cooloney/linux-leds
>> git bisect good 2dbfca5a181973558277b28b1f4c36362291f5e0
>> # bad: [0db2812a5240f2663b92d8d4b761122dd2e0c6c3] Merge
>> git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile
>> git bisect bad 0db2812a5240f2663b92d8d4b761122dd2e0c6c3
>> # bad: [f1d04b23b2015b4c3c0a8419677179b133afea08] Merge branch
>> 'devel/for-linus-3.19' into stable/for-linus-3.19
>> git bisect bad f1d04b23b2015b4c3c0a8419677179b133afea08
>> # bad: [792230c3a66b3d17d6dcca712866d24f2283d4a6] x86: Introduce fun=
ction to get
>> pmd entry pointer
>> git bisect bad 792230c3a66b3d17d6dcca712866d24f2283d4a6
>> # good: [7108c9ce8f6e59f775b0c8250dba52b569b6cba2] xen: use common p=
age
>> allocation function in p2m.c
>> # NOTE: This was the last really good
>> git bisect good 7108c9ce8f6e59f775b0c8250dba52b569b6cba2
>> # good: [97f4533a60ce5d0cb35ff44a190111f81a987620] xen: Delay m2p_ov=
erride
>> initialization
>> # NOTE: This revision did not crash the usual way but was not useabl=
e either
>> # NOTE: Use of wrong bits in page-tables.
>> git bisect good 97f4533a60ce5d0cb35ff44a190111f81a987620
>>>
>>>>
>>>> [    2.108038] ACPI: Core revision 20141107
>>>> [    2.108153] ACPI Warning: Unsupported module-level executable o=
pcode 0x91 at
>>>> table offset 0x002B (20141107/psloop-225)
>>>> [    2.108264] ACPI Warning: Unsupported module-level executable o=
pcode 0x91 at
>>>> table offset 0x0033 (20141107/psloop-225)
>>>> [    2.108375] ACPI Warning: Unsupported module-level executable o=
pcode 0x95 at
>>>> table offset 0x0038 (20141107/psloop-225)
>>>> [    2.108489] ACPI Warning: Unsupported module-level executable o=
pcode 0x95 at
>>>> table offset 0x0041 (20141107/psloop-225)
>>>> [    2.108613] ACPI Warning: Unsupported module-level executable o=
pcode 0x7D at
>>>> table offset 0x040D (20141107/psloop-225)
>>>> [    2.108751] BUG: unable to handle kernel paging request at ffff=
c90000ee74e0
>>>> [    2.108835] IP: [<ffffffff814573db>] acpi_ps_peek_opcode+0xd/0x=
1f
>>>> [    2.108902] PGD 1f4be067 PUD 1f4bd067 PMD 1488f067 PTE 0
>>>> [    2.109018] Oops: 0000 [#1] SMP
>>>> [    2.109094] Modules linked in:
>>>> [    2.109153] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.19.0-03=
1900rc7-generi
>>>> c #201502020035
>>>> [    2.109220] Hardware name: Intel Corporation Shark Bay Client p=
latform/Flathe
>>>> ad Creek Crb, BIOS HSWLPTU1.86C.0109.R03.1301282055 01/28/2013
>>>> [    2.109295] task: ffffffff81c1c500 ti: ffffffff81c00000 task.ti=
: ffffffff81c0
>>>> 0000
>>>> [    2.109360] RIP: e030:[<ffffffff814573db>]  [<ffffffff814573db>=
] acpi_ps_peek
>>>> _opcode+0xd/0x1f
>>>> [    2.109445] RSP: e02b:ffffffff81c03ce8  EFLAGS: 00010283
>>>> [    2.109490] RAX: 000000000000000c RBX: ffff880014887000 RCX: ff=
ffffff81c03d50
>>>> [    2.109539] RDX: ffffc90000ee74e0 RSI: ffff880014887030 RDI: ff=
ff880014887030
>>>> [    2.109587] RBP: ffffffff81c03ce8 R08: ffffea0000522600 R09: ff=
ffffff81432c4f
>>>> [    2.109635] R10: ffff880014899090 R11: 00000000000000ba R12: ff=
ff880014887030
>>>> [    2.109684] R13: ffff880014887000 R14: ffffffff81c03d50 R15: 00=
0000000000000d
>>>> [    2.109735] FS:  0000000000000000(0000) GS:ffff880018c00000(000=
0) knlGS:00000
>>>> 00000000000
>>>> [    2.109836] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [    2.109881] CR2: ffffc90000ee74e0 CR3: 0000000001c15000 CR4: 00=
00000000042660
>>>> [    2.109930] Stack:
>>>> [    2.109968]  ffffffff81c03d38 ffffffff81456537 ffffffff81c03d28=
 ffffffff81457
>>>> a40
>>>> [    2.110104]  ffff880014887000 ffff880014887000 ffff8800148990c0=
 ffffc90000ee7
>>>> 4e0
>>>> [    2.110238]  ffff880014887030 0000000000000000 ffffffff81c03d78=
 ffffffff81456
>>>> 760
>>>> [    2.110373] Call Trace:
>>>> [    2.110413]  [<ffffffff81456537>] acpi_ps_get_next_arg+0x114/0x=
1f9
>>>> [    2.110461]  [<ffffffff81457a40>] ? acpi_ps_pop_scope+0x54/0x72
>>>> [    2.110508]  [<ffffffff81456760>] acpi_ps_get_arguments+0x91/0x=
228
>>>> [    2.110555]  [<ffffffff81456ad2>] acpi_ps_parse_loop+0x1db/0x31=
1
>>>> [    2.110602]  [<ffffffff81457705>] acpi_ps_parse_aml+0x96/0x275
>>>> [    2.110649]  [<ffffffff8145322f>] acpi_ns_one_complete_parse+0x=
f7/0x114
>>>> [    2.110698]  [<ffffffff817d149a>] ? _raw_spin_lock_irqsave+0x1a=
/0x60
>>>> [    2.110746]  [<ffffffff8145326c>] acpi_ns_parse_table+0x20/0x38
>>>> [    2.110792]  [<ffffffff81452c20>] acpi_ns_load_table+0x4c/0x90
>>>> [    2.110840]  [<ffffffff817c50b5>] acpi_tb_load_namespace+0xa6/0=
x14a
>>>> [    2.110889]  [<ffffffff81d83269>] acpi_load_tables+0xc/0x35
>>>> [    2.110935]  [<ffffffff81454bf6>] ? acpi_ns_get_node+0xb7/0xc9
>>>> [    2.110982]  [<ffffffff81d825cf>] acpi_early_init+0x73/0x105
>>>> [    2.111029]  [<ffffffff81d3b083>] start_kernel+0x348/0x3f0
>>>> [    2.111075]  [<ffffffff81d3abcd>] ? set_init_arg+0x56/0x56
>>>> [    2.111121]  [<ffffffff81d3a5f8>] x86_64_start_reservations+0x2=
a/0x2c
>>>> [    2.111169]  [<ffffffff81d3e88c>] xen_start_kernel+0x4f5/0x4f7
>>>> [    2.111215] Code: 8a 87 60 05 87 81 5d c3 e8 73 cc 37 00 55 81 =
ff 00 01 00 00
>>>>   19 c0 48 89 e5 83 c0 02 5d c3 e8 5d cc 3
>>>>
>>>
>>>
>>>
>>>> _______________________________________________
>>>> Xen-devel mailing list
>>>> Xen-devel@lists.xen.org
>>>> http://lists.xen.org/xen-devel
>>>
>>
>>
>
>
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
