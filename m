From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] ACPI / ACPICA: Disable GPEs during initialization
Date: Mon, 27 Dec 2010 21:16:23 +0100
Message-ID: <201012272116.23678.rjw@sisk.pl>
References: <1293403143-11922-1-git-send-email-lenb@kernel.org>  <5acdb1af907d5908b4942d425c0983f353dd8fc5.1293403093.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57547 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab0L0UQx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Dec 2010 15:16:53 -0500
In-Reply-To: <5acdb1af907d5908b4942d425c0983f353dd8fc5.1293403093.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lin, Ming M" <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

Hi,

The patch below is needed in the ACPICA core.

On Sunday, December 26, 2010, Len Brown wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> GPEs with corresponding _Lxx/_Exx control methods need to be disabled
> during initialization in case they have been enabled by the BIOS, so
> that they don't fire up until they are enabled by acpi_update_gpes().
> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=25412
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/acpica/evgpeinit.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
> index 2c7def9..4c8dea5 100644
> --- a/drivers/acpi/acpica/evgpeinit.c
> +++ b/drivers/acpi/acpica/evgpeinit.c
> @@ -408,6 +408,9 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
>  		return_ACPI_STATUS(AE_OK);
>  	}
>  
> +	/* Disable the GPE in case it's been enabled already. */
> +	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
> +
>  	/*
>  	 * Add the GPE information from above to the gpe_event_info block for
>  	 * use during dispatch of this GPE.
> 

