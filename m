From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] fixup! ACPI / utils: Add acpi_dev_present()
Date: Tue, 05 Jan 2016 13:59:30 +0100
Message-ID: <2561271.6hqXF65xDQ@vostro.rjw.lan>
References: <cover.1451671935.git.lukas@wunner.de> <8e8f8983abe74c4cd43d95a444016fac0e5f822d.1451671935.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49939 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751590AbcAEM2u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2016 07:28:50 -0500
In-Reply-To: <8e8f8983abe74c4cd43d95a444016fac0e5f822d.1451671935.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Friday, January 01, 2016 10:52:15 PM Lukas Wunner wrote:
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied, with modified subject/changelog.

> ---
>  drivers/acpi/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 60bda0d..1e6833a 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -88,7 +88,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
>  
>  extern struct list_head acpi_bus_id_list;
>  
> -struct acpi_device_bus_id{
> +struct acpi_device_bus_id {
>  	char bus_id[15];
>  	unsigned int instance_no;
>  	struct list_head node;

Thanks,
Rafael

