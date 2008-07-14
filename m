From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI Error under 2.6.26-rc*
Date: Mon, 14 Jul 2008 17:11:41 +0800
Message-ID: <1216026701.1617.82.camel@rzhang-dt>
References: <20080709083829.GA5748@linux.int.dgn.ag>
	 <200807102255.23090.rjw@sisk.pl> <1215739210.1617.28.camel@rzhang-dt>
	 <1215739682.1617.32.camel@rzhang-dt>
	 <20080714080914.GA4965@linux.int.dgn.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25172 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826AbYGNJMn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 05:12:43 -0400
In-Reply-To: <20080714080914.GA4965@linux.int.dgn.ag>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andre Prendel <andre_prendel@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kernel-testers@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, 2008-07-14 at 16:09 +0800, Andre Prendel wrote:
> On Fri, Jul 11, 2008 at 09:28:02AM +0800, Zhang Rui wrote:
> > On Fri, 2008-07-11 at 09:20 +0800, Zhang Rui wrote:
> > > On Fri, 2008-07-11 at 04:55 +0800, Rafael J. Wysocki wrote:
> > > > [Adding CCs.]
> > > >
> > > > On Wednesday, 9 of July 2008, Andre Prendel wrote:
> > > > > Hi,
> > > > >
> > > > > I have had some ACPI Problems working under the 2.6.26-rc's i=
n
> the
> > > > last weeks.
> > > > > Power off does not work well. "System halted" is the last
> output,
> > > > but power is
> > > > > not switch off. The lastest stable kernel (2.6.25.10) works
> fine for
> > > > me. After
> > > > > that I tried 2.6.26-rc1 and the error occurs. AFAIR I had
> these
> > > > problems with
> > > > > all 2.6.26-rc's until 2.6.26-rc8-git4. I did not tested newer
> ones.
> > > > >
> > > > > Dmesg output is attached.
> > > > >
> > > > > Andre
> > > > >
> > > > > ----------------------------------
> > > > > [    0.000000] Linux version 2.6.26-rc1 (andre@ubuntu) (gcc
> version
> > > > 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #8 SMP Tu=
e
> Jul 8
> > > > 22:28:14 CEST 2008
> > > > > [    0.000000] BIOS-provided physical RAM map:
> > > > > [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc0=
0
> > > > (usable)
> > > > > [    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a000=
0
> > > > (reserved)
> > > > > [    0.000000]  BIOS-e820: 00000000000f0000 - 000000000010000=
0
> > > > (reserved)
> > > > > [    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff000=
0
> > > > (usable)
> > > > > [    0.000000]  BIOS-e820: 0000000021ff0000 - 0000000021ff800=
0
> (ACPI
> > > > data)
> > > > > [    0.000000]  BIOS-e820: 0000000021ff8000 - 000000002200000=
0
> (ACPI
> > > > NVS)
> > > > > [    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec0100=
0
> > > > (reserved)
> > > > > [    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee0100=
0
> > > > (reserved)
> > > > > [    0.000000]  BIOS-e820: 00000000ffee0000 - 00000000fff0000=
0
> > > > (reserved)
> > > > > [    0.000000]  BIOS-e820: 00000000fffc0000 - 000000010000000=
0
> > > > (reserved)
> > > > > [    0.000000] x86: PAT support disabled.
> > > > > [    0.000000] 511MB LOWMEM available.
> > > > > [    0.000000] Entering add_active_range(0, 0, 131056) 0
> entries of
> > > > 256 used
> > > > > [    0.000000] Zone PFN ranges:
> > > > > [    0.000000]   DMA             0 ->     4096
> > > > > [    0.000000]   Normal       4096 ->   131056
> > > > > [    0.000000] Movable zone start PFN for each node
> > > > > [    0.000000] early_node_map[1] active PFN ranges
> > > > > [    0.000000]     0:        0 ->   131056
> > > > > [    0.000000] On node 0 totalpages: 131056
> > > > > [    0.000000]   DMA zone: 32 pages used for memmap
> > > > > [    0.000000]   DMA zone: 0 pages reserved
> > > > > [    0.000000]   DMA zone: 4064 pages, LIFO batch:0
> > > > > [    0.000000]   Normal zone: 991 pages used for memmap
> > > > > [    0.000000]   Normal zone: 125969 pages, LIFO batch:31
> > > > > [    0.000000]   Movable zone: 0 pages used for memmap
> > > > > [    0.000000] DMI 2.3 present.
> > > > > [    0.000000] ACPI: RSDP 000FA340, 0014 (r0 AMI   )
> > > > > [    0.000000] ACPI:      21FF0000, 0000 (r0
> > > > 0             0)
> > > > > [    0.000000] ACPI Error (tbutils-0472): Invalid length 0x0
> in
> > > > RSDT/XSDT [20080321]
> > >
> > > Please attach the acpidump output using the latest pmtools at
> > > http://www.lesswatts.org/patches/linux_acpi/
> > >
> > Please also attach the dmesg output of a working kernel.
>=20
> Hello Rui,
>=20
> that's quite strange. Booting the system to get an acpidump I have
> looked at the dmesg output and there is no ACPI Error like the one
> above. There is only an ACPI Exeption.
>=20
> [...]
> Jul 13 22:00:18 ubuntu kernel: [    0.104111] ACPI: Core revision
> 20080321
> Jul 13 22:00:18 ubuntu kernel: [    0.104259] ACPI Exception
> (tbxface-0629): AE_NO_ACPI_TABLES, While loading namespace from ACPI
> tables [20080321]
> [...]
>=20
> Booting again I found the error again
>=20
> [...]
> Jul 13 22:10:50 ubuntu kernel: [    0.000000] ACPI Error
> (tbutils-0472): Invalid length 0x0 in RSDT/XSDT [20080321]
> [...]
>=20
> and acpidump says:
> root@ubuntu:/home/andre/src/acpi/pmtools-20071116/acpidump#
> ./acpidumpACPI tables were not found. If you know location of RSD PTR
> table (from dmesg, etc), supply it with either --addr or -a option
>=20
> Linux 2.6.25.10 always works.

It seems that OS failed to get the correct RSDT address (0x1fff0000),
although the RSDP is found correctly. (=EF=BB=BFACPI: RSDP 000FA340, 00=
14)

please run "./acpidump --addr 0xFA340 --length 0x14 > rsdp_xxx",
and attach the rsdp for all of the three cases (good, ACPI Error, ACPI
Exception).

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
