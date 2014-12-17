From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/EC: Fix an issue that ec_remove_handlers() is invoked unexpectedly.
Date: Wed, 17 Dec 2014 01:29:34 +0100
Message-ID: <1486012.QAaSVkhiWx@vostro.rjw.lan>
References: <1418604472-1764-1-git-send-email-lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50763 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750811AbaLQAHt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2014 19:07:49 -0500
In-Reply-To: <1418604472-1764-1-git-send-email-lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Monday, December 15, 2014 08:47:52 AM Lv Zheng wrote:
> The ec_remove_handlers() is invoked without checking
> EC_FLAGS_HANDLERS_INSTALLED, this patch enhances this check to avoid issues
> that acpi_disable_gpe() is invoked unexpectedly to reduce the GPE runtime
> count. This may happen when the EC handler installation failed on some
> platforms.
> 
> Reported-by: Venkat Raghavulu <venkat.raghavulu@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Applied, thanks!

> ---
>  drivers/acpi/ec.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 5f9b74b..1b5853f 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -844,6 +844,8 @@ static int ec_install_handlers(struct acpi_ec *ec)
>  
>  static void ec_remove_handlers(struct acpi_ec *ec)
>  {
> +	if (!test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
> +		return;
>  	acpi_disable_gpe(NULL, ec->gpe);
>  	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
>  				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
