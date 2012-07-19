From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/16] Thermal: Make Thermal trip points writeable
Date: Thu, 19 Jul 2012 21:38:11 +0200
Message-ID: <201207192138.12181.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <1342679480-5336-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48552 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2GSTcc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 15:32:32 -0400
In-Reply-To: <1342679480-5336-2-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

On Thursday, July 19, 2012, Zhang Rui wrote:
> From: Durgadoss R <dugardoss.r@intel.com>
> 
> Some of the thermal drivers using the Generic Thermal Framework
> require (all/some) trip points to be writeable. This patch makes
> the trip point temperatures writeable on a per-trip point basis,
> and modifies the required function call in thermal.c. This patch
> also updates the Documentation to reflect the new change.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  Documentation/thermal/sysfs-api.txt      |    4 +-
>  drivers/acpi/thermal.c                   |    4 +-
>  drivers/platform/x86/acerhdf.c           |    2 +-
>  drivers/platform/x86/intel_mid_thermal.c |    2 +-
>  drivers/thermal/spear_thermal.c          |    2 +-
>  drivers/thermal/thermal_sys.c            |  147 +++++++++++++++++++++---------
>  include/linux/thermal.h                  |   15 ++-
>  7 files changed, 125 insertions(+), 51 deletions(-)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index 1733ab9..0c7c423 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -32,7 +32,8 @@ temperature) and throttle appropriate devices.
>  
>  1.1 thermal zone device interface
>  1.1.1 struct thermal_zone_device *thermal_zone_device_register(char *name,
> -		int trips, void *devdata, struct thermal_zone_device_ops *ops)
> +		int trips, int flag, void *devdata,
> +		struct thermal_zone_device_ops *ops)
>  
>      This interface function adds a new thermal zone device (sensor) to
>      /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
> @@ -40,6 +41,7 @@ temperature) and throttle appropriate devices.
>  
>      name: the thermal zone name.
>      trips: the total number of trip points this thermal zone supports.
> +    flag: Bit string: If 'n'th bit is set, then trip point 'n' is writeable.
>      devdata: device private data
>      ops: thermal zone device call-backs.
>  	.bind: bind the thermal zone device with a thermal cooling device.

I wonder.  What is the maximum number of trip points currently passed to this
function in one call?

Rafael
