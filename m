From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2] drm/i915/opregion: ignore firmware
 requests for backlight change
Date: Tue, 08 Jul 2014 09:30:37 +0800
Message-ID: <53BB49BD.5000903@intel.com>
References: <53A8E400.5060709@intel.com> <87tx796yc5.fsf@intel.com>
 <53BA4FB7.5050701@intel.com> <200703196.0AouFjfuqr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <200703196.0AouFjfuqr@vostro.rjw.lan>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Anton Gubarkov <anton.gubarkov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On 07/07/2014 08:51 PM, Rafael J. Wysocki wrote:
> On Monday, July 07, 2014 03:43:51 PM Aaron Lu wrote:
>> Some Thinkpad laptops' firmware will initiate a backlight level change
>> request through operation region on the events of AC plug/unplug, but
>> since we are not using firmware's interface to do the backlight setting
>> on these affected laptops, we do not want the firmware to use some
>> arbitrary value from its ASL variable to set the backlight level on
>> AC plug/unplug either.
>>
>> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=76491
>> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=77091
>> Reported-and-tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
>> Reported-and-tested-by: Anton Gubarkov <anton.gubarkov@gmail.com>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> I think we need this in 3.16, right?

Yes, this patch is for v3.16.

> 
> Is it also necessary in any -stable and if so, which one?

For one of the affected system 'ThinkPad X1 Carbon', it makes sense to
back port the patch to v3.14 and v3.15 since it is in video module's
use_native_backlight DMI table. For the other one, since it is not in
the DMI table, it doesn't make a difference. I'll leave this to you to
decide.

Thanks,
Aaron

> 
> Rafael
> 
> 
>> ---
>> v2: add a debug message when ignoring opregion request as suggested by
>>     Jani Nikula.
>>
>>  drivers/acpi/video.c                  | 3 ++-
>>  drivers/gpu/drm/i915/intel_opregion.c | 9 +++++++++
>>  include/acpi/video.h                  | 2 ++
>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index fb9ffe9adc64..cf99d6d2d491 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -241,13 +241,14 @@ static bool acpi_video_use_native_backlight(void)
>>  		return use_native_backlight_dmi;
>>  }
>>  
>> -static bool acpi_video_verify_backlight_support(void)
>> +bool acpi_video_verify_backlight_support(void)
>>  {
>>  	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
>>  	    backlight_device_registered(BACKLIGHT_RAW))
>>  		return false;
>>  	return acpi_video_backlight_support();
>>  }
>> +EXPORT_SYMBOL(acpi_video_verify_backlight_support);
>>  
>>  /* backlight device sysfs support */
>>  static int acpi_video_get_brightness(struct backlight_device *bd)
>> diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/intel_opregion.c
>> index 2e2c71fcc9ed..4f6b53998d79 100644
>> --- a/drivers/gpu/drm/i915/intel_opregion.c
>> +++ b/drivers/gpu/drm/i915/intel_opregion.c
>> @@ -403,6 +403,15 @@ static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
>>  
>>  	DRM_DEBUG_DRIVER("bclp = 0x%08x\n", bclp);
>>  
>> +	/*
>> +	 * If the acpi_video interface is not supposed to be used, don't
>> +	 * bother processing backlight level change requests from firmware.
>> +	 */
>> +	if (!acpi_video_verify_backlight_support()) {
>> +		DRM_DEBUG_KMS("opregion backlight request ignored\n");
>> +		return 0;
>> +	}
>> +
>>  	if (!(bclp & ASLE_BCLP_VALID))
>>  		return ASLC_BACKLIGHT_FAILED;
>>  
>> diff --git a/include/acpi/video.h b/include/acpi/video.h
>> index ea4c7bbded4d..92f8c4bffefb 100644
>> --- a/include/acpi/video.h
>> +++ b/include/acpi/video.h
>> @@ -22,6 +22,7 @@ extern void acpi_video_unregister(void);
>>  extern void acpi_video_unregister_backlight(void);
>>  extern int acpi_video_get_edid(struct acpi_device *device, int type,
>>  			       int device_id, void **edid);
>> +extern bool acpi_video_verify_backlight_support(void);
>>  #else
>>  static inline int acpi_video_register(void) { return 0; }
>>  static inline void acpi_video_unregister(void) { return; }
>> @@ -31,6 +32,7 @@ static inline int acpi_video_get_edid(struct acpi_device *device, int type,
>>  {
>>  	return -ENODEV;
>>  }
>> +static bool acpi_video_verify_backlight_support() { return false; }
>>  #endif
>>  
>>  #endif
>>
> 
