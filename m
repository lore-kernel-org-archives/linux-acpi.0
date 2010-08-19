From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: HPET+PAT causes "bad page state"
Date: Thu, 19 Aug 2010 11:50:48 +0200
Message-ID: <4C6CFE78.7030809@suse.cz>
References: <4C68FCBC.5020208@suse.cz> <4C691837.9060106@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47404 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0HSJux (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Aug 2010 05:50:53 -0400
Received: by bwz11 with SMTP id 11so1010201bwz.19
        for <linux-acpi@vger.kernel.org>; Thu, 19 Aug 2010 02:50:52 -0700 (PDT)
In-Reply-To: <4C691837.9060106@suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: "x86@kernel.org" <x86@kernel.org>, clemens@ladisch.de, venki@google.com, bob.picco@hp.com, Ingo Molnar <mingo@elte.hu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 08/16/2010 12:51 PM, Jiri Slaby wrote:
> On 08/16/2010 10:54 AM, Jiri Slaby wrote:
>> Hi,
>>
>> with 2.6.35.1, there is an opensuse user who gets the following BUG:
>> BUG: Bad page state in process md5sum  pfn:3ed00
>> page:ffffea0000dbd800 count:0 mapcount:0 mapping:(null) index:0x0
>> page flags: 0x20000000800000(uncached)
>> Pid: 2515, comm: md5sum Not tainted 2.6.35.1-1-vanilla #1
>>
>> I have also a backtrace (from older, non-vanilla kernel):
>> BUG: Bad page state in process md5sum  pfn:3ed00
>> page:ffffea0000dbd800 count:0 mapcount:0 mapping:(null) index:0x0
>> page flags: 0x20000001000000(uncached)
>> Pid: 7956, comm: md5sum Not tainted 2.6.34-12-desktop #1
>> Call Trace:
>>  [<ffffffff81005ca9>] dump_trace+0x79/0x340
>>  [<ffffffff8149e612>] dump_stack+0x69/0x6f
>>  [<ffffffff810df851>] bad_page+0xb1/0x100
>>  [<ffffffff810dfa45>] prep_new_page+0x1a5/0x1c0
>>  [<ffffffff810dfe01>] get_page_from_freelist+0x3a1/0x640
>>  [<ffffffff810e01af>] __alloc_pages_nodemask+0x10f/0x6b0
>>  [<ffffffff810e35a4>] __do_page_cache_readahead+0x114/0x290
>>  [<ffffffff810e389c>] ra_submit+0x1c/0x30
>>  [<ffffffff810e3c38>] page_cache_async_readahead+0x98/0xe0
>>  [<ffffffff810d95bb>] do_generic_file_read.clone.0+0x25b/0x440
>>  [<ffffffff810daf94>] generic_file_aio_read+0xb4/0x1c0
>>  [<ffffffff8112426f>] do_sync_read+0xbf/0x100
>>  [<ffffffff81124a53>] vfs_read+0xb3/0x190
>>  [<ffffffff81124b7e>] sys_read+0x4e/0x90
>>  [<ffffffff81002ffb>] system_call_fastpath+0x16/0x1b
>>  [<00007f51336f03e0>] 0x7f51336f03e0
>>
>>
>> Obviously if he disables PAT by nopat parameter, it goes away. The p=
age
>> is always the same (0x3ed00000). I asked for pat_memtype_list, so I'=
ll
>> attach that later.
>=20
> Here it is, as promised:
> uncached-minus @ 0xafdc4000-0xafdc5000
> uncached-minus @ 0xafe7e000-0xafe7f000
> uncached-minus @ 0xafe7f000-0xafe80000
> uncached-minus @ 0xafe81000-0xafe82000
> uncached-minus @ 0xafe83000-0xafe84000
> uncached-minus @ 0xafeda000-0xafedb000
> uncached-minus @ 0xafedb000-0xafedc000
> uncached-minus @ 0xafedc000-0xafedd000
> uncached-minus @ 0xafedd000-0xafede000
> uncached-minus @ 0xafede000-0xafefa000
> uncached-minus @ 0xafefa000-0xafefb000
> uncached-minus @ 0xafefb000-0xafefc000
> uncached-minus @ 0xafefc000-0xafefd000
> uncached-minus @ 0xafefd000-0xafefe000
> uncached-minus @ 0xc0040000-0xc0140000
> uncached-minus @ 0xc0141000-0xc06c0000
> uncached-minus @ 0xd4100000-0xd4101000
> uncached-minus @ 0xd4103000-0xd4104000
> uncached-minus @ 0xd5200000-0xd5204000
> uncached-minus @ 0xd6400000-0xd6410000
> uncached-minus @ 0xd6410000-0xd6414000
> uncached-minus @ 0xd6500000-0xd6504000
> uncached-minus @ 0xd6504000-0xd6505000
> uncached-minus @ 0xd6505000-0xd6506000
> uncached-minus @ 0xd6506000-0xd6507000
> uncached-minus @ 0xd6507000-0xd6508000
> uncached-minus @ 0xd6508000-0xd6509000
> uncached-minus @ 0xd6509000-0xd650a000
> uncached-minus @ 0xd650a000-0xd650b000
> uncached-minus @ 0xd650b000-0xd650c000
> uncached-minus @ 0xe0000000-0xf0000000
> uncached-minus @ 0xe0088000-0xe0089000
> uncached-minus @ 0xe00c3000-0xe00c4000
> uncached-minus @ 0xfed00000-0xfed01000
> uncached-minus @ 0xfed40000-0xfed45000
> uncached-minus @ 0xfed40000-0xfed41000
> uncached-minus @ 0xfed80000-0xfed81000
>=20
>> The original bugreport is at:
>> https://bugzilla.novell.com/show_bug.cgi?id=3D629908
>>
>> Any idea what's going on?

Nevermind, I found the root cause. It is caused by code in hpet.c. Ther=
e
is a HPET device in DSDT which body contains:

    Method (GHPA, 0, Serialized)
    {
        Store (0x00, Local0)
        If (\HPDE)
        {
            Multiply (\HPEA, 0x0100, Local0)
        }

        Return (Local0)
    }
=2E..
    Method (_CRS, 0, Serialized)
    {
        Name (CRES, ResourceTemplate ()
        {
            Memory32Fixed (ReadOnly,
                0xFED00000,         // Address Base
                0x00000400,         // Address Length
                _Y04)
        })
        Store (GHPA (), Local1)
        If (Local1)
        {
            CreateDWordField (CRES, \_SB.PCI0.LPCB.HPET._CRS._Y04._BAS,
HPEB)
            Store (Local1, HPEB)
        }

        Return (CRES)
    }

HPEA seems to be 3ed000. So the base of memory resource is set to
0x3ed00000. The problem is
1) it is not in reserved ranges reported by the BIOS (the modified
variant contains only the protection hole at 0-10000):
modified physical RAM map:
 modified: 0000000000000000 - 0000000000010000 (reserved)
 modified: 0000000000010000 - 000000000009fc00 (usable)
 modified: 000000000009fc00 - 00000000000a0000 (reserved)
 modified: 00000000000ef000 - 0000000000100000 (reserved)
 modified: 0000000000100000 - 00000000af6cf000 (usable)
 modified: 00000000af6cf000 - 00000000afdcf000 (reserved)
 modified: 00000000afdcf000 - 00000000afecf000 (ACPI NVS)
 modified: 00000000afecf000 - 00000000afeff000 (ACPI data)
 modified: 00000000afeff000 - 00000000aff00000 (usable)
 modified: 00000000e0000000 - 00000000f0000000 (reserved)
 modified: 00000000fec00000 - 00000000fec01000 (reserved)
 modified: 00000000fec10000 - 00000000fec11000 (reserved)
 modified: 00000000fee00000 - 00000000fee01000 (reserved)
 modified: 00000000ffe00000 - 0000000100000000 (reserved)
 modified: 0000000100000000 - 0000000240000000 (usable)

so allocator treats the page as normal ram page. Hence the warning in
the original report.

2) there is only memory resource without any IRQ resources in _CRS
method of HPET. Then we do not unmap space in hpet_acpi_add in 'if
(!data.hd_address || !data.hd_nirqs)' branch. Technically we cannot do
that, the intel HPET specs (1.0a) says (3.2.5.1):
_CRS (
  // Report 1K of memory consumed by this Timer Block
  memory range consumed
  // Optional: only used if BIOS allocates Interrupts [1]
  IRQs consumed
)

[1] For case where Timer Block is configured to consume IRQ0/IRQ8 AND
Legacy 8254/Legacy RTC hardware still exists, the device objects
associated with 8254 & RTC devices should not report IRQ0/IRQ8 as
=E2=80=9Cconsumed resources.=E2=80=9D



In this particular case, the address reported by the BIOS seems to be
bogus anyway, so non-presence of IRQ doesn't mean the "optional" part i=
n
point 2). So my question is whether the fix below [*] is enough or you
want me to implement the "optional" part and then add a DMI quirk for
this machine.

[*] It would probably be more safe to walk the resources again and unma=
p
appropriately depending on type. But as we now use only ioremap for bot=
h
2 memory resource types, it is not necessarily needed right now.

--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -1017,6 +1017,8 @@ static int hpet_acpi_add(struct acpi_device *devi=
ce)
                return -ENODEV;

        if (!data.hd_address || !data.hd_nirqs) {
+               if (data.hd_address)
+                       iounmap(data.hd_address);
                printk("%s: no address or irqs in _CRS\n", __func__);
                return -ENODEV;
        }




thanks,
--=20
js
suse labs
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
