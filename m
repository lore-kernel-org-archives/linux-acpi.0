From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [patch] ACPI video driver output switch sysfs support
Date: Mon, 12 Mar 2007 22:37:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0703122231580.22327@shark.he.net>
References: <3877989d0703122231v7bb04f03ydf4c1de03040085f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:56192 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753030AbXCMFh0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Mar 2007 01:37:26 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-acpi@vger.kernel.org>; Mon, 12 Mar 2007 22:37:23 -0700
In-Reply-To: <3877989d0703122231v7bb04f03ydf4c1de03040085f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, 13 Mar 2007, Luming Yu wrote:

> Add output switch sysfs class support for ACPI video driver.
>
>  drivers/acpi/Kconfig     |    2 +-
>  drivers/acpi/video.c     |   38 ++++++++++++++++++++++++++++++++++++++
>  drivers/video/Kconfig    |    7 +++++++
>  drivers/video/Makefile   |    3 +++
>  include/acpi/processor.h |    0
>  5 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 00d25b3..3456603 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -297,6 +299,28 @@ static struct backlight_ops acpi_backlig
>         .update_status  = acpi_video_set_brightness,
>  };
>
> +/*video output device sysfs support*/
> +static int acpi_video_output_get(struct output_device *od)
> +{
> +       unsigned long state;
> +       struct acpi_video_device *vd =
> +               (struct acpi_video_device *)class_get_devdata(&od->class_dev);
> +       acpi_video_device_get_state(vd,&state);

Please add a space after comma.

> +       return (int)state;
> +}
> +
> +static int acpi_video_output_set(struct output_device *od)
> +{
> +       unsigned long state = od->request_state;
> +       struct acpi_video_device *vd=
> +               (struct acpi_video_device *)class_get_devdata(&od->class_dev);
> +       return acpi_video_device_set_state(vd,state);

ditto

> +}
> +
> +static struct output_properties acpi_output_properties = {
> +       .set_state = acpi_video_output_set,
> +       .get_status = acpi_video_output_get,
> +};
>  /* --------------------------------------------------------------------------
>                                 Video Management
>     --------------------------------------------------------------------------
> */
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 7f5a598..bd76a6c 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -6,6 +6,13 @@ menu "Graphics support"
>
>  source "drivers/video/backlight/Kconfig"
>
> +config VIDEO_OUTPUT_CONTROL
> +        tristate "Lowlevel video output switch controls"
> +       default m
> +       help
> +         This framework adds support for low-level control of the video
> +          output switch.
> +

:(

Please use a tab to indent the tristate, default, and help lines.
Then indent the help text with one tab + 2 spaces.


>  config FB
>         tristate "Support for frame buffer devices"
>         ---help---

-- 
~Randy
