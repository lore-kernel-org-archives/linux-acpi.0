From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH update] acpi: video: Allow forcing native backlight on
 non win8, machines
Date: Wed, 11 Mar 2015 12:14:41 +0100
Message-ID: <550023A1.3060606@redhat.com>
References: <1425368350-4028-1-git-send-email-hdegoede@redhat.com> <3175131.PO6aPjpaNK@vostro.rjw.lan> <54FF734D.5070107@redhat.com> <1592515.vScOiuKqBv@vostro.rjw.lan> <54FFDD60.80408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60819 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbbCKLOr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Mar 2015 07:14:47 -0400
In-Reply-To: <54FFDD60.80408@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Hi,

On 11-03-15 07:14, Aaron Lu wrote:
> On 03/11/2015 07:10 AM, Rafael J. Wysocki wrote:
>> On Tuesday, March 10, 2015 11:42:21 PM Hans de Goede wrote:
>>> So you want to have a native_backlight enum or some such ? with -1 being not_set ?
>>
>> Yes, something like that.
>
> OK, here is an updated one:

Looks good to me, my ack still stands. I need to send a bunch of
mails back / forth to tackle the issue the ideapad which caused me to
work on this in the first case. So lets merge this one first, and
then I'll get back with a patch on top of this when I know how to
actually best deal with the problem on that machine.

Regards,

Hans


>
>  From db4eb1928219e47fcfbffb913f08b1e1b432c28a Mon Sep 17 00:00:00 2001
> From: Aaron Lu <aaron.lu@intel.com>
> Date: Wed, 4 Mar 2015 10:24:58 +0800
> Subject: [PATCH] acpi: video: Allow forcing native backlight on non win8
>   machines
>
> The native backlight behavior (so not registering both the acpi-video
> and the vendor backlight driver) can be useful on some non win8 machines
> too, so change the behavior of the video.use_native_backlight=1 or 0
> kernel cmdline option to be: if user has set video.use_native_backlight=1
> or 0, use that no matter if it is a win8 system or not. Also, we will
> put some known systems into the DMI table to make them either use native
> backlight interface or not, and the use_native_backlight_dmi is used to
> reflect that.
>
> Original-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/acpi/video.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 26eb70c8f518..2f45dca31724 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -82,9 +82,15 @@ module_param(allow_duplicates, bool, 0644);
>    * For Windows 8 systems: used to decide if video module
>    * should skip registering backlight interface of its own.
>    */
> -static int use_native_backlight_param = -1;
> +enum {
> +	NATIVE_BACKLIGHT_NOT_SET = -1,
> +	NATIVE_BACKLIGHT_OFF,
> +	NATIVE_BACKLIGHT_ON,
> +};
> +
> +static int use_native_backlight_param = NATIVE_BACKLIGHT_NOT_SET;
>   module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
> -static bool use_native_backlight_dmi = true;
> +static int use_native_backlight_dmi = NATIVE_BACKLIGHT_NOT_SET;
>
>   static int register_count;
>   static struct mutex video_list_lock;
> @@ -237,15 +243,16 @@ static void acpi_video_switch_brightness(struct work_struct *work);
>
>   static bool acpi_video_use_native_backlight(void)
>   {
> -	if (use_native_backlight_param != -1)
> +	if (use_native_backlight_param != NATIVE_BACKLIGHT_NOT_SET)
>   		return use_native_backlight_param;
> -	else
> +	else if (use_native_backlight_dmi != NATIVE_BACKLIGHT_NOT_SET)
>   		return use_native_backlight_dmi;
> +	return acpi_osi_is_win8();
>   }
>
>   bool acpi_video_verify_backlight_support(void)
>   {
> -	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
> +	if (acpi_video_use_native_backlight() &&
>   	    backlight_device_registered(BACKLIGHT_RAW))
>   		return false;
>   	return acpi_video_backlight_support();
> @@ -414,7 +421,7 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
>
>   static int __init video_disable_native_backlight(const struct dmi_system_id *d)
>   {
> -	use_native_backlight_dmi = false;
> +	use_native_backlight_dmi = NATIVE_BACKLIGHT_OFF;
>   	return 0;
>   }
>
>
