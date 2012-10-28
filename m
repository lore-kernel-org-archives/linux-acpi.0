From: Lekensteyn <lekensteyn@gmail.com>
Subject: Re: [PATCH] acpi: compare of array
Date: Sun, 28 Oct 2012 16:44:28 +0100
Message-ID: <1465966.Qjvnc1PAsU@al>
References: <20121025145746.17558.59853.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34257 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2J1Poc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Oct 2012 11:44:32 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2062782wey.19
        for <linux-acpi@vger.kernel.org>; Sun, 28 Oct 2012 08:44:30 -0700 (PDT)
In-Reply-To: <20121025145746.17558.59853.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lenb@linux.intel.com, linux-acpi@vger.kernel.org

On Thursday 25 October 2012 15:57:50 Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> This serves no purpose as it's an array not a pointer
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/acpi/event.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
> index 1442737..f84df83 100644
> --- a/drivers/acpi/event.c
> +++ b/drivers/acpi/event.c
> @@ -67,8 +67,7 @@ acpi_system_read_event(struct file *file, char __user *
> buffer, size_t count, return result;
> 
>  		chars_remaining = sprintf(str, "%s %s %08x %08x\n",
> -					  event.device_class ? event.
> -					  device_class : "<unknown>",
> +					  event.device_class : "<unknown>",
: "<unknown>" should be removed too to avoid a compile error. If it is an 
array, is it not better to check event.device_class[0] != 0 (an empty string)?

>  					  event.bus_id ? event.
>  					  bus_id : "<unknown>", event.type,
>  					  event.data);

Regards,
Peter
