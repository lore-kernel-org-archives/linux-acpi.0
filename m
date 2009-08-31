From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/6] acpi: thermal: display forced passive trip points
	in proc
Date: Mon, 31 Aug 2009 16:20:13 +0800
Message-ID: <1251706813.3483.172.camel@rzhang-dt>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
	 <1251303445-25317-4-git-send-email-elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46853 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbZHaIWV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Aug 2009 04:22:21 -0400
In-Reply-To: <1251303445-25317-4-git-send-email-elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Thu, 2009-08-27 at 00:17 +0800, Frans Pop wrote:
> Users can force passive cooling for a thermal zone that does not
> have _PSV defined in ACPI by setting the passive attribute in sysfs.
> It's useful to display such trip points in /proc/acpi/thermal_zone.
> 
> .../TZ1/cooling_mode:<setting not supported>
> .../TZ1/polling_frequency:polling frequency:       10 seconds
> .../TZ1/state:state:                   ok
> .../TZ1/temperature:temperature:             53 C
> .../TZ1/trip_points:critical (S5):           110 C
> .../TZ1/trip_points:passive (forced):        95 C
> 
> And if not set (passive is 0):
> .../TZ1/trip_points:passive (forced):<not set>
> 
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> 
Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 564ea14..a4e507b 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -1050,6 +1050,13 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
>  				   acpi_device_bid(device));
>  		}
>  		seq_puts(seq, "\n");
> +	} else {
> +		seq_printf(seq, "passive (forced):");
> +		if (tz->thermal_zone->forced_passive)
> +			seq_printf(seq, "        %i C\n",
> +				   tz->thermal_zone->forced_passive / 1000);
> +		else
> +			seq_printf(seq, "<not set>\n");
>  	}
>  
>  	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {

