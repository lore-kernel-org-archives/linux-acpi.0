From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH v4 1/2] IPMI/ACPI: use ACPI detection mechanism firstly
	to detect IPMI system interface
Date: Fri, 22 Jan 2010 09:15:00 +0800
Message-ID: <1264122900.2379.17.camel@localhost.localdomain>
References: <1262051060-23245-1-git-send-email-yakui.zhao@intel.com>
	 <201001200951.49462.bjorn.helgaas@hp.com>
	 <1264036825.15793.14.camel@localhost.localdomain>
	 <201001211054.04684.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48068 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498Ab0AVBQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jan 2010 20:16:08 -0500
In-Reply-To: <201001211054.04684.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>

On Thu, 2010-01-21 at 09:54 -0800, Bjorn Helgaas wrote:
> On Wednesday 20 January 2010 06:20:25 pm ykzhao wrote:
> > On Wed, 2010-01-20 at 09:51 -0700, Bjorn Helgaas wrote:
> > > On Monday 28 December 2009 06:44:19 pm yakui.zhao@intel.com wrote:
> > > > From: Zhao Yakui <yakui.zhao@intel.com>
> > > > 
> > > > Sometimes one IPMI system interface will be detected by several methods.
> > > > For example: ACPI mechanism, SPMI table, DMI or hardcode mechanism.
> > > > In such case when one IPMI system interface can be detected in two mechanism,
> > > > the second mechanism will fail in the detection and can't record which IPMI
> > > > system interface is detected by it.
> > > > 
> > > > Use the ACPI detection mechanism firstly to detect the IPMI system interface
> > > > so that we can know which IPMI system interface is detected in ACPI namespace.
> > > > 
> > > > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > > > ---
> > > >  drivers/char/ipmi/ipmi_si_intf.c |    8 +++++---
> > > >  1 files changed, 5 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > > > index 176f175..3f6ca11 100644
> > > > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > > > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > > > @@ -3195,6 +3195,10 @@ static __devinit int init_ipmi_si(void)
> > > >  
> > > >  	printk(KERN_INFO "IPMI System Interface driver.\n");
> > > >  
> > > > +#ifdef CONFIG_ACPI
> > > > +	pnp_register_driver(&ipmi_pnp_driver);
> > > > +#endif
> > > > +
> > > >  	hardcode_find_bmc();
> > > 
> > > The usual practice is to handle devices explicitly specified by
> > > module parameters first.  That way, the driver should work with
> > > no module parameters in most cases, but the user can specify the
> > > device location manually if necessary to work around a firmware
> > > bug.
> > 
> > The reason I change the order of detecting IPMI device is that maybe one
> > IPMI device can be registered by several different mechanisms. When we
> > register one IPMI device by using try_smi_init, it will firstly check
> > whether the IPMI device is already registered by comparing the address.
> > 
> > If the IPMI device is already registered by another mechanism,  we can't
> > enable ACPI to access the IPMI device as we can't create the user
> > interface between ACPI and IPMI device.
> > 
> > If we add the module option to use the hardcode mechanism,  maybe we
> > will fail in detecting IPMI device by using ACPI mechanism. 
> > 
> > > For that reason, I would use this order instead:
> > > 
> > > 	hardcode_find_bmc();
> > > 	pnp_register_driver();
> > > 	...
> 
> I agree that pnp_register_driver() should be before spmi_find_bmc().
> 
> I agree that if we find an IPMI device based on module parameters,
> we likely won't be able to set up the IPMI opregion.  We shouldn't
> be using module parameters in the first place.  If we *are* using
> the module parameters, it's because the firmware is buggy.  I think
> it's perfectly fine if buggy firmware can't use the IPMI opregion.
> 
> Is that your concern, or did I miss the meaning of your email?

What you said is right. The above is my concern. The purpose of changing
the detection order is to assure that the opregion can be set up
correctly if the IPMI device can be detected by using ACPI mechanism. 
 
Thanks.
   Yakui.
> 
> Bjorn
> 
> > > >  #ifdef CONFIG_DMI
> > > > @@ -3204,9 +3208,6 @@ static __devinit int init_ipmi_si(void)
> > > >  #ifdef CONFIG_ACPI
> > > >  	spmi_find_bmc();
> > > >  #endif
> > > > -#ifdef CONFIG_ACPI
> > > > -	pnp_register_driver(&ipmi_pnp_driver);
> > > > -#endif
> > > >  
> > > >  #ifdef CONFIG_PCI
> > > >  	rv = pci_register_driver(&ipmi_pci_driver);
> > > > @@ -3330,6 +3331,7 @@ static __exit void cleanup_ipmi_si(void)
> > > >  #ifdef CONFIG_PCI
> > > >  	pci_unregister_driver(&ipmi_pci_driver);
> > > >  #endif
> > > > +
> > > >  #ifdef CONFIG_ACPI
> > > >  	pnp_unregister_driver(&ipmi_pnp_driver);
> > > >  #endif
> > > 
> > > 
> > 
> > 
> 
> 

