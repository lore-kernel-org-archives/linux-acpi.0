From: Yidi Lin <yidi.lin@canonical.com>
Subject: Re: [PATCH v2] acpi: mv models with win8 brightness problems from
 win8 blacklist to use_native_backlight
Date: Thu, 10 Jul 2014 21:40:10 +0800
Message-ID: <CAFquV7W4Uw=CBqbosVDbvkKKtd=A9Cv3YRgAwPvQrMXYKQnwkA@mail.gmail.com>
References: <1402912525-9067-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:44425 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbaGJNkL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2014 09:40:11 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so10441722vcb.23
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2014 06:40:10 -0700 (PDT)
In-Reply-To: <1402912525-9067-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi,

The quirk of Dell Inspiron 7737 is not for win8 backlight issue.

Dell Inspiron 7737 will power on immediately after shutdown with win8
capability.
Disable win8 capability to workaround the issue.

It seems that I add the quirk to the improper segment.
Sorry for misleading you.

On Mon, Jun 16, 2014 at 5:55 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> When the windows8 related backlight problems became evident, 2 approaches
> were follow in parallel, one was to stop claiming to be windows 8 / 2012,
> the other was to tell acpi_video to stop registering a backlight driver.
>
> I've read all the threads and it seems that which approach ended up being
> applied to which model laptop was never really a concious decision (AFAIK):
>
> https://bugzilla.kernel.org/show_bug.cgi?id=51231
> https://bugzilla.kernel.org/show_bug.cgi?id=60682
>
> So lets move all the models which are only on the win8 blacklist because of
> brightness issues to the use_native_backlight list, which is the smaller
> hammer to use to solve the backlight issues.
>
> Making this change is esp. attractive now that 3.16 has
> video.use_native_brightness=1 by default. If that new default does not get
> reverted because of regressions, then we can drop all the models
> with a use_native_backlight quirk, greatly reducing the number of models we've
> a quirk for.
>
> Note: this is not tested on any of the affected models, this just seems like
> the sensible thing to do.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> --
>
> Changes in v2: Rebased on top of v3.16-rc1
> ---
>  drivers/acpi/blacklist.c | 83 ------------------------------------------------
>  drivers/acpi/video.c     | 76 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 74 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 3d8413d..b08e65a 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -156,12 +156,6 @@ static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
>         acpi_osi_setup("!Windows 2009");
>         return 0;
>  }
> -static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
> -{
> -       printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
> -       acpi_osi_setup("!Windows 2012");
> -       return 0;
> -}
>
>  static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>         {
> @@ -247,83 +241,6 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>         },
>
>         /*
> -        * The following machines have broken backlight support when reporting
> -        * the Windows 2012 OSI, so disable it until their support is fixed.
> -        */
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "ASUS Zenbook Prime UX31A",
> -       .matches = {
> -                    DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -                    DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
> -               },
> -       },
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "ThinkPad Edge E530",
> -       .matches = {
> -                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                    DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
> -               },
> -       },
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "ThinkPad Edge E530",
> -       .matches = {
> -                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                    DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
> -               },
> -       },
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "ThinkPad Edge E530",
> -       .matches = {
> -                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                    DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
> -               },
> -       },
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "Acer Aspire V5-573G",
> -       .matches = {
> -                    DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
> -                    DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
> -               },
> -       },
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "Acer Aspire V5-572G",
> -       .matches = {
> -                    DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
> -                    DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
> -               },
> -       },
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "ThinkPad T431s",
> -       .matches = {
> -                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                    DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
> -               },
> -       },
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "ThinkPad T430",
> -       .matches = {
> -                    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                    DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
> -               },
> -       },
> -       {
> -       .callback = dmi_disable_osi_win8,
> -       .ident = "Dell Inspiron 7737",
> -       .matches = {
> -                   DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -                   DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7737"),
> -               },
> -       },
> -
> -       /*
>          * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>          * Linux ignores it, except for the machines enumerated below.
>          */
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index fb9ffe9..deb1b1f 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -460,6 +460,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>         },
>         {
>          .callback = video_set_use_native_backlight,
> +        .ident = "ThinkPad X230",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
> +               },
> +       },
> +       {
> +        .callback = video_set_use_native_backlight,
>          .ident = "ThinkPad T430 and T430s",
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> @@ -468,10 +476,42 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>         },
>         {
>          .callback = video_set_use_native_backlight,
> -        .ident = "ThinkPad X230",
> +        .ident = "ThinkPad T430",
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -               DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
> +               },
> +       },
> +       {
> +        .callback = video_set_use_native_backlight,
> +        .ident = "ThinkPad T431s",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
> +               },
> +       },
> +       {
> +        .callback = video_set_use_native_backlight,
> +        .ident = "ThinkPad Edge E530",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
> +               },
> +       },
> +       {
> +        .callback = video_set_use_native_backlight,
> +        .ident = "ThinkPad Edge E530",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
> +               },
> +       },
> +       {
> +        .callback = video_set_use_native_backlight,
> +        .ident = "ThinkPad Edge E530",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
>                 },
>         },
>         {
> @@ -524,6 +564,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>         },
>         {
>          .callback = video_set_use_native_backlight,
> +        .ident = "Dell Inspiron 7737",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7737"),
> +               },
> +       },
> +       {
> +        .callback = video_set_use_native_backlight,
>          .ident = "Acer Aspire 5733Z",
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> @@ -563,6 +611,30 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>                 },
>         },
>         {
> +        .callback = video_set_use_native_backlight,
> +        .ident = "Acer Aspire V5-572G",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
> +               },
> +       },
> +       {
> +        .callback = video_set_use_native_backlight,
> +        .ident = "Acer Aspire V5-573G",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
> +               },
> +       },
> +       {
> +        .callback = video_set_use_native_backlight,
> +        .ident = "ASUS Zenbook Prime UX31A",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
> +               },
> +       },
> +       {
>         .callback = video_set_use_native_backlight,
>         .ident = "HP ProBook 4340s",
>         .matches = {
> --
> 2.0.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
