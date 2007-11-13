From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch] remove debug info in acpi video
Date: Tue, 13 Nov 2007 10:36:50 +0800
Message-ID: <1194921410.2969.1.camel@localhost.localdomain>
References: <20071113005047.GA27837@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5368 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484AbXKMC1I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Nov 2007 21:27:08 -0500
In-Reply-To: <20071113005047.GA27837@zhen-devel.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhenyu Wang <zhenyu.z.wang@intel.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 2007-11-13 at 08:50 +0800, Zhenyu Wang wrote:
> 
> Remove acpi video debug message.
> 
> Signed-off-by: Zhenyu Wang <zhenyu.z.wang@intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  drivers/acpi/video.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index bac956b..9c8c8e6 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -1782,9 +1782,6 @@ static void acpi_video_bus_notify(acpi_handle
> handle, u32 event, void *data)
>         struct input_dev *input;
>         int keycode;
> 
> -
> -       printk("video bus notify\n");
> -
>         if (!video)
>                 return;
> 
> --
> 1.5.3.3
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
