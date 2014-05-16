From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Revert native brightness quirk for ThinkPad T530
Date: Fri, 16 May 2014 22:50:10 +0200
Message-ID: <13216709.cQDcpMa84k@vostro.rjw.lan>
References: <1400267441-6267-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1400267441-6267-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, May 16, 2014 09:10:41 PM Hans de Goede wrote:
> Seems it helps some users, but causes issues for other users:
> https://bugzilla.redhat.com/show_bug.cgi?id=1089545
> 
> So lets drop it for now until we've figured out a better fix.

So you hadn't even waited for all of your users to have a chance to test the
blacklist patch and you asked me to push it for -rc5 nevertheless.  You don't
even realize how disappointing that is.

I had to rebase this patch, so it has to go through autobuild testing and
I'll try to add it to my -rc6 pull request, but I'm not going to take any new
blacklist entries for anything later than -rc4 in the future.  And don't even
*try* to argue with that.

> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 0fec70d..8309100 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -516,14 +516,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  	},
>  	{
>  	 .callback = video_set_use_native_backlight,
> -	 .ident = "ThinkPad T530",
> -	 .matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T530"),
> -		},
> -	},
> -	{
> -	 .callback = video_set_use_native_backlight,
>  	 .ident = "ThinkPad W530",
>  	 .matches = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
