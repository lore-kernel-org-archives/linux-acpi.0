From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2 1/3] acpi-video: Add an acpi_video_unregister_backlight
 function
Date: Wed, 21 May 2014 09:30:55 +0800
Message-ID: <537C01CF.5000007@intel.com>
References: <1400316483-6356-1-git-send-email-hdegoede@redhat.com> <1400316483-6356-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1400316483-6356-2-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lee Chun-Yi <jlee@suse.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 05/17/2014 04:48 PM, Hans de Goede wrote:
> Add an acpi_video_unregister_backlight function, which only unregisters
> the backlight device, and leaves the acpi_notifier in place. Some acpi_vendor
> driver need this as they don't want the acpi_video# backlight device, but do
> need the acpi-video driver for hotkey handling.
> 
> Chances are that this new acpi_video_unregister_backlight() is actually
> what existing acpi_vendor drivers have wanted all along. Currently acpi_vendor
> drivers which want to disable the acpi_video# backlight device, make 2 calls:
> 
> acpi_video_dmi_promote_vendor();
> acpi_video_unregister();
> 
> The intention here is to make things independent of when acpi_video_register()
> gets called. As acpi_video_register() will get called on acpi-video load time
> on non intel gfx machines, while it gets called on i915 load time on intel
> gfx machines.
> 
> This leads to the following 2 interesting scenarios:
> 
> a) intel gfx:
> 1) acpi-video module gets loaded (as it is a dependency of acpi_vendor and i915)
> 2) acpi-video does NOT call acpi_video_register()
> 3) acpi_vendor loads (lets assume it loads before i915), calls
> acpi_video_dmi_promote_vendor(); which sets ACPI_VIDEO_BACKLIGHT_DMI_VENDOR
> 4) calls acpi_video_unregister -> not registered, nop
> 5) i915 loads, calls acpi_video_register
> 6) acpi_video_register registers the acpi_notifier for the hotkeys,
>    does NOT register a backlight device because of ACPI_VIDEO_BACKLIGHT_DMI_VENDOR
> 
> b) non intel gfx
> 1) acpi-video module gets loaded (as it is a dependency acpi_vendor)
> 2) acpi-video calls acpi_video_register()
> 3) acpi_video_register registers the acpi_notifier for the hotkeys,
>    and a backlight device
> 4) acpi_vendor loads, calls acpi_video_dmi_promote_vendor()
> 5) calls acpi_video_unregister, this unregisters BOTH the acpi_notifier for
>    the hotkeys AND the backlight device
> 
> So here we have possibly the same acpi_vendor module, making the same calls,
> but with different results, in one cases acpi-video does handle hotkeys,
> in the other it does not.
> 
> Note that the a) scenario turns into b) if we assume the i915 module loads
> before the vendor_acpi module, so we also have different behavior depending
> on module loading order!
> 
> So as said I believe that quite a few existing acpi_vendor modules really
> always want the behavior of a), hence this patch adds a new
> acpi_video_unregister_backlight() which gives the behavior of a) independent
> of module loading order.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron

> ---
>  drivers/acpi/video.c | 14 ++++++++++++++
>  include/acpi/video.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 52176ad..ba6e4d7 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -2166,6 +2166,20 @@ void acpi_video_unregister(void)
>  }
>  EXPORT_SYMBOL(acpi_video_unregister);
>  
> +void acpi_video_unregister_backlight(void)
> +{
> +	struct acpi_video_bus *video;
> +
> +	if (!register_count)
> +		return;
> +
> +	mutex_lock(&video_list_lock);
> +	list_for_each_entry(video, &video_bus_head, entry)
> +		acpi_video_bus_unregister_backlight(video);
> +	mutex_unlock(&video_list_lock);
> +}
> +EXPORT_SYMBOL(acpi_video_unregister_backlight);
> +
>  /*
>   * This is kind of nasty. Hardware using Intel chipsets may require
>   * the video opregion code to be run first in order to initialise
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index 61109f2..ea4c7bb 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -19,11 +19,13 @@ struct acpi_device;
>  #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
>  extern int acpi_video_register(void);
>  extern void acpi_video_unregister(void);
> +extern void acpi_video_unregister_backlight(void);
>  extern int acpi_video_get_edid(struct acpi_device *device, int type,
>  			       int device_id, void **edid);
>  #else
>  static inline int acpi_video_register(void) { return 0; }
>  static inline void acpi_video_unregister(void) { return; }
> +static inline void acpi_video_unregister_backlight(void) { return; }
>  static inline int acpi_video_get_edid(struct acpi_device *device, int type,
>  				      int device_id, void **edid)
>  {
> 
