From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 1/2] acpi: video: Allow forcing native backlight on
 non win8 machines
Date: Tue, 03 Mar 2015 16:26:00 +0800
Message-ID: <54F57018.7000302@intel.com>
References: <1425368350-4028-1-git-send-email-hdegoede@redhat.com> <1425368350-4028-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50801 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbbCCI1H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Mar 2015 03:27:07 -0500
In-Reply-To: <1425368350-4028-2-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On 03/03/2015 03:39 PM, Hans de Goede wrote:
> The native backlight behavior (so not registering both the acpi-video and the
> vendor backlight driver) can be useful on some non win8 machines too, allow
> the user to force this behavior by passing video.use_native_backlight=2
> on the kernel commandline.

Just bikeshedding, what about doing it this way?

In the acpi_video_use_native_backlight function:
1 If user has set a cmdline option, use that(no matter if it is a win8
  system or not);
2 If the system is in a DMI table, use that(no matter if it is a win8
  system or not);
3 return true if this is a win8 system; false otherwise.

Something like this:

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index debd30917010..4cd0c8a4fd9d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -84,7 +84,7 @@ module_param(allow_duplicates, bool, 0644);
  */
 static int use_native_backlight_param = -1;
 module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
-static bool use_native_backlight_dmi = true;
+static int use_native_backlight_dmi = -1;
 
 static int register_count;
 static struct mutex video_list_lock;
@@ -239,13 +239,14 @@ static bool acpi_video_use_native_backlight(void)
 {
 	if (use_native_backlight_param != -1)
 		return use_native_backlight_param;
-	else
+	else if (use_native_backlight_dmi != -1)
 		return use_native_backlight_dmi;
+	return acpi_osi_is_win8();
 }
 
 bool acpi_video_verify_backlight_support(void)
 {
-	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
+	if (acpi_video_use_native_backlight() &&
 	    backlight_device_registered(BACKLIGHT_RAW))
 		return false;
 	return acpi_video_backlight_support();
@@ -414,7 +415,7 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
 
 static int __init video_disable_native_backlight(const struct dmi_system_id *d)
 {
-	use_native_backlight_dmi = false;
+	use_native_backlight_dmi = 0;
 	return 0;
 }
 

Regards,
Aaron

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index debd309..9817b52 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -84,7 +84,7 @@ module_param(allow_duplicates, bool, 0644);
>   */
>  static int use_native_backlight_param = -1;
>  module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
> -static bool use_native_backlight_dmi = true;
> +static int use_native_backlight_dmi = 1;
>  
>  static int register_count;
>  static struct mutex video_list_lock;
> @@ -235,7 +235,7 @@ static int acpi_video_get_next_level(struct acpi_video_device *device,
>  				     u32 level_current, u32 event);
>  static void acpi_video_switch_brightness(struct work_struct *work);
>  
> -static bool acpi_video_use_native_backlight(void)
> +static int acpi_video_use_native_backlight(void)
>  {
>  	if (use_native_backlight_param != -1)
>  		return use_native_backlight_param;
> @@ -245,7 +245,8 @@ static bool acpi_video_use_native_backlight(void)
>  
>  bool acpi_video_verify_backlight_support(void)
>  {
> -	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
> +	if (((acpi_video_use_native_backlight() == 2) ||
> +	     (acpi_video_use_native_backlight() == 1 && acpi_osi_is_win8())) &&
>  	    backlight_device_registered(BACKLIGHT_RAW))
>  		return false;
>  	return acpi_video_backlight_support();
> @@ -414,7 +415,7 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
>  
>  static int __init video_disable_native_backlight(const struct dmi_system_id *d)
>  {
> -	use_native_backlight_dmi = false;
> +	use_native_backlight_dmi = 0;
>  	return 0;
>  }
>  
> 

