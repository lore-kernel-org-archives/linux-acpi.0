From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] acpi-video: Fix use_native_backlight selection logic
Date: Tue, 02 Sep 2014 23:53:23 +0200
Message-ID: <1721646.BP8PghqHXN@vostro.rjw.lan>
References: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56262 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751502AbaIBVeF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 17:34:05 -0400
In-Reply-To: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Andre =?ISO-8859-1?Q?M=FCller?= <andre.muller@web.de>, Hohahiu <rakothedin@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org.#.3.16

On Thursday, August 28, 2014 10:20:45 AM Hans de Goede wrote:
> Commit 751109aad583 ("ACPI / video: Change the default for
> video.use_native_backlight to 1") has changed the default for
> use_native_backlight from 0 to 1, but instead of changing
> use_native_backlight_dmi to true, and leaving use_native_backlight_param at -1,
> it has changed use_native_backlight_param to 1.
> 
> This causes acpi_video_use_native_backlight() to always think that a value was
> specified through the param, making it impossible to add a dmi based quirk
> to force 0 now that the default is 1.
> 
> This fixes this by restoring the use_native_backlight_param default to -1, and
> instead setting the use_native_backlight_dmi default to true.
> 
> Cc: stable@vger.kernel.org # 3.16
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patches [1-3/4] queued up for 3.17-rc4.  I'll queue up the last one for 3.18
later.

Thanks!

> ---
>  drivers/acpi/video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 8268843..58bcf7a 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -82,9 +82,9 @@ module_param(allow_duplicates, bool, 0644);
>   * For Windows 8 systems: used to decide if video module
>   * should skip registering backlight interface of its own.
>   */
> -static int use_native_backlight_param = 1;
> +static int use_native_backlight_param = -1;
>  module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
> -static bool use_native_backlight_dmi = false;
> +static bool use_native_backlight_dmi = true;
>  
>  static int register_count;
>  static struct mutex video_list_lock;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
