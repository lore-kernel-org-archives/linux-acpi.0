From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] ACPICA: Rename some function and variable names
Date: Thu, 9 Dec 2010 23:51:21 +0100
Message-ID: <201012092351.21589.rjw@sisk.pl>
References: <1291651120.2197.80.camel@localhost> <201012092259.38254.rjw@sisk.pl> <4911F71203A09E4D9981D27F9D830858BCADEC3D@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42130 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756548Ab0LIWwI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 17:52:08 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858BCADEC3D@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thursday, December 09, 2010, Moore, Robert wrote:
> For the next time we attempt to make such a large ACPICA change, we need to put a methodology in place to simplify things. It has been very difficult for us to take Linux patches, backport and integrate into ACPICA, make additional changes, then forward port the final ACPICA changes to Linux, and then shoehorn the code into the original Linux patches.
> 
> Difficult as in several times the work.
> 
> Ming has worked very hard to forward-port the ACPICA code and then shoehorn the changes into the original Linux patches.
> 
> But we can't do it this way again. 
> 
> We are open to suggestions on a better way to do this, perhaps Len can help.

Well, I'm talking about a simple thing like splitting a patch into two pieces.
That's not going to take a lot of time IMO and the benefit is that more people
may actually understand what's being done.

Moreover, if anyone hits a problem related to one of your patches, it's vital
to be able to figure out which change caused it to happen.

Thanks,
Rafael


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
> Sent: Thursday, December 09, 2010 2:00 PM
> To: Lin, Ming M
> Cc: Len Brown; Moore, Robert; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 2/6] ACPICA: Rename some function and variable names
> 
> On Monday, December 06, 2010, Lin Ming wrote:
> > Some function and variable names are renamed to be consistent with
> > ACPICA code base.
> > 
> > acpi_raw_enable_gpe -> acpi_ev_add_gpe_reference
> > acpi_raw_disable_gpe -> acpi_ev_remove_gpe_reference
> > acpi_gpe_can_wake -> acpi_setup_gpe_for_wake
> > acpi_gpe_wakeup -> acpi_set_gpe_wake_mask
> > acpi_update_gpes -> acpi_update_all_gpes
> > acpi_all_gpes_initialized -> acpi_gbl_all_gpes_initialized
> > acpi_handler_info -> acpi_gpe_handler_info
> > ...
> > 
> > Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> 
> Well, tha changes related to acpi_ev_gpe_dispatch() do not really match the
> changelog.  I'd prefer them to go into a separate patch with the right
> description.
> 
> ...  
> >  u32
> > -acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info,
> > +acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
> > +		     struct acpi_gpe_event_info *gpe_event_info,
> >  		     u32 gpe_number);
> >  
> ...
> >  					int_status |=
> > -					    acpi_ev_gpe_dispatch(&gpe_block->
> > +					    acpi_ev_gpe_dispatch(gpe_block->
> > +								 node,
> > +								 &gpe_block->
> >  						event_info[((acpi_size) i * ACPI_GPE_REGISTER_WIDTH) + j], j + gpe_register_info->base_gpe_number);
> >  				}
> >  			}
> ...
> > @@ -589,7 +597,9 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
> >  		 * Ignore return status for now.
> >  		 * TBD: leave GPE disabled on error?
> >  		 */
> > -		(void)gpe_event_info->dispatch.handler->address(gpe_event_info->
> > +		(void)gpe_event_info->dispatch.handler->address(gpe_device,
> > +								gpe_number,
> > +								gpe_event_info->
> >  								dispatch.
> >  								handler->
> >  								context);
> ...
> 
> Thanks,
> Rafael
> 

