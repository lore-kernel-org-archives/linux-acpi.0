From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: event: fix acpi_bus_generate_netlink_event call
Date: Mon, 3 Sep 2007 16:59:23 -0400
Message-ID: <200709031659.23663.lenb@kernel.org>
References: <11887886153952-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44234 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbXICUzg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Sep 2007 16:55:36 -0400
In-Reply-To: <11887886153952-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Wow, do you really build with CONFIG_NET=n,
or did randconfig find this?

-Len

On Sunday 02 September 2007 23:03, Henrique de Moraes Holschuh wrote:
> Fix for:
> drivers/acpi/event.c:243: error: 'acpi_generate_netlink_event' undeclared
> here (not in a function)
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  drivers/acpi/event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
> index a2b9304..5c95863 100644
> --- a/drivers/acpi/event.c
> +++ b/drivers/acpi/event.c
> @@ -240,7 +240,7 @@ int acpi_bus_generate_netlink_event(const char *device_class,
>  	return 0;
>  }
>  
> -EXPORT_SYMBOL(acpi_generate_netlink_event);
> +EXPORT_SYMBOL(acpi_bus_generate_netlink_event);
>  
>  static int acpi_event_genetlink_init(void)
>  {
