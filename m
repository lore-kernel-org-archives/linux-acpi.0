From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Fixed wrong variable usage in thermal driver
Date: Tue, 08 Apr 2014 14:32:43 +0200
Message-ID: <45064929.uVZr4d3BY5@vostro.rjw.lan>
References: <1396099547-3394-1-git-send-email-zzhsuny@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54566 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756207AbaDHMQn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Apr 2014 08:16:43 -0400
In-Reply-To: <1396099547-3394-1-git-send-email-zzhsuny@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhihui Zhang <zzhsuny@gmail.com>
Cc: rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

On Saturday, March 29, 2014 09:25:47 AM Zhihui Zhang wrote:
> Signed-off-by: Zhihui Zhang <zzhsuny@gmail.com>

Queued up for the next ACPI pull request, thanks!

> ---
>  drivers/acpi/thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 08626c8..6afe95b 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -338,7 +338,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  			tz->trips.hot.flags.valid = 1;
>  			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  					"Found hot threshold [%lu]\n",
> -					tz->trips.critical.temperature));
> +					tz->trips.hot.temperature));
>  		}
>  	}
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
