From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 20:54:21 -0500
Message-ID: <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com, keith.busch@intel.com
Cc: baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/19/2018 6:49 PM, Alex_Gagniuc@Dellteam.com wrote:
> On 11/19/2018 02:33 PM, Sinan Kaya wrote:
>> However; table assumes governance about for which entities firmware first
>> should be enabled. There is no cross reference to _OSC or permission
>> negotiation like _OST.
> 
> Well, from an OSPM perspective, is FFS something that can be enabled or
> disabled? FFS seems to be static to OSPM, which would change the sort of
> assumptions we can reasonably make here.

IMO, it can be enabled/disabled in BIOS. I have seen this implementation before.
If the trigger is the presence of a statically compiled ACPI HEST table (as the
current code does); presence of FFS would be static from OSPM perspective.
BIOS could patch this table or hide it during boot.

If FFS were to be negotiated via _OSC as indirectly implied in this series, then
same BIOS could patch the ACPI table to return different values for the _OSC
return.

> 
> 
>>>> As I said in my previous email, the right place to talk about this is UEFI
>>>> forum.
>>>
>>> The way I would present the problem to he spec writers is that, although
>>> the spec appears to be consistent, we've seen firmware vendors that made
>>> the wrong assumptions about HEST/_OSC. Instead of describing AER
>>> ownership with _OSC, they attempted to do it with HEST. So we should add
>>> an implementation note, or clarification about this.
>>
>> I agree.
> 
> Cool. While the UEFI Secret Society debates, can we figure out if/how
> [patch 1/2] breaks those systems, or is it only [patch 2/2] of this
> series that we suspect?

I went back and looked at both patches. Both of them are removing references to
HEST table. I think both patches are impacted by this discussion.

> 
> Alex
> 
