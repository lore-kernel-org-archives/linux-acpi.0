From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 13:24:11 -0500
Message-ID: <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119181051.GA26707@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Tyler Baicar <baicar.tyler@gmail.com>, mr.nuke.me@gmail.com, austin_bolen@dell.com, alex_gagniuc@dellteam.com, Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/19/2018 1:10 PM, Keith Busch wrote:
>> We can't really turn off firmware first in the kernel without asking help
>> from the firmware.
> The _OSC method this patch utilizes is the ACPI spec defined way for
> the kernel to wrest control from firmware. BIOS specific menu settings
> shouldn't be our only recourse when we have a spec authority defining
> generic OS interfaces to accomplish the same thing.
> 
> Unless there is a disagreement on the _OSC interpreation, we'd have to
> accept that platforms breaking from this patch are non-compliant.
> 

It depends on which spec you look :)

UEFI HEST table specification also claims that it should be the ultimate
table for when PCI firmware-first should be disabled/enabled.

I think somebody needs to fix these. I saw an email from Harb Abdulhamid
sent to aswg this morning.

That's why I suggested circulating this idea in UEFI forums first.
Let's see what everybody thinks. We can go from there.
