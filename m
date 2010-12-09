From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/6] ACPICA: Remove unused function declarations
Date: Thu, 9 Dec 2010 23:11:39 +0100
Message-ID: <201012092311.39857.rjw@sisk.pl>
References: <1291651130.2197.85.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42012 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196Ab0LIWMk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 17:12:40 -0500
In-Reply-To: <1291651130.2197.85.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Monday, December 06, 2010, Lin Ming wrote:
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/acpi/acpica/acevents.h |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
> index ebb467f..04a83fe 100644
> --- a/drivers/acpi/acpica/acevents.h
> +++ b/drivers/acpi/acpica/acevents.h
> @@ -51,8 +51,6 @@ acpi_status acpi_ev_initialize_events(void);
>  
>  acpi_status acpi_ev_install_xrupt_handlers(void);
>  
> -acpi_status acpi_ev_install_fadt_gpes(void);
> -
>  u32 acpi_ev_fixed_event_detect(void);
>  
>  /*
> @@ -127,10 +125,6 @@ acpi_status
>  acpi_ev_match_gpe_method(acpi_handle obj_handle,
>  			 u32 level, void *context, void **return_value);
>  
> -acpi_status
> -acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
> -			  u32 level, void *context, void **return_value);
> -
>  /*
>   * evgpeutil - GPE utilities
>   */
> 

