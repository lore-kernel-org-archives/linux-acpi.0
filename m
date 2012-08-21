From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 12/13] Thermal: Add documentation for platform layer data
Date: Tue, 21 Aug 2012 08:38:50 +0300
Message-ID: <20120821053849.GB9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-13-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:57433 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752143Ab2HUFi6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:38:58 -0400
Received: by weyt11 with SMTP id t11so4604162wey.11
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:38:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344516365-7230-13-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

hello,

On Thu, Aug 09, 2012 at 06:16:04PM +0530, Durgadoss R wrote:
> This patch adds documentation for the structure
> thermal_zone_params, and also shows an example of
> how to populate them.

Just a reminder, I believe you should also expose some documentation about
the new functions exported in this series.

> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  Documentation/thermal/sysfs-api.txt |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index ca1a1a3..669720c 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -112,6 +112,36 @@ temperature) and throttle appropriate devices.
>      trip: indicates which trip point the cooling devices is associated with
>  	  in this thermal zone.
>  
> +1.4 Thermal Zone Parameters
> +1.4.1 struct thermal_zone_params
> +    This structure defines the platform level parameters for a thermal zone.
> +    This data, for each thermal zone should come from the platform layer.
> +    This is an optional feature where some platforms can choose not to
> +    provide this data.
> +1.4.2 struct thermal_zone_params attributes
> +    .thermal_zone_name: Name of the thermal zone, for which these parameters
> +			are being defined.
> +    .num_cdevs: Number of cooling devices associated with this
> +			  thermal zone.
> +    .cdevs_name: Names of the cooling devices associated with this
> +			   thermal zone.
> +    .weights: This parameter defines the 'influence' of a particular cooling
> +	      device on this thermal zone, on a percentage scale. The sum of
> +	      all these weights cannot exceed 100. The order of values in
> +	      this array should match with that of the cdevs_name.
> +    .trip_mask: This is a bit mask that gives the binding relation between
> +		this thermal zone and cdev, for a particular trip point.
> +		If nth bit is set, then the cdev and thermal zone are bound
> +		for trip point n.
> +1.4.3 An example thermal_zone_params structure
> +	struct thermal_zone_params tzp = {
> +                .thermal_zone_name = "CPU",
> +                .num_cdevs = 2,
> +                .cdevs_name = {"CPU", "Memory"},
> +                .weights = {70, 30},
> +		.trip_mask = {0x0F, 0x08},
> +        };
> +
>  2. sysfs attributes structure
>  
>  RO	read only value
> -- 
> 1.7.9.5
> 
