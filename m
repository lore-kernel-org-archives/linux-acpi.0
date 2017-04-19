From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi: video: get rid of magic numbers and use enum instead
Date: Wed, 19 Apr 2017 02:42:18 +0200
Message-ID: <CAJZ5v0jRJhhZehYFzb6LtaheGsgXUb6OCZvoCHraFgwx2M_GVQ@mail.gmail.com>
References: <20170418123558.12436-1-mail@dmitryfrank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35689 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758581AbdDSAmT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2017 20:42:19 -0400
Received: by mail-oi0-f67.google.com with SMTP id g11so1788345oib.2
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2017 17:42:19 -0700 (PDT)
In-Reply-To: <20170418123558.12436-1-mail@dmitryfrank.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Frank <mail@dmitryfrank.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

On Tue, Apr 18, 2017 at 2:35 PM, Dmitry Frank <mail@dmitryfrank.com> wrote:
> The first two items in the _BCL method response are special:
>
>   - Level when machine has full power
>   - Level when machine is on batteries
>   - .... actual supported levels go there ....
>
> So this commits adds an enum and uses its descriptive elements
> throughout the code, instead of magic numbers.
>
> Some subtle cases are commented additionally (the comment for
> acpi_video_bqc_quirk is by Felipe Contreras, CCed)

So that should be a separate patch.  Please split.

>
> Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>
> ---
>  drivers/acpi/acpi_video.c | 134 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 89 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index d00bc0ef87a6..856694e5f325 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -88,6 +88,18 @@ static int acpi_video_bus_remove(struct acpi_device *device);
>  static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
>  void acpi_video_detect_exit(void);
>
> +/*
> + * Indices in the _BCL method response: the first two items are special,
> + * the rest are all supported levels.
> + *
> + * See page 575 of the ACPI spec 3.0
> + */
> +enum lvl_idx {
> +       LVL_IDX_AC,             /* level when machine has full power */
> +       LVL_IDX_BATTERY,        /* level when machine is on batteries */
> +       LVL_IDX_FIRST,          /* actual supported levels begin here */

What about using different symbol names, like ACPI_VIDEO_AC_LEVEL,
ACPI_VIDEO_BATTERY_LEVEL and ACPI_VIDEO_FIRST_LEVEL, respectively?

> +};
> +
>  static const struct acpi_device_id video_device_ids[] = {
>         {ACPI_VIDEO_HID, 0},
>         {"", 0},
> @@ -132,7 +144,7 @@ struct acpi_video_device_attrib {
>                                    the VGA device. */
>         u32 pipe_id:3;          /* For VGA multiple-head devices. */
>         u32 reserved:10;        /* Must be 0 */
> -       u32 device_id_scheme:1; /* Device ID Scheme */
> +       u32 device_id_scheme:1; /* Whether the device ID follows this scheme above */

That still is not particularly clear (although admittedly it is better
than what we have).

Thanks,
Rafael
