From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 10:41:27 -0700
Message-ID: <20181119174127.GE26595@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Tyler Baicar <baicar.tyler@gmail.com>, mr.nuke.me@gmail.com, helgaas@google.com, austin_bolen@dell.com, alex_gagniuc@dellteam.com, Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 19, 2018 at 12:42:25PM -0500, Sinan Kaya wrote:
> On 11/19/2018 12:32 PM, Sinan Kaya wrote:
> > > 
> > > But we're not using HEST as a fine grain control. We disable native AER
> > > handling if *any* device has FF set in HEST, and that just forces people
> > > to use pcie_ports=native to get around that.
> > > 
> > 
> > I don't see *any* in the code.  aer_hest_parse() does the HEST table parsing.
> > It switches to firmware first mode if global flag in HEST is set. Otherwise
> > for each BDF in device, hest_match_pci() is used to do a cross-matching against
> > HEST table contents.
> > 
> > Am I missing something?
> 
> I see. I think you are talking about aer_firmware_first, right?
> 
> aer_set_firmware_first() and  pcie_aer_get_firmware_first() seem to do the right
> thing.

Right, but what difference does it make if device specific AER checks do
the right thing if pcie_aer_init() doesn't even register it's port driver?
 
> aer_firmware_first is probably getting set because events are all routed to a
> single root port and aer_acpi_firmware_first() is used to decide whether AER
> should be initialized or not.
> 
> I think I understand what is going on now.
> 
> Still, breaking existing systems that rely on HEST table is not cool.
> I'd rather have users specify "pcie_ports=native" to skip FF rather than
> having broken systems by default to be honest.

The pcie_ports=native work-around ignores FF to potentially unknown
results, though.
