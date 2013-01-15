From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/5] ACPICA: GPE support: remove unnecessary newline from error messages
Date: Tue, 15 Jan 2013 23:28:33 +0100
Message-ID: <2225709.xIUb3ZBS1U@vostro.rjw.lan>
References: <1354189996-14431-1-git-send-email-colin.king@canonical.com> <1354189996-14431-5-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41463 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754976Ab3AOWWl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jan 2013 17:22:41 -0500
In-Reply-To: <1354189996-14431-5-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Colin King <colin.king@canonical.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi Bob,

This appears to be upstream ACPICA material.

Thanks,
Rafael


On Thursday, November 29, 2012 11:53:15 AM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> ACPI_ERROR() already appends a newline, so there is no
> need for the error messages to include one too.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/acpica/hwgpe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
> index db40765..610ed72 100644
> --- a/drivers/acpi/acpica/hwgpe.c
> +++ b/drivers/acpi/acpica/hwgpe.c
> @@ -134,7 +134,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
>  		break;
>  
>  	default:
> -		ACPI_ERROR((AE_INFO, "Invalid GPE Action, %u\n", action));
> +		ACPI_ERROR((AE_INFO, "Invalid GPE Action, %u", action));
>  		return (AE_BAD_PARAMETER);
>  	}
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
