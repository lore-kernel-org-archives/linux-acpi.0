From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/Power: Release resource_lock after acpi_power_get_state() return error
Date: Tue, 15 Oct 2013 23:06:58 +0200
Message-ID: <2169851.4V0lKD9xHQ@vostro.rjw.lan>
References: <1381837691-3657-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65231 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759545Ab3JOUzJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 16:55:09 -0400
In-Reply-To: <1381837691-3657-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, October 15, 2013 07:48:11 PM Lan Tianyu wrote:
> resource_lock should be released when acpi_power_get_state() fails and before
> passing to next power resource on the acpi power resource list.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Yup, good catch!

I'll queue this up as a fix for 3.12.

Thanks!

> ---
>  drivers/acpi/power.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 0dbe5cd..0c1c3ec 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -936,8 +936,10 @@ void acpi_resume_power_resources(void)
>  		mutex_lock(&resource->resource_lock);
>  
>  		result = acpi_power_get_state(resource->device.handle, &state);
> -		if (result)
> +		if (result) {
> +			mutex_unlock(&resource->resource_lock);
>  			continue;
> +		}
>  
>  		if (state == ACPI_POWER_RESOURCE_STATE_OFF
>  		    && resource->ref_count) {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
