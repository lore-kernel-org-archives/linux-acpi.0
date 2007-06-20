From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/12] acpi: fix compile error with ACPI && !ACPI_SYSTEM
Date: Tue, 19 Jun 2007 23:36:01 -0400
Message-ID: <200706192336.02078.lenb@kernel.org>
References: <20070619224958.GG5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36513 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130AbXFTDgL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 23:36:11 -0400
In-Reply-To: <20070619224958.GG5193@alberich.amd.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Herrmann <andreas.herrmann3@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 19 June 2007 18:49, Andreas Herrmann wrote:
> Fix build error if ACPI && !ACPI_SYSTEM as
> bus.c depended on event.c

How were you able to get ACPI & !ACPI_SYSTEM to survive "make oldconfig"?

-Len

> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/acpi/bus.c   |    2 +-
>  drivers/acpi/event.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index e5084ec..b4a9ea5 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -281,7 +281,7 @@ static DEFINE_SPINLOCK(acpi_bus_event_lock);
>  LIST_HEAD(acpi_bus_event_list);
>  DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
>  
> -extern int event_is_open;
> +int event_is_open = 0;
>  
>  int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
>  {
> diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
> index 3b23562..15886c1 100644
> --- a/drivers/acpi/event.c
> +++ b/drivers/acpi/event.c
> @@ -17,7 +17,7 @@ ACPI_MODULE_NAME("event");
>  
>  /* Global vars for handling event proc entry */
>  static DEFINE_SPINLOCK(acpi_system_event_lock);
> -int event_is_open = 0;
> +extern int event_is_open;
>  extern struct list_head acpi_bus_event_list;
>  extern wait_queue_head_t acpi_bus_event_queue;
>  
