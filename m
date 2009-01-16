From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: ACPI hotplug panic with current git head
Date: Fri, 16 Jan 2009 12:22:55 -0800
Message-ID: <200901161222.56272.jesse.barnes@intel.com>
References: <1231604250.3642.33.camel@localhost.localdomain> <4970242C.4010404@jp.fujitsu.com> <alpine.LFD.2.00.0901161504140.5705@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50888 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937159AbZAPUXE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Jan 2009 15:23:04 -0500
In-Reply-To: <alpine.LFD.2.00.0901161504140.5705@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, shaohua.li@intel.com

On Friday, January 16, 2009 12:08 pm Len Brown wrote:
> > > It looks like acpi_pci_get_bridge_handle() is returning NULL, so this
> > > is the fix that works for me.
> >
> > I'm sorry for troubling you, and thank you for your patience.
> >
> > The patch seems to avoid the kernel panic, but I still don't know
> > why acpi_pci_get_bridge_handle() returns NULL here. I assumed
> > it should return non-NULL value here. So I'd like to investigate
> > it more.
>
> Kenji,
> I'd like to push jejb's 1-liner upstream now.
> It make sense, and it prevents a boot panic regression
> that I'd rather not have others experience in rc2.
>
> I agree that it is important to hotplug for you to figure out
> why this machine runs down that path in the first place,
> and I'm sure that James will continue to work with you
> on that after the 1-liner is in.
>
> thanks
> Len Brown, Intel Open Source Technology Center
>
> > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c
> > > b/drivers/pci/hotplug/acpiphp_glue.c index f09b101..803d9dd 100644
> > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > @@ -266,6 +266,8 @@ static int detect_ejectable_slots(struct pci_bus
> > > *pbus) int found = acpi_pci_detect_ejectable(pbus);
> > >  	if (!found) {
> > >  		acpi_handle bridge_handle = acpi_pci_get_bridge_handle(pbus);
> > > +		if (!bridge_handle)
> > > +			return 0;
> > >  		acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge_handle, (u32)1,
> > >  				    is_pci_dock_device, (void *)&found, NULL);
> > >  	}


Agreed.  It's funky that we're getting back a NULL here, but we definitely 
don't want people's machines to crash while we figure out what's going 
wrong...

-- 
Jesse Barnes, Intel Open Source Technology Center
