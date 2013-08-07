From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] ACPI / EC: Fix incorrect placement of __initdata
Date: Thu, 08 Aug 2013 01:17:58 +0200
Message-ID: <3252693.91dNTSIFl5@vostro.rjw.lan>
References: <1375876017-22420-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59807 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933540Ab3HGXHj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Aug 2013 19:07:39 -0400
In-Reply-To: <1375876017-22420-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Wednesday, August 07, 2013 05:16:55 PM Sachin Kamat wrote:
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

All three queued up for 3.12, thanks Sachin!

Rafael


> ---
>  drivers/acpi/ec.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 84bf06c..8dd2d4d 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -948,7 +948,7 @@ static int ec_enlarge_storm_threshold(const struct dmi_system_id *id)
>  	return 0;
>  }
>  
> -static struct dmi_system_id __initdata ec_dmi_table[] = {
> +static struct dmi_system_id ec_dmi_table[] __initdata = {
>  	{
>  	ec_skip_dsdt_scan, "Compal JFL92", {
>  	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
