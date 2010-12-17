From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: update return value in EC gpe handler
Date: Fri, 17 Dec 2010 23:17:21 +0100
Message-ID: <201012172317.21272.rjw@sisk.pl>
References: <1292399228.10384.175.camel@minggr.sh.intel.com> <4911F71203A09E4D9981D27F9D830858BF9AAEB9@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36677 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755662Ab0LQWSM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Dec 2010 17:18:12 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858BF9AAEB9@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wednesday, December 15, 2010, Moore, Robert wrote:
> I'm not sure that this is the correct thing to do.
> 
> ACPI_REENABLE_GPE is a new GPE handler return value that implies to ACPICA that the GPE has been fully handled within the (synchronous, interrupt-level) GPE handler and is ready to be cleared (if necessary) and re-enabled.
> 
> The acpi_finish_gpe is a new interface does the same thing, but is intended to be called from an asynchronous GPE handler after the GPE processing is completed. It looks to me that the EC GPE handler is mostly asynchronous, so I suspect that somewhere in the EC driver, a call to acpi_finish_gpe should replace a couple of calls to clear the GPE and re-enable it. That is the purpose of this interface, to relieve the handler of deciding whether to clear the GPE or not (level vs. edge) and then re-enabling it.

You're generally right, but that would involve a major rework of the EC driver,
while I think at the moment we should try to retain the current behavior.

I wonder, though, if the return value should be

(ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE)

Thanks,
Rafael



> -----Original Message-----
> From: Lin, Ming M 
> Sent: Tuesday, December 14, 2010 11:47 PM
> To: lenb
> Cc: Moore, Robert; Rafael J. Wysocki; linux-acpi
> Subject: [PATCH] acpi: update return value in EC gpe handler
> 
> EC gpe handler should return ACPI_REENABLE_GPE, so acpi_ev_gpe_dispatch
> can clear and reenable the GPE.
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
> 
> Len, 
> 
> I forgot to update EC gpe handler return value in the series of 
> "[PATCH v2 0/8] Minimize ACPICA/linux GPE code divergence".
> This is the fix.
> 
>  drivers/acpi/ec.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index e15439a..8a0e907 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -619,7 +619,7 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
>  		wake_up(&ec->wait);
>  		ec_check_sci(ec, acpi_ec_read_status(ec));
>  	}
> -	return ACPI_INTERRUPT_HANDLED;
> +	return ACPI_REENABLE_GPE;
>  }
>  
>  /* --------------------------------------------------------------------------
> 
> 
> 

