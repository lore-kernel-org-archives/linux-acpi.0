From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / scan: fix typo in comments of acpi_bus_unregister_driver()
Date: Wed, 25 Sep 2013 19:55:57 +0200
Message-ID: <3621238.5j3SrFSkYt@vostro.rjw.lan>
References: <1379835761-31529-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59182 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab3IYRoe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Sep 2013 13:44:34 -0400
In-Reply-To: <1379835761-31529-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On Sunday, September 22, 2013 03:42:41 PM Hanjun Guo wrote:
> "APIC" should be "ACPI" here.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Queued up for 3.12, thanks!

> ---
>  drivers/acpi/scan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fbdb82e..611ce90 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1121,7 +1121,7 @@ int acpi_bus_register_driver(struct acpi_driver *driver)
>  EXPORT_SYMBOL(acpi_bus_register_driver);
>  
>  /**
> - * acpi_bus_unregister_driver - unregisters a driver with the APIC bus
> + * acpi_bus_unregister_driver - unregisters a driver with the ACPI bus
>   * @driver: driver to unregister
>   *
>   * Unregisters a driver with the ACPI bus.  Searches the namespace for all
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
