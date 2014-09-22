From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: disable native backlight for ThinkPad X201s
Date: Mon, 22 Sep 2014 16:02:43 +0200
Message-ID: <1907787.WmIEonuPRb@vostro.rjw.lan>
References: <541B8E6E.4050703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53594 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753486AbaIVNm5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2014 09:42:57 -0400
In-Reply-To: <541B8E6E.4050703@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Yves-Alexis Perez <corsac@debian.org>, Hans de Goede <hdegoede@redhat.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Friday, September 19, 2014 10:01:18 AM Aaron Lu wrote:
> The ThinkPad X201s has a working ACPI video backlight interface and is
> shipped before Win8; then there is BIOS update that starts to query
> _OSI("Windows 2012") and that would make our video module stop creating
> backlight interface and caused problem for the user. Add it to the DMI
> table to disable native backlight to fix this problem.
> 
> LINK: https://bugzilla.kernel.org/show_bug.cgi?id=81691
> LINK: https://bugzilla.kernel.org/show_bug.cgi?id=51231
> Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
> Reported-and-tested-by: Yves-Alexis Perez <corsac@debian.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Queued up for 3.17-rc7, thanks!

> ---
>  drivers/acpi/video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index fcbda105616e..8e7e18567ae6 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -750,6 +750,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T520"),
>  		},
>  	},
> +	{
> +	 .callback = video_disable_native_backlight,
> +	 .ident = "ThinkPad X201s",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
> +		},
> +	},
>  
>  	/* The native backlight controls do not work on some older machines */
>  	{
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
