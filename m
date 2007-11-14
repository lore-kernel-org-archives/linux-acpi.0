From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 8/8] ACPI: video - fix permissions on some proc entries
Date: Wed, 14 Nov 2007 15:18:25 +0800
Message-ID: <1195024705.1262.49.camel@acpi-hp.sh.intel.com>
References: <20071105164328.982283020@anvil.corenet.prv>
	 <20071105165013.101604188@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4580 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759770AbXKNHIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 02:08:37 -0500
In-Reply-To: <20071105165013.101604188@anvil.corenet.prv>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> ACPI: video - fix permissions on some proc entries
> 
> POST and DOS are supposed to be writable but permissions
> did not allow it.
The same reason as patch 6. :)
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/acpi/video.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: work/drivers/acpi/video.c
> ===================================================================
> --- work.orig/drivers/acpi/video.c
> +++ work/drivers/acpi/video.c
> @@ -1276,7 +1276,7 @@ static int acpi_video_bus_add_fs(struct
>         entry->owner = THIS_MODULE;
> 
>         /* 'POST' [R/W] */
> -       entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
> +       entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IWUSR,
>                                   device_dir);
>         if (!entry)
>                 goto err_remove_post_info;
> @@ -1287,7 +1287,7 @@ static int acpi_video_bus_add_fs(struct
>         entry->owner = THIS_MODULE;
> 
>         /* 'DOS' [R/W] */
> -       entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
> +       entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IWUSR,
>                               device_dir);
>         if (!entry)
>                 goto err_remove_post;
> 
> --
> Dmitry
> 
> 
