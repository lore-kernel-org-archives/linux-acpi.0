From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Mon, 19 Nov 2018 09:53:18 -0700
Message-ID: <20181119165318.GB26595@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <baicar.tyler@gmail.com>
Cc: okaya@kernel.org, mr.nuke.me@gmail.com, helgaas@google.com, austin_bolen@dell.com, alex_gagniuc@dellteam.com, Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 19, 2018 at 11:53:05AM -0500, Tyler Baicar wrote:
> On Thu, Nov 15, 2018 at 8:49 PM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
> > > I've asked around a few people at Dell and they unanimously agree that
> > > _OSC is the correct way to determine ownership of AER. In linux, we
> > > use the result of _OSC to enable AER services, but we use HEST to
> > > determine AER ownership. That's inconsistent. This series drops the
> > > use of HEST in favor of _OSC.
> > >
> > > [1]https://lkml.org/lkml/2018/11/15/62
> >
> > This change breaks the existing systems that rely on the HEST table
> > telling the operating system about firmware first presence.
> >
> > Besides, HEST table has much more granularity about which PCI component
> > needs firmware such as global/device/switch.
> >
> > You should probably circulate these ideas for wider consumption in UEFI
> > forum as UEFI owns the HEST table definition.
> 
> I agree with Sinan, this will break existing systems, and the granularity of the
> HEST definition is more useful than the single bit in _OSC.

But we're not using HEST as a fine grain control. We disable native AER
handling if *any* device has FF set in HEST, and that just forces people
to use pcie_ports=native to get around that.
