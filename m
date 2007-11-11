From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] 2.6.24-rc: fix ACPI battery technology reporting
Date: Mon, 12 Nov 2007 01:38:50 +0300
Message-ID: <4737847A.5050702@gmail.com>
References: <200711102002.56951.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:21141 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbXKKWii (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Nov 2007 17:38:38 -0500
Received: by ug-out-1314.google.com with SMTP id z38so659923ugc
        for <linux-acpi@vger.kernel.org>; Sun, 11 Nov 2007 14:38:37 -0800 (PST)
In-Reply-To: <200711102002.56951.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org

Andrey Borzenkov wrote:
> Subject: [PATCH] 2.6.24-rc: fix ACPI battery technology reporting
> From: Andrey Borzenkov <arvidjaar@mail.ru>
>
> At least some systems report technology information with trailing spaces:
>
> {pts/1}% cat -E /var/tmp/bat/2.6.23 | grep type
> battery type:            Li-ION  $
>
> Use strncasecmp to compare model string to skip trailing part
>
> Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
>
>   
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
>
>  drivers/acpi/battery.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index c2ce0ad..1905b88 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -125,7 +125,7 @@ static int acpi_battery_technology(struct acpi_battery 
> *battery)
>  		return POWER_SUPPLY_TECHNOLOGY_NiMH;
>  	if (!strcasecmp("LION", battery->type))
>  		return POWER_SUPPLY_TECHNOLOGY_LION;
> -	if (!strcasecmp("LI-ION", battery->type))
> +	if (!strncasecmp("LI-ION", battery->type, 6))
>  		return POWER_SUPPLY_TECHNOLOGY_LION;
>  	if (!strcasecmp("LiP", battery->type))
>  		return POWER_SUPPLY_TECHNOLOGY_LIPO;
>   

