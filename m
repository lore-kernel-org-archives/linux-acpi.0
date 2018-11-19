From: <Alex_Gagniuc@Dellteam.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 23:49:32 +0000
Message-ID: <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
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
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org, mr.nuke.me@gmail.com, keith.busch@intel.com
Cc: baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/19/2018 02:33 PM, Sinan Kaya wrote:=0A=
> True. I was trying to get it out in a rush. I omitted words.=0A=
=0A=
Sounds like you'd make an top notch spec writer! :p=0A=
=0A=
> However; table assumes governance about for which entities firmware first=
=0A=
> should be enabled. There is no cross reference to _OSC or permission=0A=
> negotiation like _OST.=0A=
=0A=
Well, from an OSPM perspective, is FFS something that can be enabled or =0A=
disabled? FFS seems to be static to OSPM, which would change the sort of =
=0A=
assumptions we can reasonably make here.=0A=
=0A=
=0A=
>>> As I said in my previous email, the right place to talk about this is U=
EFI=0A=
>>> forum.=0A=
>>=0A=
>> The way I would present the problem to he spec writers is that, although=
=0A=
>> the spec appears to be consistent, we've seen firmware vendors that made=
=0A=
>> the wrong assumptions about HEST/_OSC. Instead of describing AER=0A=
>> ownership with _OSC, they attempted to do it with HEST. So we should add=
=0A=
>> an implementation note, or clarification about this.=0A=
> =0A=
> I agree.=0A=
=0A=
Cool. While the UEFI Secret Society debates, can we figure out if/how =0A=
[patch 1/2] breaks those systems, or is it only [patch 2/2] of this =0A=
series that we suspect?=0A=
=0A=
Alex=0A=
