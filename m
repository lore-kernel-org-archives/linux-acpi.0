From: <Alex_Gagniuc@Dellteam.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 20:16:59 +0000
Message-ID: <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org, mr.nuke.me@gmail.com, keith.busch@intel.com
Cc: baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/19/2018 01:32 PM, Sinan Kaya wrote:=0A=
> ACPI 6.2:=0A=
> =0A=
> 18.3.2.4 PCI Express Root Port AER Structure=0A=
> =0A=
> Flags:=0A=
> =0A=
> Bit [0] - FIRMWARE_FIRST: If set, this bit indicates to the OSPM that sys=
tem=0A=
> firmware will handle errors from this source first.=0A=
> Bit [1] - GLOBAL: If set, indicates that the settings contained in this=
=0A=
> structure apply globally to all PCI Express Devices.=0A=
> All other bits must be set to zero.=0A=
> =0A=
> It doesn't say shall, may or might. It says will.=0A=
=0A=
It says "system firmware will handle errors". It does not say "system =0A=
firmware owns AER registers". In absence on any descriptor text on the =0A=
meaning of these tables, this really looks to me like it should be =0A=
interpreted as a descriptor of APEI error sources, not a mutex on who =0A=
writes to certain bits-- AER in this case.=0A=
=0A=
I don't think that is contradictory or inconsistent.=0A=
I also wasn't able to find any reference to HEST in UEFI 2.7, only in =0A=
ACPI spec.=0A=
=0A=
> I think It depends on your PCI topology.=0A=
> =0A=
> For other topologies with multiple PCI root complexes, I can see this bei=
ng=0A=
> used per root complex flag to indicate which root complex needs firmware =
first=0A=
> and which one doesn't.=0A=
=0A=
_OSC is per root bus, so it's already granular enough, right? Why would =0A=
it depend on PCI topology?=0A=
=0A=
=0A=
>> I'd like see how exactly we break one of those elusive systems with _OSC=
. I=0A=
>> suspect _OSC and HEST end up having the same information, and that's why=
 we=0A=
>> didn't see any real-life issue with mixing the approaches.=0A=
> =0A=
> I'm already aware of two systems that rely on HEST table to pass informat=
ion to=0A=
> the OS that firmware first is enabled. Both of the systems do not change =
their=0A=
> _OSC bits during this assuming HEST table has priority over _OSC for firm=
ware=0A=
> first.=0A=
=0A=
Are those hax86 systems?=0A=
It seems like the systems have broken firmware. I see several ways to =0A=
handle broken systems like those:=0A=
  - Parse both HEST and _OSC, and decide AER ownership with root bridge =0A=
granularity. i.e. host_bridge->native_aer is authoritative, but is =0A=
derived from both HEST and _OSC=0A=
  - Add quirks for the broken systems=0A=
  - Keep doing what we're doing until current code breaks a new system=0A=
=0A=
> If we add this patch, OS will try to claim the AER address space while fi=
rmware=0A=
> wants exclusive access.=0A=
=0A=
Yay! FFS wants exclusive access, but does not claim it. Oh, FFS!=0A=
=0A=
=0A=
> As I said in my previous email, the right place to talk about this is UEF=
I=0A=
> forum.=0A=
=0A=
The way I would present the problem to he spec writers is that, although =
=0A=
the spec appears to be consistent, we've seen firmware vendors that made =
=0A=
the wrong assumptions about HEST/_OSC. Instead of describing AER =0A=
ownership with _OSC, they attempted to do it with HEST. So we should add =
=0A=
an implementation note, or clarification about this.=0A=
=0A=
Alex=0A=
