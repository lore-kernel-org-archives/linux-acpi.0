From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] ACPICA: Rename some function and variable names
Date: Thu, 9 Dec 2010 22:59:38 +0100
Message-ID: <201012092259.38254.rjw@sisk.pl>
References: <1291651120.2197.80.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41996 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109Ab0LIWAk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 17:00:40 -0500
In-Reply-To: <1291651120.2197.80.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Monday, December 06, 2010, Lin Ming wrote:
> Some function and variable names are renamed to be consistent with
> ACPICA code base.
> 
> acpi_raw_enable_gpe -> acpi_ev_add_gpe_reference
> acpi_raw_disable_gpe -> acpi_ev_remove_gpe_reference
> acpi_gpe_can_wake -> acpi_setup_gpe_for_wake
> acpi_gpe_wakeup -> acpi_set_gpe_wake_mask
> acpi_update_gpes -> acpi_update_all_gpes
> acpi_all_gpes_initialized -> acpi_gbl_all_gpes_initialized
> acpi_handler_info -> acpi_gpe_handler_info
> ...
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>

Well, tha changes related to acpi_ev_gpe_dispatch() do not really match the
changelog.  I'd prefer them to go into a separate patch with the right
description.

...  
>  u32
> -acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info,
> +acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
> +		     struct acpi_gpe_event_info *gpe_event_info,
>  		     u32 gpe_number);
>  
...
>  					int_status |=
> -					    acpi_ev_gpe_dispatch(&gpe_block->
> +					    acpi_ev_gpe_dispatch(gpe_block->
> +								 node,
> +								 &gpe_block->
>  						event_info[((acpi_size) i * ACPI_GPE_REGISTER_WIDTH) + j], j + gpe_register_info->base_gpe_number);
>  				}
>  			}
...
> @@ -589,7 +597,9 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
>  		 * Ignore return status for now.
>  		 * TBD: leave GPE disabled on error?
>  		 */
> -		(void)gpe_event_info->dispatch.handler->address(gpe_event_info->
> +		(void)gpe_event_info->dispatch.handler->address(gpe_device,
> +								gpe_number,
> +								gpe_event_info->
>  								dispatch.
>  								handler->
>  								context);
...

Thanks,
Rafael
