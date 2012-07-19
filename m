From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 03/16] Thermal: Documentation update
Date: Thu, 19 Jul 2012 10:51:33 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5916675C@BGSMSX101.gar.corp.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
 <1342679480-5336-4-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18204 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab2GSKvi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jul 2012 06:51:38 -0400
In-Reply-To: <1342679480-5336-4-git-send-email-rui.zhang@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

Hi Rui,

No major comments. Just some spell checks.

> -----Original Message-----
> From: Zhang, Rui
> Sent: Thursday, July 19, 2012 12:01 PM
> To: linux-acpi@vger.kernel.org; linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki; Matthew Garrett; Len Brown; R, Durgadoss; Eduardo
> Valentin; Amit Kachhap; Wei Ni; Zhang, Rui
> Subject: [PATCH 03/16] Thermal: Documentation update
> 
> With commit 6503e5df08008b9a47022b5e9ebba658c8fa69af,
> the value of /sys/class/thermal/thermal_zoneX/mode has been changed
> from user/kernel to enabled/disabled.
> Update the documentation so that users won't be confused.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  Documentation/thermal/sysfs-api.txt |   20 ++++++++++----------
>  drivers/acpi/thermal.c              |    6 ++----
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt
> b/Documentation/thermal/sysfs-api.txt
> index 3c8c2f8..b7b3609 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -47,11 +47,11 @@ temperature) and throttle appropriate devices.
>  	.bind: bind the thermal zone device with a thermal cooling device.
>  	.unbind: unbind the thermal zone device with a thermal cooling device.
>  	.get_temp: get the current temperature of the thermal zone.
> -	.get_mode: get the current mode (user/kernel) of the thermal zone.
> -	    - "kernel" means thermal management is done in kernel.
> -	    - "user" will prevent kernel thermal driver actions upon trip points
> +	.get_mode: get the current mode (enabled/disabled) of the thermal
> zone.
> +	    - "enabled" means the kernel thermal management is enabled.
> +	    - "disable" will prevent kernel thermal driver actions upon trip points

/s/disable/disabled

>  	      so that user applications can take charge of thermal management.
> -	.set_mode: set the mode (user/kernel) of the thermal zone.
> +	.set_mode: set the mode (enabled/disabled) of the thermal zone.
>  	.get_trip_type: get the type of certain trip point.
>  	.get_trip_temp: get the temperature above which the certain trip point
>  			will be fired.
> @@ -170,14 +170,14 @@ temp
>  	RO, Required
> 
>  mode
> -	One of the predefined values in [kernel, user].
> +	One of the predefined values in [enabled, disableed].

/s/disableed/disabled

Thanks,
Durga
