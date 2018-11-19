From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 10:36:35 -0700
Message-ID: <20181119173635.GD26595@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Tyler Baicar <baicar.tyler@gmail.com>, mr.nuke.me@gmail.com, helgaas@google.com, austin_bolen@dell.com, alex_gagniuc@dellteam.com, Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 19, 2018 at 12:32:42PM -0500, Sinan Kaya wrote:
> On 11/19/2018 11:53 AM, Keith Busch wrote:
> > On Mon, Nov 19, 2018 at 11:53:05AM -0500, Tyler Baicar wrote:
> > > On Thu, Nov 15, 2018 at 8:49 PM Sinan Kaya <okaya@kernel.org> wrote:
> > > > 
> > > > On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
> > > > > I've asked around a few people at Dell and they unanimously agree that
> > > > > _OSC is the correct way to determine ownership of AER. In linux, we
> > > > > use the result of _OSC to enable AER services, but we use HEST to
> > > > > determine AER ownership. That's inconsistent. This series drops the
> > > > > use of HEST in favor of _OSC.
> > > > > 
> > > > > [1]https://lkml.org/lkml/2018/11/15/62
> > > > 
> > > > This change breaks the existing systems that rely on the HEST table
> > > > telling the operating system about firmware first presence.
> > > > 
> > > > Besides, HEST table has much more granularity about which PCI component
> > > > needs firmware such as global/device/switch.
> > > > 
> > > > You should probably circulate these ideas for wider consumption in UEFI
> > > > forum as UEFI owns the HEST table definition.
> > > 
> > > I agree with Sinan, this will break existing systems, and the granularity of the
> > > HEST definition is more useful than the single bit in _OSC.
> > 
> > But we're not using HEST as a fine grain control. We disable native AER
> > handling if *any* device has FF set in HEST, and that just forces people
> > to use pcie_ports=native to get around that.
> > 
> 
> I don't see *any* in the code.  aer_hest_parse() does the HEST table parsing.
> It switches to firmware first mode if global flag in HEST is set. Otherwise
> for each BDF in device, hest_match_pci() is used to do a cross-matching against
> HEST table contents.
> 
> Am I missing something?

You might be. :)

static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
{
<snip>
        /*
         * If no specific device is supplied, determine whether
         * FIRMWARE_FIRST is set for *any* PCIe device.
         */
        if (!info->pci_dev) {
                info->firmware_first |= ff;
                return 0;
        }
