From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: remove unneeded NULL pointer check
Date: Wed, 06 Nov 2013 23:07:10 +0100
Message-ID: <6456734.LxpVCEaamO@vostro.rjw.lan>
References: <1383683132-28851-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64011 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756370Ab3KFVyu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2013 16:54:50 -0500
In-Reply-To: <1383683132-28851-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathias Krause <minipli@googlemail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Tuesday, November 05, 2013 09:25:32 PM Mathias Krause wrote:
> nla_data() cannot return NULL as it simply adds NLA_HDRLEN to the passed
> pointer. The NULL pointer check is therefore superfluous. Remove it.
> 
> Found by smatch:
>   drivers/acpi/event.c:130 acpi_bus_generate_netlink_event() warn: can
>   'event' even be NULL?
> 
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks!

> ---
>  drivers/acpi/event.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
> index 8247fcd..fdef416 100644
> --- a/drivers/acpi/event.c
> +++ b/drivers/acpi/event.c
> @@ -127,11 +127,6 @@ int acpi_bus_generate_netlink_event(const char *device_class,
>  	}
>  
>  	event = nla_data(attr);
> -	if (!event) {
> -		nlmsg_free(skb);
> -		return -EINVAL;
> -	}
> -
>  	memset(event, 0, sizeof(struct acpi_genl_event));
>  
>  	strcpy(event->device_class, device_class);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
