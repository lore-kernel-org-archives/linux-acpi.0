From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI/video: mark acpi_video_get_levels inline
Date: Fri, 13 May 2016 23:59:40 +0200
Message-ID: <CAJZ5v0jAyBfe6+FjzYgwe8FKxxjzzwHk3f2GyMU_sxaMve=3CQ@mail.gmail.com>
References: <1463086839-2466302-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34302 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbcEMV7m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 May 2016 17:59:42 -0400
In-Reply-To: <1463086839-2466302-1-git-send-email-arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@linux.intel.com>, Borislav Petkov <bp@suse.de>, Aaron Lu <aaron.lu@intel.com>, Sudeep Holla <Sudeep.Holla@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, May 12, 2016 at 11:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> A recent patch added a stub function for acpi_video_get_levels when
> CONFIG_ACPI_VIDEO is disabled. However, this is marked as 'static'
> and causes a warning about an unused function whereever the header
> gets included:
>
> In file included from ../drivers/gpu/drm/radeon/radeon_acpi.c:28:0:
> include/acpi/video.h:74:12: error: 'acpi_video_get_levels' defined but not used [-Werror=unused-function]
>
> This makes the declaration 'static inline', which gets rid of the
> warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 059500940def ("ACPI/video: export acpi_video_get_levels")
> ---
>  include/acpi/video.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index a4b96c971564..70a41f742037 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -71,7 +71,7 @@ static inline bool acpi_video_handles_brightness_key_presses(void)
>  {
>         return false;
>  }
> -static int acpi_video_get_levels(struct acpi_device *device,
> +static inline int acpi_video_get_levels(struct acpi_device *device,
>                         struct acpi_video_device_brightness **dev_br)
>  {
>         return -ENODEV;

Applied, thanks!
