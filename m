From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: video: Add a quirk to force native backlight on Lenovo IdeaPad S405
Date: Wed, 28 Oct 2015 04:16:35 +0100
Message-ID: <1610867.3KmRdKRgYl@vostro.rjw.lan>
References: <1445427903-3799-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1445427903-3799-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, October 21, 2015 01:45:03 PM Hans de Goede wrote:
> The Lenovo IdeaPad S405 is a not "Windows8 ready" machine which still has
> a broken ACPI video backlight implementation. Add a quirk to force use
> of native backlight on this machine.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1201530
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 2922f1f..0d3a384 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -244,6 +244,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  
>  	/* Non win8 machines which need native backlight nevertheless */
>  	{
> +	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1201530 */
> +	 .callback = video_detect_force_native,
> +	 .ident = "Lenovo Ideapad S405",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
> +		},
> +	},
> +	{
>  	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
>  	 .callback = video_detect_force_native,
>  	 .ident = "Lenovo Ideapad Z570",

Applied, thanks!

Rafael
