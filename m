From: <Alex_Gagniuc@Dellteam.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Tue, 20 Nov 2018 21:46:13 +0000
Message-ID: <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
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
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org, mr.nuke.me@gmail.com, keith.busch@intel.com
Cc: baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/20/2018 03:02 PM, Sinan Kaya wrote:=0A=
> On 11/20/2018 3:44 PM, Alex_Gagniuc@Dellteam.com wrote:=0A=
>> I'd prefer "sure" instead of "think". "I think it breaks some system I'm=
=0A=
>> not telling you about" doesn't help much in figuring out how not to=0A=
>> break said system(s).:)=0A=
> =0A=
> Sorry, I thought I mentioned why it would break but let me repeat.=0A=
=0A=
Why, yes, but bets are still being placed on the systems allegedly =0A=
suffering from this.=0A=
=0A=
=0A=
> The systems I have seen rely on the HEST table presence as an indicator=
=0A=
> to the OS that firmware first is enabled. If you go look at the _OSC bits=
=0A=
> on such systems, it still says OS owns the AER service.=0A=
> =0A=
> The assumption here is that HEST table has precedence over the _OSC bits.=
=0A=
> That's what needs to be clarified in the UEFI forum.=0A=
> =0A=
> If this code is to go in and ignore the HEST table presence, then firmwar=
e=0A=
> will think that it owns AER service and OS will think that it owns AER=0A=
> service too.=0A=
=0A=
So this seems like exactly the scenario we were hypothesizing.=0A=
=0A=
  * System boots up with FFS enabled. Everything is fine so far.=0A=
  * OSPM requests control of AER (set bit 3 in _OSC)=0A=
  * FW grants OS control of AER (set bit 3 in _OSC reply)=0A=
=0A=
That's how things are designed to work.=0A=
=0A=
=0A=
Now, let's assume, for the sake of argument, that the firmware on those =0A=
system's is broken, and it didn't intend to give the OS control of AER. =0A=
OSPM checking HEST instead of _OSC is still wrong, according to the =0A=
spec. Two wrongs don't make a right, they just don't crash.=0A=
=0A=
I think the correct way is to identify those broken systems, and add =0A=
quirks for them. Continuing to have inconsistent and over-complicated =0A=
logic that is not spec compliant is not any better.=0A=
=0A=
Alex=0A=
