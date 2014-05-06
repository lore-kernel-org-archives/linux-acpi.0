From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 3/3] acpi-video: change acpi-video brightness_switch_enabled
 default to 0
Date: Tue, 06 May 2014 10:01:04 +0800
Message-ID: <53684260.1050806@intel.com>
References: <1399282690-5381-1-git-send-email-hdegoede@redhat.com> <1399282690-5381-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44872 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933564AbaEFCAP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 May 2014 22:00:15 -0400
In-Reply-To: <1399282690-5381-3-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: edm <fuffi.il.fuffo@gmail.com>, Balint Szigeti <balint.szgt@gmail.com>, AnAkkk <anakin.cs@gmail.com>, lou.cardone@gmail.com, linux-acpi@vger.kernel.org

On 05/05/2014 05:38 PM, Hans de Goede wrote:
> acpi-video is unique in that it not only generates brightness up/down
> keypresses, but also (sometimes) actively changes the brightness itself.
> 
> This presents an inconsistent kernel interface to userspace, basically there
> are 2 different scenarios, depending on the laptop model:
> 
> 1) On some laptops a brightness up/down keypress means: show a brightness osd
> with the current brightness, iow it is a brightness has changed notification.
> 
> 2) Where as on (a lot of) other laptops it means a brightness up/down key was
> pressed, deal with it.
> 
> Most of the desktop environments interpret any press as in scenario 2, and
> change the brightness up / down as a response to the key events, causing it
> to be changed twice, once by acpi-video and once by the DE.
> 
> With the new default for video.use_native_backlight we will be moving even
> more laptops over to behaving as in scenario 2. Making the remaining laptops
> even more of a weird exception. Also note that it is hard to detect scenario
> 1 properly in userspace, and AFAIK none of the DE-s deals with it.
> 
> Therefor this commit changes the default of brightness_switch_enabled to 0
> making its behavior consistent with all the other backlight drivers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Note that the Documentation/kernel-parameters.txt has to be modified
accordingly to change the default value for video.brightness_switch_enabled
to 0.

Thanks,
Aaron

> ---
>  drivers/acpi/video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index cebc74d..34198b2 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -68,7 +68,7 @@ MODULE_AUTHOR("Bruno Ducrot");
>  MODULE_DESCRIPTION("ACPI Video Driver");
>  MODULE_LICENSE("GPL");
>  
> -static bool brightness_switch_enabled = 1;
> +static bool brightness_switch_enabled;
>  module_param(brightness_switch_enabled, bool, 0644);
>  
>  /*
> 

