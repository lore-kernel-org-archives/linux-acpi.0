From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 15:33:52 -0500
Message-ID: <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com, keith.busch@intel.com
Cc: baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/19/2018 3:16 PM, Alex_Gagniuc@Dellteam.com wrote:
> On 11/19/2018 01:32 PM, Sinan Kaya wrote:
>> ACPI 6.2:
>>
>> 18.3.2.4 PCI Express Root Port AER Structure
>>
>> Flags:
>>
>> Bit [0] - FIRMWARE_FIRST: If set, this bit indicates to the OSPM that system
>> firmware will handle errors from this source first.
>> Bit [1] - GLOBAL: If set, indicates that the settings contained in this
>> structure apply globally to all PCI Express Devices.
>> All other bits must be set to zero.
>>
>> It doesn't say shall, may or might. It says will.
> 
> It says "system firmware will handle errors". It does not say "system
> firmware owns AER registers". In absence on any descriptor text on the
> meaning of these tables, this really looks to me like it should be
> interpreted as a descriptor of APEI error sources, not a mutex on who
> writes to certain bits-- AER in this case.

True. I was trying to get it out in a rush. I omitted words.

However; table assumes governance about for which entities firmware first
should be enabled. There is no cross reference to _OSC or permission
negotiation like _OST.

> 
> I don't think that is contradictory or inconsistent.
> I also wasn't able to find any reference to HEST in UEFI 2.7, only in
> ACPI spec.

You are right. It was a confusion on my side. The right place to look is
ACPI specification. I was involved in this a couple of years ago. Some pieces
were in UEFI spec. Other pieces were in ACPI. I guess they got unified
now.

> 
>> I think It depends on your PCI topology.
>>
>> For other topologies with multiple PCI root complexes, I can see this being
>> used per root complex flag to indicate which root complex needs firmware first
>> and which one doesn't.
> 
> _OSC is per root bus, so it's already granular enough, right? Why would
> it depend on PCI topology?
> 

I was speculating. I don't have the full background on this. Need to consult
the spec developers.

>> As I said in my previous email, the right place to talk about this is UEFI
>> forum.
> 
> The way I would present the problem to he spec writers is that, although
> the spec appears to be consistent, we've seen firmware vendors that made
> the wrong assumptions about HEST/_OSC. Instead of describing AER
> ownership with _OSC, they attempted to do it with HEST. So we should add
> an implementation note, or clarification about this.

I agree.

> 
> Alex
> 
