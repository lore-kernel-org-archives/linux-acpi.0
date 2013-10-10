From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v4 3/4] ACPI / video: Do not register
 backlight if win8 and native interface exists
Date: Thu, 10 Oct 2013 09:02:55 +0800
Message-ID: <5255FCBF.6090708@intel.com>
References: <1381214401-24672-1-git-send-email-aaron.lu@intel.com>
	<1381214401-24672-4-git-send-email-aaron.lu@intel.com>
	<9897358.0Z0t2PgJOe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <9897358.0Z0t2PgJOe@vostro.rjw.lan>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <matthew.garrett@nebula.com>, linux-acpi@vger.kernel.org, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, Mike Galbraith <bitbucket@online.de>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?UTF-8?B?SsO2cmcgT3R0ZQ==?= <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Joerg Platte <jplatte@naasa.net>, Seth Forshee <seth.forshee@canonical.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-acpi@vger.kernel.org

On 10/10/2013 08:29 AM, Rafael J. Wysocki wrote:
> On Tuesday, October 08, 2013 02:40:00 PM Aaron Lu wrote:
>> According to Matthew Garrett, "Windows 8 leaves backlight control up
>> to individual graphics drivers rather than making ACPI calls itself.
>> There's plenty of evidence to suggest that the Intel driver for
>> Windows [8] doesn't use the ACPI interface, including the fact that
>> it's broken on a bunch of machines when the OS claims to support
>> Windows 8.  The simplest thing to do appears to be to disable the
>> ACPI backlight interface on these systems".
>>
>> So for Win8 systems, if there is native backlight control interface
>> registered by GPU driver, ACPI video will not register its own. For
>> users who prefer to keep ACPI video's backlight interface, the existing
>> kernel cmdline option acpi_backlight=video can be used.
>>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>> Tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
>> Tested-by: Yves-Alexis Perez <corsac@debian.org>
>> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> ---
>>  drivers/acpi/internal.h     |  5 ++---
>>  drivers/acpi/video.c        | 10 +++++-----
>>  drivers/acpi/video_detect.c | 14 ++++++++++++--
>>  3 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 20f4233..453ae8d 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -169,9 +169,8 @@ int acpi_create_platform_device(struct acpi_device *adev,
>>  					Video
>>    -------------------------------------------------------------------------- */
>>  #if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
>> -bool acpi_video_backlight_quirks(void);
>> -#else
>> -static inline bool acpi_video_backlight_quirks(void) { return false; }
>> +bool acpi_osi_is_win8(void);
>> +bool acpi_video_verify_backlight_support(void);
>>  #endif
>>  
>>  #endif /* _ACPI_INTERNAL_H_ */
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 3bd1eaa..343db59 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -1256,8 +1256,8 @@ acpi_video_switch_brightness(struct acpi_video_device *device, int event)
>>  	unsigned long long level_current, level_next;
>>  	int result = -EINVAL;
>>  
>> -	/* no warning message if acpi_backlight=vendor is used */
>> -	if (!acpi_video_backlight_support())
>> +	/* no warning message if acpi_backlight=vendor or a quirk is used */
>> +	if (!acpi_video_verify_backlight_support())
>>  		return 0;
>>  
>>  	if (!device->brightness)
>> @@ -1386,13 +1386,13 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
>>  static int acpi_video_bus_start_devices(struct acpi_video_bus *video)
>>  {
>>  	return acpi_video_bus_DOS(video, 0,
>> -				  acpi_video_backlight_quirks() ? 1 : 0);
>> +				  acpi_osi_is_win8() ? 1 : 0);
>>  }
>>  
>>  static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
>>  {
>>  	return acpi_video_bus_DOS(video, 0,
>> -				  acpi_video_backlight_quirks() ? 0 : 1);
>> +				  acpi_osi_is_win8() ? 0 : 1);
>>  }
>>  
>>  static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
>> @@ -1558,7 +1558,7 @@ acpi_video_bus_match(acpi_handle handle, u32 level, void *context,
>>  
>>  static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>>  {
>> -	if (acpi_video_backlight_support()) {
>> +	if (acpi_video_verify_backlight_support()) {
>>  		struct backlight_properties props;
>>  		struct pci_dev *pdev;
>>  		acpi_handle acpi_parent;
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index 940edbf..23d7d26 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -37,6 +37,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/dmi.h>
>>  #include <linux/pci.h>
>> +#include <linux/backlight.h>
>>  
>>  #include "internal.h"
>>  
>> @@ -233,11 +234,11 @@ static void acpi_video_caps_check(void)
>>  		acpi_video_get_capabilities(NULL);
>>  }
>>  
>> -bool acpi_video_backlight_quirks(void)
>> +bool acpi_osi_is_win8(void)
>>  {
>>  	return acpi_gbl_osi_data >= ACPI_OSI_WIN_8;
>>  }
>> -EXPORT_SYMBOL(acpi_video_backlight_quirks);
>> +EXPORT_SYMBOL(acpi_osi_is_win8);
>>  
>>  /* Promote the vendor interface instead of the generic video module.
>>   * This function allow DMI blacklists to be implemented by externals
>> @@ -283,6 +284,15 @@ int acpi_video_backlight_support(void)
>>  }
>>  EXPORT_SYMBOL(acpi_video_backlight_support);
>>  
>> +bool acpi_video_verify_backlight_support(void)
>> +{
>> +	if (!(acpi_video_support & ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO) &&
>> +	    acpi_osi_is_win8() && backlight_device_registered(BACKLIGHT_RAW))
>> +		return false;
> 
> If I'm not mistaken, this will introduce a regression for the people who have
> problems with the native i915 backlight on Win8-compatible systems.  I'd prefer
> to avoid that at this point.
> 

OK, I see.

Then I'm afraid a new kernel command line option is needed, something
like video.use_native_backlight and set it to false by default, then
for people who need to avoid the ACPI video backlight interface, they
can add video.use_native_backlight=true to kernel cmdline.

One thing I need to mention is, with the new cmdline option, users will
need to manually add a kernel cmdline option to make backlight work on
their systems, while they can already make backlight work by modifying
xorg.conf to specify using intel_backlight interface, so it doesn't seem
this patchset will be very useful then...

Thanks,
Aaron

>> +	return acpi_video_backlight_support();
>> +}
>> +EXPORT_SYMBOL(acpi_video_verify_backlight_support);
>> +
>>  /*
>>   * Use acpi_backlight=vendor/video to force that backlight switching
>>   * is processed by vendor specific acpi drivers or video.ko driver.
> 
> Thanks!
> 
