From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 00/13] Thermal: generic thermal layer enhancement
Date: Tue, 21 Aug 2012 08:10:19 +0300
Message-ID: <20120821051018.GU9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <20120820155336.GM9833@besouro>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53813 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575Ab2HUFK2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:10:28 -0400
Received: by wgbfm10 with SMTP id fm10so4102586wgb.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:10:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120820155336.GM9833@besouro>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hello Rui,

On Mon, Aug 20, 2012 at 06:53:36PM +0300, Eduardo Valentin wrote:
> Hello Rui,
> 
> On Thu, Jul 26, 2012 at 04:41:10PM +0800, Zhang Rui wrote:
> > 
> > Hi, all,
> > 
> > This is the patch set for linux-next.
> 
> The patch series looks good to me. The only issue is that, as now the omap-thermal
> driver is under staging directory, you might want to update the series to cover it as
> well (patches 03 and 05). I can provide you patches if you wish, but I'd recommend to
> write atomic patches so that we always keep the tree in one piece.
> 
> Let me know what you think.

Here is the differential diff on omap-thermal-common.c, on top of this series, which pretty much same diff
compared to your branch. First hunk is on patch 03/13. Second one on patch 05/13. Feel free to include
those on your patches.

diff --git a/drivers/staging/omap-thermal/omap-thermal-common.c b/drivers/staging/omap-thermal/omap-thermal-common.c
index 0675a5e..b4cd6cc 100644
--- a/drivers/staging/omap-thermal/omap-thermal-common.c
+++ b/drivers/staging/omap-thermal/omap-thermal-common.c
@@ -120,7 +120,9 @@ static int omap_thermal_bind(struct thermal_zone_device *thermal,
 
        /* TODO: bind with min and max states */
        /* Simple thing, two trips, one passive another critical */
-       return thermal_zone_bind_cooling_device(thermal, 0, cdev);
+       return thermal_zone_bind_cooling_device(thermal, 0, cdev,
+                                               THERMAL_NO_LIMIT,
+                                               THERMAL_NO_LIMIT);
 }
 
 /* Unbind callback functions for thermal zone */
@@ -246,7 +248,7 @@ int omap_thermal_expose_sensor(struct omap_bandgap *bg_ptr, int id,
        /* Create thermal zone */
        data->omap_thermal = thermal_zone_device_register(domain,
                                OMAP_TRIP_NUMBER, 0, data, &omap_thermal_ops,
-                               0, FAST_TEMP_MONITORING_RATE, 0, 0);
+                               0, FAST_TEMP_MONITORING_RATE);
        if (IS_ERR_OR_NULL(data->omap_thermal)) {
                dev_err(bg_ptr->dev, "thermal zone device is NULL\n");
                return PTR_ERR(data->omap_thermal);


> 
> > 
> > the changes includes:
> > 
> > V4:
> > - dropped three patches which have been already picked by Len.
> > - re-organize some piece of code based on Rafael's comments
> > - improve some changelog
> > 
> > V3: http://marc.info/?l=linux-acpi&m=134318254518940&w=2
> > - fixing a build error.
> > - making a couple of changes based on Rafael's comments
> > - removing the plist patch for now as I do not have validate data to show how much benefit it brings.
> > 
> > V2: http://marc.info/?l=linux-acpi&m=134267975014396&w=2
> > - a couple of changes based on Eduardo and Amit's comments.
> > - convert an internal list to plist to be more efficiency.
> > 
> > V1: http://marc.info/?l=linux-acpi&m=133938485224765&w=2
> > - 12 RFC patches to fix the problems discussed in http://marc.info/?l=linux-acpi&m=133836783425764&w=2
> > 
> > please kindly review.
> > 
> > Any comments are welcome.
> > 
> > thanks,
> > rui
> > 
> > ---------------------------------------------------------------------------
> > Zhang Rui (13):
> >       Thermal: Introduce multiple cooling states support
> >       Thermal: Introduce cooling states range support
> >       Thermal: set upper and lower limits
> >       Thermal: Introduce .get_trend() callback.
> >       Thermal: Remove tc1/tc2 in generic thermal layer.
> >       Thermal: Introduce thermal_zone_trip_update()
> >       Thermal: rename structure thermal_cooling_device_instance to thermal_instance
> >       Thermal: Rename thermal_zone_device.cooling_devices to thermal_zone_device.instances
> >       Thermal: Rename thermal_instance.node to thermal_instance.tz_node.
> >       Thermal: List thermal_instance in thermal_cooling_device.
> >       Thermal: Introduce simple arbitrator for setting device cooling state
> >       Thermal: Unify the code for both active and passive cooling
> >       Thermal: Introduce locking for cdev.thermal_instances
> > ---------------------------------------------------------------------------
> >  Documentation/thermal/sysfs-api.txt      |    9 +-
> >  drivers/acpi/thermal.c                   |   98 +++++++---
> >  drivers/platform/x86/acerhdf.c           |    5 +-
> >  drivers/platform/x86/intel_mid_thermal.c |    2 +-
> >  drivers/thermal/spear_thermal.c          |    2 +-
> >  drivers/thermal/thermal_sys.c            |  308 +++++++++++++++++++-----------
> >  include/linux/thermal.h                  |   28 ++-
> >  7 files changed, 300 insertions(+), 152 deletions(-)
> > ---------------------------------------------------------------------------
