From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 1/8] ACPI: video - fit input device into sysfs tree
Date: Wed, 14 Nov 2007 15:17:47 +0800
Message-ID: <1195024667.1262.42.camel@acpi-hp.sh.intel.com>
References: <20071105164328.982283020@anvil.corenet.prv>
	 <20071105165011.688931555@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26413 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755835AbXKNHH7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 02:07:59 -0500
In-Reply-To: <20071105165011.688931555@anvil.corenet.prv>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> ACPI: video - fit input device into sysfs tree
> 
> Properly set up parent on input device registered by the video driver.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: work/drivers/acpi/video.c
> ===================================================================
> --- work.orig/drivers/acpi/video.c
> +++ work/drivers/acpi/video.c
> @@ -1961,6 +1961,7 @@ static int acpi_video_bus_add(struct acp
>         input->phys = video->phys;
>         input->id.bustype = BUS_HOST;
>         input->id.product = 0x06;
> +       input->dev.parent = &device->dev;
>         input->evbit[0] = BIT(EV_KEY);
>         set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
>         set_bit(KEY_VIDEO_NEXT, input->keybit);
> @@ -1990,7 +1991,7 @@ static int acpi_video_bus_add(struct acp
>                video->flags.rom ? "yes" : "no",
>                video->flags.post ? "yes" : "no");
> 
> -      end:
> + end:
>         if (result)
>                 kfree(video);
> 
> 
> --
> Dmitry
> 
> 
