From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Filter the BCL table for duplicate brightness values
Date: Fri, 14 Feb 2014 00:47:19 +0100
Message-ID: <1600811.iUa8KlxWCN@vostro.rjw.lan>
References: <1392305571-4895-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49647 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752547AbaBMXci (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Feb 2014 18:32:38 -0500
In-Reply-To: <1392305571-4895-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thursday, February 13, 2014 04:32:51 PM Hans de Goede wrote:
> Some devices have duplicate entries in there brightness levels table, ie
> on my Dell Latitude E6430 the table looks like this:
> 
> [    3.686060] acpi backlight index   0, val 80
> [    3.686095] acpi backlight index   1, val 50
> [    3.686122] acpi backlight index   2, val 5
> [    3.686147] acpi backlight index   3, val 5
> [    3.686172] acpi backlight index   4, val 5
> [    3.686197] acpi backlight index   5, val 5
> [    3.686223] acpi backlight index   6, val 5
> [    3.686248] acpi backlight index   7, val 5
> [    3.686273] acpi backlight index   8, val 6
> [    3.686332] acpi backlight index   9, val 7
> [    3.686356] acpi backlight index  10, val 8
> [    3.686380] acpi backlight index  11, val 9
> etc.
> 
> Notice that brightness values 0-5 are all mapped to 5. This means that
> if userspace writes any value between 0 and 5 to the brightness sysfs attribute
> and then reads it, it will always return 0, which is somewhat unexpected.
> 
> This is a problem for ie gnome-settings-daemon, which uses read-modify-write
> logic when the users presses the brightness up or down keys. This is done
> this way to take brightness changes from other sources into account.
> 
> On this specific laptop what happens once the brightness has been set to 0,
> is that gsd reads 0, adds 5, writes 5, and on the next brightness up key press
> again reads 0, so things get stuck at the lowest brightness setting.
> 
> Filtering out the duplicate table entries, makes any write to brightness
> read back as the written value as one would expect, fixing this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Aaron, can you please have a look at this?

> ---
>  drivers/acpi/video.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index b727d10..ea9d914 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -685,6 +685,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>  	union acpi_object *o;
>  	struct acpi_video_device_brightness *br = NULL;
>  	int result = -EINVAL;
> +	u32 value;
>  
>  	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
> @@ -715,7 +716,12 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>  			printk(KERN_ERR PREFIX "Invalid data\n");
>  			continue;
>  		}
> -		br->levels[count] = (u32) o->integer.value;
> +		value = (u32) o->integer.value;
> +		/* Skip duplicate entries */
> +		if (count > 2 && br->levels[count - 1] == value)
> +			continue;
> +
> +		br->levels[count] = value;
>  
>  		if (br->levels[count] > max_level)
>  			max_level = br->levels[count];
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
