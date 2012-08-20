From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 00/13] Thermal: generic thermal layer enhancement
Date: Mon, 20 Aug 2012 18:53:36 +0300
Message-ID: <20120820155336.GM9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42706 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753221Ab2HTPxp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 11:53:45 -0400
Received: by bkcji1 with SMTP id ji1so1827759bkc.4
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 08:53:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hello Rui,

On Thu, Jul 26, 2012 at 04:41:10PM +0800, Zhang Rui wrote:
> 
> Hi, all,
> 
> This is the patch set for linux-next.

The patch series looks good to me. The only issue is that, as now the omap-thermal
driver is under staging directory, you might want to update the series to cover it as
well (patches 03 and 05). I can provide you patches if you wish, but I'd recommend to
write atomic patches so that we always keep the tree in one piece.

Let me know what you think.

> 
> the changes includes:
> 
> V4:
> - dropped three patches which have been already picked by Len.
> - re-organize some piece of code based on Rafael's comments
> - improve some changelog
> 
> V3: http://marc.info/?l=linux-acpi&m=134318254518940&w=2
> - fixing a build error.
> - making a couple of changes based on Rafael's comments
> - removing the plist patch for now as I do not have validate data to show how much benefit it brings.
> 
> V2: http://marc.info/?l=linux-acpi&m=134267975014396&w=2
> - a couple of changes based on Eduardo and Amit's comments.
> - convert an internal list to plist to be more efficiency.
> 
> V1: http://marc.info/?l=linux-acpi&m=133938485224765&w=2
> - 12 RFC patches to fix the problems discussed in http://marc.info/?l=linux-acpi&m=133836783425764&w=2
> 
> please kindly review.
> 
> Any comments are welcome.
> 
> thanks,
> rui
> 
> ---------------------------------------------------------------------------
> Zhang Rui (13):
>       Thermal: Introduce multiple cooling states support
>       Thermal: Introduce cooling states range support
>       Thermal: set upper and lower limits
>       Thermal: Introduce .get_trend() callback.
>       Thermal: Remove tc1/tc2 in generic thermal layer.
>       Thermal: Introduce thermal_zone_trip_update()
>       Thermal: rename structure thermal_cooling_device_instance to thermal_instance
>       Thermal: Rename thermal_zone_device.cooling_devices to thermal_zone_device.instances
>       Thermal: Rename thermal_instance.node to thermal_instance.tz_node.
>       Thermal: List thermal_instance in thermal_cooling_device.
>       Thermal: Introduce simple arbitrator for setting device cooling state
>       Thermal: Unify the code for both active and passive cooling
>       Thermal: Introduce locking for cdev.thermal_instances
> ---------------------------------------------------------------------------
>  Documentation/thermal/sysfs-api.txt      |    9 +-
>  drivers/acpi/thermal.c                   |   98 +++++++---
>  drivers/platform/x86/acerhdf.c           |    5 +-
>  drivers/platform/x86/intel_mid_thermal.c |    2 +-
>  drivers/thermal/spear_thermal.c          |    2 +-
>  drivers/thermal/thermal_sys.c            |  308 +++++++++++++++++++-----------
>  include/linux/thermal.h                  |   28 ++-
>  7 files changed, 300 insertions(+), 152 deletions(-)
> ---------------------------------------------------------------------------
