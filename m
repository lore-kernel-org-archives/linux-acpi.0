From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Fix CMOS RTC Operation Region handler accesses to wrong address of value
Date: Thu, 04 Sep 2014 21:46:30 +0200
Message-ID: <38112801.VIxC3kPKfk@vostro.rjw.lan>
References: <1409814819-30594-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64469 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754470AbaIDT1J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 15:27:09 -0400
In-Reply-To: <1409814819-30594-1-git-send-email-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thursday, September 04, 2014 03:13:39 PM Lee, Chun-Yi wrote:
> The value64 parameter is an u64 point that used to transfer the value
> for write to CMOS, or used to return the value that's read from CMOS.
> 
> The value64 is an u64 point, so don't need get address again. It causes
> acpi_cmos_rtc_space_handler always return 0 to reader and didn't write
> expected value to CMOS.

Do we need this fix to go to -stable?

> Cc: Lan Tianyu <tianyu.lan@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> ---
>  drivers/acpi/acpi_cmos_rtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
> index 2da8660..81dc750 100644
> --- a/drivers/acpi/acpi_cmos_rtc.c
> +++ b/drivers/acpi/acpi_cmos_rtc.c
> @@ -33,7 +33,7 @@ acpi_cmos_rtc_space_handler(u32 function, acpi_physical_address address,
>  		      void *handler_context, void *region_context)
>  {
>  	int i;
> -	u8 *value = (u8 *)&value64;
> +	u8 *value = (u8 *)value64;
>  
>  	if (address > 0xff || !value64)
>  		return AE_BAD_PARAMETER;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
