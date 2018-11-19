From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 11:10:51 -0700
Message-ID: <20181119181051.GA26707@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Tyler Baicar <baicar.tyler@gmail.com>, mr.nuke.me@gmail.com, austin_bolen@dell.com, alex_gagniuc@dellteam.com, Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 19, 2018 at 12:56:56PM -0500, Sinan Kaya wrote:
> On 11/19/2018 12:41 PM, Keith Busch wrote:
> > > Still, breaking existing systems that rely on HEST table is not cool.
> > > I'd rather have users specify "pcie_ports=native" to skip FF rather than
> > > having broken systems by default to be honest.
> > The pcie_ports=native work-around ignores FF to potentially unknown
> > results, though.
> > 
> 
> How about being able to enable/disable FF in BIOS?
>
> We can't really turn off firmware first in the kernel without asking help
> from the firmware.

The _OSC method this patch utilizes is the ACPI spec defined way for
the kernel to wrest control from firmware. BIOS specific menu settings
shouldn't be our only recourse when we have a spec authority defining
generic OS interfaces to accomplish the same thing.

Unless there is a disagreement on the _OSC interpreation, we'd have to
accept that platforms breaking from this patch are non-compliant.

> Like you said, it causes unpredictable results.
>
> There will be two competing software trying to touch the same registers.
