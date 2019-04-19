From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 2/3] PCI / ACPI: Remove the need for 'struct
 hotplug_params'
Date: Fri, 19 Apr 2019 17:02:20 -0500
Message-ID: <20190419220220.GI173520@google.com>
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
 <20190208162414.3996-3-mr.nuke.me@gmail.com>
 <20190419200745.GH173520@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419200745.GH173520@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 19, 2019 at 03:07:45PM -0500, Bjorn Helgaas wrote:
> On Fri, Feb 08, 2019 at 10:24:12AM -0600, Alexandru Gagniuc wrote:
> > We used to first parse all the _HPP and _HPX tables before using the
> > information to program registers of PCIe devices. Up until HPX type 2,
> > there was only one structure of each type, so we could cheat and store
> > it on the stack.
> > 
> > With HPX type 3 we get an arbitrary number of entries, so the above
> > model doesn't scale that well. Instead of parsing all tables at once,
> > parse and program each entry separately. For _HPP and _HPX 0 thru 2,
> > this is functionally equivalent. The change enables the upcoming _HPX3
> > to integrate more easily.
> 
> I think this is tremendous!  It's going to simplify this code
> dramatically.  Two comments below.

> >  static void pci_configure_device(struct pci_dev *dev)
> >  {
> > -	struct hotplug_params hpp;
> > -	int ret;
> > +	static const struct hotplug_program_ops hp_ops = {
> > +		.program_type0 = program_hpp_type0,
> > +		.program_type1 = program_hpp_type1,
> > +		.program_type2 = program_hpp_type2,
> > +	};
> 
> What if we just moved program_hpp_type0(), etc from probe.c to
> pci-acpi.c?  The only reason I see to have it in probe.c is for
> pci_default_type0, and I think that is a pretty obtuse way of doing
> default configuration.  I would have no problem at all just hardcoding
> those defaults in probe.c and then potentially having them overwritten
> by _HPP/_HPX.

Actually, never mind about this.  This would be a perfect project for
mentoring a Linux newbie.

I'll merge this series as-is and any restructuring/cleanup can happen
later, since it's not related to this series anyway.

Bjorn
