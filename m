From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 3/8] ACPI: video - remove unsafe uses of list_for_each_safe()
Date: Wed, 14 Nov 2007 12:46:12 -0500
Message-ID: <200711141246.12928.lenb@kernel.org>
References: <20071105164328.982283020@anvil.corenet.prv> <20071105165011.953107289@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35209 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348AbXKNRq0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 12:46:26 -0500
In-Reply-To: <20071105165011.953107289@anvil.corenet.prv>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Monday 05 November 2007 11:43, Dmitry Torokhov wrote:
> ACPI: video - remove unsafe uses of list_for_each_safe()
> 
> list_for_each_safe() only protects list from list alterations
> performed by the same thread. One still needs to implement
> proper locking when list is being accessed from several threads.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/acpi/video.c |   71 ++++++++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
> 
> Index: work/drivers/acpi/video.c
> ===================================================================
> --- work.orig/drivers/acpi/video.c
> +++ work/drivers/acpi/video.c
> @@ -1462,12 +1462,14 @@ acpi_video_bus_get_one_device(struct acp
>  
>  static void acpi_video_device_rebind(struct acpi_video_bus *video)
>  {
> -	struct list_head *node, *next;
> -	list_for_each_safe(node, next, &video->video_device_list) {

yeah, these were mis-used -- they're just for the case
where we delete the node inside the loop and don't
want to test the node->next.

applied.
thanks,
-Len
