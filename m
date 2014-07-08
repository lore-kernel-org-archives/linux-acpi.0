From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: Add Dell Inspiron 5737 to the blacklist
Date: Tue, 08 Jul 2014 15:31:50 +0200
Message-ID: <2906150.1kKPlLELmj@vostro.rjw.lan>
References: <CAFquV7W-aDs=1R=aYOFzWw8rYiqiVNpQ-8T_wWHwvdh-u_wHWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59291 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754254AbaGHNNp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jul 2014 09:13:45 -0400
In-Reply-To: <CAFquV7W-aDs=1R=aYOFzWw8rYiqiVNpQ-8T_wWHwvdh-u_wHWA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yidi Lin <yidi.lin@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, July 08, 2014 10:14:59 AM Yidi Lin wrote:
> With win8 capability, the ACPI backlight control is broken on this model.
> The system also loses backlight setting when resuming from S3.
> 
> Add this model to the the ACPI video detect blacklist to make backlight
> functionality work.
> 
> Although backlight functionality works via video.use_native_backlight=1,
> this approach may be safer.
> 
> Signed-off-by: Edward Lin <yidi.lin@canonical.com>

I've applied this patch already it seems, haven't I?

> ---
>  drivers/acpi/video_detect.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 33e3db5..c42feb2 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -166,6 +166,14 @@ static struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
>                 },
>         },
> +       {
> +       .callback = video_detect_force_vendor,
> +       .ident = "Dell Inspiron 5737",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
> +               },
> +       },
>         { },
>  };
> 
> --
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
