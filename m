From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 13:11:59 -0600
Message-ID: <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>
Cc: Tyler Baicar <baicar.tyler@gmail.com>, austin_bolen@dell.com, alex_gagniuc@dellteam.com, Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/19/2018 12:24 PM, Sinan Kaya wrote:
> On 11/19/2018 1:10 PM, Keith Busch wrote:
>>> We can't really turn off firmware first in the kernel without asking 
>>> help
>>> from the firmware.
>> The _OSC method this patch utilizes is the ACPI spec defined way for
>> the kernel to wrest control from firmware. BIOS specific menu settings
>> shouldn't be our only recourse when we have a spec authority defining
>> generic OS interfaces to accomplish the same thing.
>>
>> Unless there is a disagreement on the _OSC interpreation, we'd have to
>> accept that platforms breaking from this patch are non-compliant.
>>
> 
> It depends on which spec you look :)
> 
> UEFI HEST table specification also claims that it should be the ultimate
> table for when PCI firmware-first should be disabled/enabled.

IIRC, EFI absorbed ACPI before FFS was a thing. Could you point me to 
the UEFI chapter that says HEST is authoritative?
(not being a smartie, just that my free software PDF readers can't 
search within a file that large)


> I think somebody needs to fix these. I saw an email from Harb Abdulhamid
> sent to aswg this morning.
> 
> That's why I suggested circulating this idea in UEFI forums first.
> Let's see what everybody thinks. We can go from there.

However you look at it, we have a glaring inconsistency in how we handle 
AER control in linux. I'm surprised we didn't see huge issues because of 
mixing HEST/_OSC.

What systems rely on the HEST definition as opposed to _OSC? It doesn't 
make sense to me that you could have a system with mixed FFS and native 
AER on the same root port. The granularity of HEST shouldn't matter here 
because of how AER works.

I'd like see how exactly we break one of those elusive systems with 
_OSC. I suspect _OSC and HEST end up having the same information, and 
that's why we didn't see any real-life issue with mixing the approaches.

Alex


P.S.
(SARCASM ALERT) Isn't UEFI is a pile of stuff that didn't stick to the wall?

P.P.S
I remember someone asking why we don't disable FFS in the BIOS. I think 
it would be next to impossible to get certain platform vendors to 
relinquish FFS control, unless the specs required things to be that way 
-- and had a "standard" way to do so.

Then getting the specs to change in that direction is also a battle.
