From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Add disable_native_backlight quirk for Samsung
 730U3E/740U3E
Date: Fri, 09 Jan 2015 16:18:54 +0100
Message-ID: <54AFF15E.7080900@redhat.com>
References: <1420816381-12394-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53011 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757779AbbAIPS7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Jan 2015 10:18:59 -0500
In-Reply-To: <1420816381-12394-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

Hi,

On 09-01-15 16:13, Hans de Goede wrote:
> The Samsung 730U3E/740U3E has integrated ATI Radeon graphics, and backlight
> control does not work properly when using the native interfaces.
>
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1094948
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Self-NAK, this one is no good, sorry, v2 coming up.

Regards,

Hans

> ---
>   drivers/acpi/video.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 032db45..e641268 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -522,6 +522,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>   		DMI_MATCH(DMI_PRODUCT_NAME, "370R4E/370R4V/370R5E/3570RE/370R5V"),
>   		},
>   	},
> +	{
> +	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
> +	 .callback = video_disable_native_backlight,
> +	 .ident = "SAMSUNG 730U3E/740U3E"
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
> +		},
> +	},
>
>   	{
>   	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
>
