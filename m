From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / Thermal / video: fix max_level incorrect value
Date: Wed, 25 May 2016 13:15:26 +0800
Message-ID: <20160525051526.GA18305@aaronlu.sh.intel.com>
References: <4736.1463510462@turing-police.cc.vt.edu>
 <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
 <6459.1463698397@turing-police.cc.vt.edu>
 <7208.1463713500@turing-police.cc.vt.edu>
 <6674547c-cefb-1b93-893a-7c5909a180a7@intel.com>
 <2897.1463727728@turing-police.cc.vt.edu>
 <20160520071720.GA30152@aaronlu.sh.intel.com>
 <29833.1463789712@turing-police.cc.vt.edu>
 <20160521032933.GA12918@aaronlu.sh.intel.com>
 <20160521075500.GA22025@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160521075500.GA22025@aaronlu.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Valdis, can you please give the patch a try? Thanks.

-Aaron

On Sat, May 21, 2016 at 03:55:00PM +0800, Aaron Lu wrote:
> I think I have found the problem, please give the patch a test, thanks.
> 
> From: Aaron Lu <aaron.lu@intel.com>
> Date: Sat, 21 May 2016 15:30:46 +0800
> Subject: [PATCH] ACPI / Thermal / video: fix max_level incorrect value
> 
> commit 059500940def("ACPI/video: export acpi_video_get_levels")
> mistakenly dropped the correct value of max_level and that caused the
> set_level function following failed and the acpi_video backlight interface
> didn't get created. Fix this by passing back the correct max_level value.
> 
> While at it, also fix the param used in acpi_video_device_lcd_query_levels
> where acpi_handle is expected but acpi_video_device is passed.
> 
> Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  drivers/acpi/acpi_video.c                         | 9 ++++++---
>  drivers/thermal/int340x_thermal/int3406_thermal.c | 2 +-
>  include/acpi/video.h                              | 6 ++++--
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 3d5b8a099351..c1d138e128cb 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -754,7 +754,8 @@ static int acpi_video_bqc_quirk(struct acpi_video_device *device,
>  }
>  
>  int acpi_video_get_levels(struct acpi_device *device,
> -			  struct acpi_video_device_brightness **dev_br)
> +			  struct acpi_video_device_brightness **dev_br,
> +			  int *pmax_level)
>  {
>  	union acpi_object *obj = NULL;
>  	int i, max_level = 0, count = 0, level_ac_battery = 0;
> @@ -841,6 +842,8 @@ int acpi_video_get_levels(struct acpi_device *device,
>  
>  	br->count = count;
>  	*dev_br = br;
> +	if (pmax_level)
> +		*pmax_level = max_level;
>  
>  out:
>  	kfree(obj);
> @@ -869,7 +872,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>  	struct acpi_video_device_brightness *br = NULL;
>  	int result = -EINVAL;
>  
> -	result = acpi_video_get_levels(device->dev, &br);
> +	result = acpi_video_get_levels(device->dev, &br, &max_level);
>  	if (result)
>  		return result;
>  	device->brightness = br;
> @@ -1737,7 +1740,7 @@ static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
>  
>  	mutex_lock(&video->device_list_lock);
>  	list_for_each_entry(dev, &video->video_device_list, entry) {
> -		if (!acpi_video_device_lcd_query_levels(dev, &levels))
> +		if (!acpi_video_device_lcd_query_levels(dev->dev->handle, &levels))
>  			kfree(levels);
>  	}
>  	mutex_unlock(&video->device_list_lock);
> diff --git a/drivers/thermal/int340x_thermal/int3406_thermal.c b/drivers/thermal/int340x_thermal/int3406_thermal.c
> index 13d431cbd29e..a578cd257db4 100644
> --- a/drivers/thermal/int340x_thermal/int3406_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3406_thermal.c
> @@ -177,7 +177,7 @@ static int int3406_thermal_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	d->raw_bd = bd;
>  
> -	ret = acpi_video_get_levels(ACPI_COMPANION(&pdev->dev), &d->br);
> +	ret = acpi_video_get_levels(ACPI_COMPANION(&pdev->dev), &d->br, NULL);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index 70a41f742037..5731ccb42585 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -51,7 +51,8 @@ extern void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type);
>   */
>  extern bool acpi_video_handles_brightness_key_presses(void);
>  extern int acpi_video_get_levels(struct acpi_device *device,
> -				 struct acpi_video_device_brightness **dev_br);
> +				 struct acpi_video_device_brightness **dev_br,
> +				 int *pmax_level);
>  #else
>  static inline int acpi_video_register(void) { return 0; }
>  static inline void acpi_video_unregister(void) { return; }
> @@ -72,7 +73,8 @@ static inline bool acpi_video_handles_brightness_key_presses(void)
>  	return false;
>  }
>  static inline int acpi_video_get_levels(struct acpi_device *device,
> -			struct acpi_video_device_brightness **dev_br)
> +			struct acpi_video_device_brightness **dev_br,
> +			int *pmax_level)
>  {
>  	return -ENODEV;
>  }
> -- 
> 2.5.5
> 
