From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Subject: Re: ACPI warning from alloc_pages_nodemask on boot (2.6.33
	regression)
Date: Wed, 30 Dec 2009 15:21:43 +0900
Message-ID: <2f11576a0912292221r7ba59e9dw431c7b43b578a04@mail.gmail.com>
References: <20091229094202.25818e9b@nehalam>
	 <alpine.LFD.2.00.0912291435070.14938@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:58206 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbZL3GVo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 01:21:44 -0500
In-Reply-To: <alpine.LFD.2.00.0912291435070.14938@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org

>> [ =A0 =A01.611664] ACPI Warning: Incorrect checksum in table [OEMB] =
- 94, should be 8C (20091214/tbutils-314)
>> [ =A0 =A01.611698] ACPI: SSDT 00000000bf7980c0 00403 (v01 DpgPmm =A0=
P001Ist 00000011 INTL 20060113)
>> [ =A0 =A01.613966] ACPI: SSDT 00000000bf7984d0 00403 (v01 DpgPmm =A0=
P002Ist 00000012 INTL 20060113)
>> [ =A0 =A01.616242] ACPI: SSDT 00000000bf7988e0 00403 (v01 DpgPmm =A0=
P003Ist 00000012 INTL 20060113)
>> [ =A0 =A01.618526] ACPI: SSDT 00000000bf798cf0 00403 (v01 DpgPmm =A0=
P004Ist 00000012 INTL 20060113)
>> [ =A0 =A01.620817] ACPI: SSDT 00000000bf799100 00403 (v01 DpgPmm =A0=
P005Ist 00000012 INTL 20060113)
>> [ =A0 =A01.623112] ACPI: SSDT 00000000bf799510 00403 (v01 DpgPmm =A0=
P006Ist 00000012 INTL 20060113)
>> [ =A0 =A01.625409] ACPI: SSDT 00000000bf799920 00403 (v01 DpgPmm =A0=
P007Ist 00000012 INTL 20060113)
>> [ =A0 =A01.627734] ACPI: SSDT 00000000bf799d30 00403 (v01 DpgPmm =A0=
P008Ist 00000012 INTL 20060113)
>> [ =A0 =A01.630020] ------------[ cut here ]------------
>> [ =A0 =A01.630026] WARNING: at mm/page_alloc.c:1812 __alloc_pages_no=
demask+0x617/0x730()
>
> =A0 =A0 =A0 =A0if (order >=3D MAX_ORDER) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN=
));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0 =A0 =A0 =A0}
>
> I don't know what the mm alloc code is complaining about here.

first, exceeding MAX_ORDER makes to return NULL since linux 1.x. then
alloc_pages(MAX_ORDER) is wrong usage generally,
but we hope to allow following usage:

    page =3D alloc_pages(__GFP_nowarn, big-order)
    if (!page)
        page =3D alloc_pages(small-order)

It is the reason of __GFP_NOWARN check.
I guess ACPI don't need large `contenious' memory.


>
>> [ =A0 =A01.630028] Hardware name: System Product Name
>> [ =A0 =A01.630029] Modules linked in:
>> [ =A0 =A01.630032] Pid: 1, comm: swapper Not tainted 2.6.33-rc2 #4
>> [ =A0 =A01.630034] Call Trace:
>> [ =A0 =A01.630038] =A0[<ffffffff810532a8>] warn_slowpath_common+0x78=
/0xb0
>> [ =A0 =A01.630041] =A0[<ffffffff810532ef>] warn_slowpath_null+0xf/0x=
20
>> [ =A0 =A01.630044] =A0[<ffffffff810e65a7>] __alloc_pages_nodemask+0x=
617/0x730
>> [ =A0 =A01.630048] =A0[<ffffffff81114d14>] alloc_page_interleave+0x3=
4/0x90
>> [ =A0 =A01.630050] =A0[<ffffffff81115444>] alloc_pages_current+0xc4/=
0xd0
>> [ =A0 =A01.630053] =A0[<ffffffff810e5549>] __get_free_pages+0x9/0x50
>> [ =A0 =A01.630055] =A0[<ffffffff8111ef3b>] __kmalloc+0x1bb/0x1f0
>> [ =A0 =A01.630059] =A0[<ffffffff81089bdd>] ? trace_hardirqs_on+0xd/0=
x10
>> [ =A0 =A01.630064] =A0[<ffffffff812cae3e>] acpi_os_allocate+0x25/0x2=
7
>> [ =A0 =A01.630067] =A0[<ffffffff812cafab>] acpi_ex_load_op+0xd8/0x26=
0
>> [ =A0 =A01.630070] =A0[<ffffffff812cd89e>] acpi_ex_opcode_1A_1T_0R+0=
x25/0x4b
>> [ =A0 =A01.630073] =A0[<ffffffff812c5008>] acpi_ds_exec_end_op+0xea/=
0x3d6
>> [ =A0 =A01.630076] =A0[<ffffffff812d7532>] acpi_ps_parse_loop+0x7d9/=
0x95f
>> [ =A0 =A01.630079] =A0[<ffffffff812c58cf>] ? acpi_ds_call_control_me=
thod+0x166/0x1d7
>> [ =A0 =A01.630082] =A0[<ffffffff812d6641>] acpi_ps_parse_aml+0x9a/0x=
2b9
>> [ =A0 =A01.630085] =A0[<ffffffff812d7d3a>] acpi_ps_execute_method+0x=
1c8/0x29a
>> [ =A0 =A01.630088] =A0[<ffffffff812d2f4d>] acpi_ns_evaluate+0xe1/0x1=
a8
>> [ =A0 =A01.630090] =A0[<ffffffff812d29a1>] acpi_evaluate_object+0xf9=
/0x1f2
>> [ =A0 =A01.630094] =A0[<ffffffff812bda07>] acpi_processor_set_pdc+0x=
1be/0x1e8
>> [ =A0 =A01.630097] =A0[<ffffffff812bda3a>] early_init_pdc+0x9/0xf
>> [ =A0 =A01.630100] =A0[<ffffffff812d4a96>] acpi_ns_walk_namespace+0x=
b9/0x187
>> [ =A0 =A01.630102] =A0[<ffffffff812bda31>] ? early_init_pdc+0x0/0xf
>> [ =A0 =A01.630105] =A0[<ffffffff812bda31>] ? early_init_pdc+0x0/0xf
>> [ =A0 =A01.630108] =A0[<ffffffff812d27e0>] acpi_walk_namespace+0x85/=
0xbf
>> [ =A0 =A01.630111] =A0[<ffffffff81cc7da9>] ? acpi_init+0x0/0x12f
>> [ =A0 =A01.630113] =A0[<ffffffff81cc7da9>] ? acpi_init+0x0/0x12f
>> [ =A0 =A01.630116] =A0[<ffffffff812bd7c6>] acpi_early_processor_set_=
pdc+0x3a/0x3c
>> [ =A0 =A01.630119] =A0[<ffffffff81cc7c80>] acpi_bus_init+0xb5/0x1de
>> [ =A0 =A01.630123] =A0[<ffffffff8128239e>] ? kobject_create_and_add+=
0x3e/0x80
>> [ =A0 =A01.630126] =A0[<ffffffff81cc2f0c>] ? genhd_device_init+0x0/0=
x7b
>> [ =A0 =A01.630128] =A0[<ffffffff81cc7da9>] ? acpi_init+0x0/0x12f
>> [ =A0 =A01.630131] =A0[<ffffffff81cc7e1a>] acpi_init+0x71/0x12f
>> [ =A0 =A01.630134] =A0[<ffffffff81002047>] do_one_initcall+0x37/0x1a=
0
>> [ =A0 =A01.630137] =A0[<ffffffff81ca1731>] kernel_init+0x166/0x1bc
>> [ =A0 =A01.630140] =A0[<ffffffff8100a3e4>] kernel_thread_helper+0x4/=
0x10
>> [ =A0 =A01.630144] =A0[<ffffffff814f95d0>] ? restore_args+0x0/0x30
>> [ =A0 =A01.630147] =A0[<ffffffff81ca15cb>] ? kernel_init+0x0/0x1bc
>> [ =A0 =A01.630149] =A0[<ffffffff8100a3e0>] ? kernel_thread_helper+0x=
0/0x10
>> [ =A0 =A01.630156] ---[ end trace f17e946d22a56015 ]---
>> [ =A0 =A01.630159] ACPI Error (psparse-0537): Method parse/execution=
 failed [\_PR_.P009._OSC] (Node ffff8801b9069c20), AE_NO_MEMORY
>> [ =A0 =A01.630196] ACPI Error (psparse-0537): Method parse/execution=
 failed [\_PR_.P009._PDC] (Node ffff8801b9069c00), AE_NO_MEMORY
>
> We've changed both the _OSC and _PDC code in this release.
> In particular, _PDC is being evaluated earler than last release
> in an attempt to be more Windows compatible...
>
> Stephen,
> Please attach the output from acpidump to a new bugzilla entry
> and point this thread to it.
>
> thanks,
> Len Brown, Intel Open Source Technology Center
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
