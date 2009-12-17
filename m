From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/3] ipmi/acpi: Fix the building error in ipmi module
Date: Thu, 17 Dec 2009 09:16:41 +0800
Message-ID: <1261012601.3732.21.camel@localhost.localdomain>
References: <1260974431-4330-1-git-send-email-yakui.zhao@intel.com>
	 <200912160852.43206.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42208 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbZLQBSZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Dec 2009 20:18:25 -0500
In-Reply-To: <200912160852.43206.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>, "openipmi-developer@lists.sourceforege.net" <openipmi-developer@lists.sourceforege.net>

On Wed, 2009-12-16 at 23:52 +0800, Bjorn Helgaas wrote:
> On Wednesday 16 December 2009 07:40:29 am yakui.zhao@intel.com wrote:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> > When the IPMI module is selected as module, it will complain the
> > following building error.
> > >ERROR: "pnpacpi_protocol" [drivers/char/ipmi/ipmi_si.ko] undefined!
> > 
> > Fix the above building error.
> 
> This is already fixed in Len's tree, so we don't need this patch.
Yes. Just now I checked Len's tree and this is already fixed.

Thanks.
> 
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > ---
> >  drivers/pnp/pnpacpi/core.c |    7 +++++++
> >  include/linux/pnp.h        |   11 +++--------
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> > index 8dd0f37..8eebbe4 100644
> > --- a/drivers/pnp/pnpacpi/core.c
> > +++ b/drivers/pnp/pnpacpi/core.c
> > @@ -155,6 +155,13 @@ struct pnp_protocol pnpacpi_protocol = {
> >  #endif
> >  };
> >  
> > +struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
> > +{
> > +	if (dev->protocol == &pnpacpi_protocol)
> > +		return dev->data;
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(pnp_acpi_device);
> >  static int __init pnpacpi_add_device(struct acpi_device *device)
> >  {
> >  	acpi_handle temp = NULL;
> > diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> > index 7c4193e..0ae2c64 100644
> > --- a/include/linux/pnp.h
> > +++ b/include/linux/pnp.h
> > @@ -335,16 +335,11 @@ extern struct pnp_protocol pnpbios_protocol;
> >  #endif
> >  
> >  #ifdef CONFIG_PNPACPI
> > -extern struct pnp_protocol pnpacpi_protocol;
> >  
> > -static inline struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
> > -{
> > -	if (dev->protocol == &pnpacpi_protocol)
> > -		return dev->data;
> > -	return NULL;
> > -}
> > +extern struct acpi_device *pnp_acpi_device(struct pnp_dev *dev);
> >  #else
> > -#define pnp_acpi_device(dev) 0
> > +static inline struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
> > +{ return NULL; }
> >  #endif
> >  
> >  /* status */
> 
> 

