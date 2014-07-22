From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/NVS: Not save NVS region for new machines to accelerate S3
Date: Wed, 23 Jul 2014 01:40:34 +0200
Message-ID: <1466357.PZLf9xnT2g@vostro.rjw.lan>
References: <1405662922-23606-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56340 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756817AbaGVXWK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jul 2014 19:22:10 -0400
In-Reply-To: <1405662922-23606-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, July 18, 2014 01:55:22 PM Lan Tianyu wrote:
> NVS region is saved and restored unconditionally for machines without
> nvs_nosave quirk during S3. Tested some new machines and the operation
> is not necessary. Saving NVS region also affects S2RAM speed. The time of
> NVS saving and restoring depends on the size of NVS region and it consumes
> 7~10ms normally.
> 
> This patch is to make machines produced from 2012 to now not saving NVS region
> to accelerate S3.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/acpi/sleep.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index b3e3cc7..896d8be 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -322,7 +322,12 @@ static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
>  
>  static void acpi_sleep_dmi_check(void)
>  {
> +	int year;
> +
>  	dmi_check_system(acpisleep_dmi_table);
> +
> +	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year >= 2012)
> +		acpi_nvs_nosave_s3();

I'd prefer the ordering here to be different so that individual quirks
could be used to change the date-based wholesale behavior.

>  }
>  
>  /**
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
