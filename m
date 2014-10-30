From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: Run _BCL before deciding registering backlight
Date: Thu, 30 Oct 2014 01:49:41 +0100
Message-ID: <4975279.47tceWMptB@vostro.rjw.lan>
References: <544F394F.9060005@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55077 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757426AbaJ3A3E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2014 20:29:04 -0400
In-Reply-To: <544F394F.9060005@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Ralf Jung <post+kernel@ralfj.de>

On Tuesday, October 28, 2014 02:35:59 PM Aaron Lu wrote:
> The ASUS K53SM's ACPI table queries _OSI("Windows 2012") in the video
> output device's _BCL and _BCM control method instead of the usual _INI
> functions of the _SB or PCI host bridge PCI0 devices. This made our
> video module thought this is a pre-Win8 system when deciding if we
> should register a backlight interface for it and the end result is that
> a non-working acpi_video interface is registered and user is unable to
> control backlight from GUI. Solve this problem by evaluating _BCL control
> method before doing the decision.
> 
> Note that for some Thinkpad systems, the _BCL is also required to be
> evaluated for the hotkey event to be generated no matter if we will
> register an ACPI video backlight interface for it or not. Since the
> thinkpad_acpi module will do this anyway we didn't add such a thing in
> the video module previously. But now with this change here, the
> thinkpad_acpi module is no more necessary for those systems regarding
> backlight functionality.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=85051
> Reported-and-tested-by: Ralf Jung <post+kernel@ralfj.de>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Yes, that looks like something we need to do, but I'd be very cautious about
pushing that for 3.18 at this stage of the cycle.

So, I'm going to queue it up for 3.19.

> ---
>  drivers/acpi/video.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 807a88a0f394..41e6b977ceb2 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -1680,6 +1680,19 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>  		printk(KERN_ERR PREFIX "Create sysfs link\n");
>  }
>  
> +static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
> +{
> +	struct acpi_video_device *dev;
> +	union acpi_object *levels;
> +
> +	mutex_lock(&video->device_list_lock);
> +	list_for_each_entry(dev, &video->video_device_list, entry) {
> +		if (!acpi_video_device_lcd_query_levels(dev, &levels))
> +			kfree(levels);
> +	}
> +	mutex_unlock(&video->device_list_lock);
> +}
> +
>  static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
>  {
>  	struct acpi_video_device *dev;
> @@ -1687,6 +1700,8 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
>  	if (video->backlight_registered)
>  		return 0;
>  
> +	acpi_video_run_bcl_for_osi(video);
> +
>  	if (!acpi_video_verify_backlight_support())
>  		return 0;
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
