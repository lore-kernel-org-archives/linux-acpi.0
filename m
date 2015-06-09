From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2] acpi-video: Add a parameter to not register the
 backlight sysfs interface
Date: Tue, 9 Jun 2015 17:10:42 +0800
Message-ID: <20150609091042.GA1280@aaronlu.sh.intel.com>
References: <1433838745-8857-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11999 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228AbbFIJJe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2015 05:09:34 -0400
Content-Disposition: inline
In-Reply-To: <1433838745-8857-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, platform-driver-x86@vger.kernel.org, dri-devel@lists.freedesktop.org, Sylvain Pasche <sylvain.pasche@gmail.com>, linux-acpi@vger.kernel.org

On Tue, Jun 09, 2015 at 10:32:25AM +0200, Hans de Goede wrote:
> On some systems acpi-video backlight is broken in the sense that it cannot
> control the brightness of the backlight, but it must still be called on
> resume to power-up the backlight after resume.

All the video module does on resume is a backlight set operation, it
can't control backlight but can turn on the screen on resume? Hmm...

I'll ask Sylvain to attach acpidump, let's see if there is anything
special there.

Regards,
Aaron

> 
> This commit allows these systems to work by going through all the usual
> backlight control moves, while not registering a sysfs backlight
> interface.
> 
> This commit also adds a quirk enabling this parameter on Toshiba Portege
> R830 systems which are known to be affected by this.
> 
> I wish there was a better way to deal with this, but we've been unable to
> find one.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=21012
> Buglink: https://bugs.freedesktop.org/show_bug.cgi?id=82634
> Reported-and-tested-by: Sylvain Pasche <sylvain.pasche@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Simplify check in acpi_video_switch_brightness()
> -If backlight registration fails set device->backlight to NULL, rather
>  then leaving the PTR_ERR in there and trying to deref this later
>  (this fixes a pre-existing bug)
> ---
>  drivers/acpi/video.c | 43 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 518f0e1..3bc4c68 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -92,6 +92,9 @@ static int use_native_backlight_param = NATIVE_BACKLIGHT_NOT_SET;
>  module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
>  static int use_native_backlight_dmi = NATIVE_BACKLIGHT_NOT_SET;
>  
> +static int disable_backlight_sysfs_if = -1;
> +module_param(disable_backlight_sysfs_if, int, 0444);
> +
>  static int register_count;
>  static struct mutex video_list_lock;
>  static struct list_head video_bus_head;
> @@ -431,6 +434,14 @@ static int __init video_enable_native_backlight(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +static int __init video_disable_backlight_sysfs_if(
> +	const struct dmi_system_id *d)
> +{
> +	if (disable_backlight_sysfs_if == -1)
> +		disable_backlight_sysfs_if = 1;
> +	return 0;
> +}
> +
>  static struct dmi_system_id video_dmi_table[] __initdata = {
>  	/*
>  	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
> @@ -592,6 +603,23 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
>  		},
>  	},
> +
> +	/*
> +	 * Some machines have a broken acpi-video interface for brightness
> +	 * control, but still need an acpi_video_device_lcd_set_level() call
> +	 * on resume to turn the backlight power on.  We Enable backlight
> +	 * control on these systems, but do not register a backlight sysfs
> +	 * as brightness control does not work.
> +	 */
> +	{
> +	 /* https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
> +	 .callback = video_disable_backlight_sysfs_if,
> +	 .ident = "Toshiba Portege R830",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R830"),
> +		},
> +	},
>  	{}
>  };
>  
> @@ -1391,7 +1419,7 @@ acpi_video_switch_brightness(struct work_struct *work)
>  	int result = -EINVAL;
>  
>  	/* no warning message if acpi_backlight=vendor or a quirk is used */
> -	if (!acpi_video_verify_backlight_support())
> +	if (!device->backlight)
>  		return;
>  
>  	if (!device->brightness)
> @@ -1666,8 +1694,9 @@ static int acpi_video_resume(struct notifier_block *nb,
>  
>  	for (i = 0; i < video->attached_count; i++) {
>  		video_device = video->attached_array[i].bind_info;
> -		if (video_device && video_device->backlight)
> -			acpi_video_set_brightness(video_device->backlight);
> +		if (video_device && video_device->brightness)
> +			acpi_video_device_lcd_set_level(video_device,
> +					video_device->brightness->curr);
>  	}
>  
>  	return NOTIFY_OK;
> @@ -1716,6 +1745,10 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>  	result = acpi_video_init_brightness(device);
>  	if (result)
>  		return;
> +
> +	if (disable_backlight_sysfs_if > 0)
> +		return;
> +
>  	name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
>  	if (!name)
>  		return;
> @@ -1738,8 +1771,10 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>  						      &acpi_backlight_ops,
>  						      &props);
>  	kfree(name);
> -	if (IS_ERR(device->backlight))
> +	if (IS_ERR(device->backlight)) {
> +		device->backlight = NULL;
>  		return;
> +	}
>  
>  	/*
>  	 * Save current brightness level in case we have to restore it
> -- 
> 2.4.2
> 
