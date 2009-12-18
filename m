From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 3/3] ipmi/acpi: Install the IPMI space handler to
	enable ACPI to access the BMC controller
Date: Fri, 18 Dec 2009 09:38:10 +0800
Message-ID: <1261100290.3732.141.camel@localhost.localdomain>
References: <1260974431-4330-1-git-send-email-yakui.zhao@intel.com>
	 <200912160940.16740.bjorn.helgaas@hp.com>
	 <1261014720.3732.52.camel@localhost.localdomain>
	 <200912171500.29512.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21610 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755929AbZLRBjq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Dec 2009 20:39:46 -0500
In-Reply-To: <200912171500.29512.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>, "openipmi-developer@lists.sourceforege.net" <openipmi-developer@lists.sourceforge.net>

On Fri, 2009-12-18 at 06:00 +0800, Bjorn Helgaas wrote:
> On Wednesday 16 December 2009 06:52:00 pm ykzhao wrote:
> > On Thu, 2009-12-17 at 00:40 +0800, Bjorn Helgaas wrote:
> 
> > > > +     struct acpi_ipmi_device *ipmi_device =
> > > > +                     (struct acpi_ipmi_device *) handler_context;
> > > 
> > > I don't think you need this cast.
> > 
> > Without the initialization or cast type, it still can work. But it is
> > not wrong.
> > Right? Of course I can remove it.
> 
> The initialization and cast aren't *wrong*,  they're just unnecessary.
> In this case, it also makes it look different from other Linux code,
> which makes it harder to read.
> 
> > > > +static int acpi_ipmi_opregion_init(void)
> > > > +{
> > > > +     int result = 0;
> > > > +
> > > > +     if (acpi_disabled)
> > > > +             return result;
> > > 
> > > I don't think you need this check.
> > 
> > It is also ok to delete this check. 
> > But in fact it is unnecessary to register the smi_watcher again when
> > ACPI is disabled.  Otherwise after we register it, it will call the
> > corresponding callback defined in smi_watcher when one IPMI system
> > interface is registered/unregistered. 
> > 
> > So IMO we can register the smi_watcher only when ACPI is enabled.
> 
> This is connected with my opinion that you should call
> acpi_ipmi_opregion_init() from ipmi_pnp_probe(), not from the
> driver init function.
> 
> We only need the watcher when we have an IPI0001 device, so I
> don't see the point of registering it before we find one.  And if
> we find one, we know ACPI is enabled, so we don't need to check
> acpi_disabled.
> 
> > > > @@ -2096,17 +2576,33 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
> > > >       info->dev = &acpi_dev->dev;
> > > >       pnp_set_drvdata(dev, info);
> > > >
> > > > -     return try_smi_init(info);
> > > > +     acpi_dev->driver_data = p_ipmi;
> > > 
> > > I don't think we should use both the pnp_dev driver_data
> > > and the acpi_dev driver_data.  There's only one underlying
> > > physical device, and the fact that we have two ways to get
> > > at it is a Linux design problem.  It would be better to add
> > > the p_ipmi pointer to the smi_info structure, and use only
> > > pnp_set_drvdata().
> > 
> > Understand what you said.
> > 
> > It is not a good idea to add a new pointer in smi_info structure. In
> > fact the smi_info is the abstract layer of IPMI system interface. To add
> > a definition in smi_info seems a bit confusing.
> 
> If you can figure out another place to put it, that's OK with me.
> I just don't want to use acpi_dev->driver_data because someday I
> want to get rid of the acpi_dev for PNP devices.  We shouldn't have
> both a pnp_dev and and acpi_dev for the same device.
> 
> > > > @@ -3207,6 +3703,7 @@ static __devinit int init_ipmi_si(void)
> > > >
> > > >  #ifdef CONFIG_ACPI
> > > >       spmi_find_bmc();
> > > > +     acpi_ipmi_opregion_init();
> > > 
> > > I don't think this belongs in the IPMI driver init.  It should be done
> > > in ipmi_pnp_probe() when we actually discover an IPI0001 device.
> > 
> > This function is mainly to register the smi_watcher. When one IPMI
> > system interface(smi_info) is registered/unregistered, it will call the
> > corresponding callback function to create/destroy the corresponding IPMI
> > user interface between the user and IPMI system interface.(In our code
> > the user is the ACPI IPMI device defined in ACPI namespace). 
> > That means that it can create the corresponding user interface for more
> > than one ACPI IPMI devices. 
> > So IMO this had better not be added in the ipmi_pnp_probe/remove
> > function.
> 
> We don't need the watcher unless we find an IPI0001 device, so I think
> it makes sense to put it in ipmi_pnp_probe().  You might have to have
> some static state so you only call acpi_ipmi_opregion_init() on the
> *first* probe and do the cleanup on the *last* call to ipmi_pnp_remove().

If no IPI0001 device is not found, it is unnecessary to register the
smi_watcher. When the IPI0001 device is found, we should register the
smi_watcher. I think that your suggestion is also OK. 

But if we put it outside of ipmi_pnp_probe/ipmp_pnp_remove, then we
don't care when and how to register/unregister it. In such case if a new
IPMI smi_info is registered, it will call this smi_watcher.

In fact when we call the function of ipmi_smi_watcher_register to
register the smi_watcher, it will do two things. One is to enumerate the
current smi_info list to call the callback function. The second is to
add this smi_watcher and when one IPMI smi_info is registered, it can be
called.

Of course I can remove the unmeaningful check of acpi_disabled.


> 
> Thanks for being so patient with all this.  I know I'm being picky,
> but it's much easier to fix up as much as we can before it goes into
> the tree.
> 
> Bjorn

