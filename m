From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH] ACPI / EC: Fix an order issue in
 ec_remove_handlers()
Date: Thu, 7 Jul 2016 04:38:52 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC008D7@SHSMSX101.ccr.corp.intel.com>
References: <20160706141410.GA1430@tetsubishi>
 <4497ad5c9ab1bc4e35771d149bd1d9a658d28ddf.1467856011.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40352 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbcGGEj1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jul 2016 00:39:27 -0400
In-Reply-To: <4497ad5c9ab1bc4e35771d149bd1d9a658d28ddf.1467856011.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Nicholas <nkudriavtsev@gmail.com>

This one and the previous one contain problems.
A patch marked as [UPDATE RFC v2] is the correct fix.
Sorry for the noise.

Thanks and best regards
-Lv

> From: Zheng, Lv
> Subject: [RFC PATCH] ACPI / EC: Fix an order issue in ec_remove_handlers()
> 
> There is an order issue in ec_remove_handlers() that the functions invoked
> in it are not invoked in the reversed order of their appearance in
> ec_install_handlers(). This existing issue has been triggered by the
> following commit:
>   Commit: dcf15cbded656a12335bc4151f3f75f10080a375
>   Subject: ACPI / EC: Fix a boot EC regresion by restoring boot EC
> The commit invokes ec_remove_handlers() during runtime, thus uncovers
> this
> issue. This patch fixes this regression.
> 
> Fixes: dcf15cbded65 ("ACPI / EC: Fix a boot EC regresion by restoring boot
> EC")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=102421
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Reported-by: Nicholas <nkudriavtsev@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Nicholas <nkudriavtsev@gmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/ec.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Index: linux-acpica/drivers/acpi/ec.c
> ==========================================================
> =========
> --- linux-acpica.orig/drivers/acpi/ec.c
> +++ linux-acpica/drivers/acpi/ec.c
> @@ -1331,8 +1331,6 @@ static int ec_install_handlers(struct ac
> 
>  static void ec_remove_handlers(struct acpi_ec *ec)
>  {
> -	acpi_ec_stop(ec, false);
> -
>  	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>  		if (ACPI_FAILURE(acpi_remove_address_space_handler(ec-
> >handle,
>  					ACPI_ADR_SPACE_EC,
> &acpi_ec_space_handler)))
> @@ -1340,6 +1338,17 @@ static void ec_remove_handlers(struct ac
>  		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>  	}
> 
> +	/*
> +	 * Disabling EC (transactions) after removing the operation region
> +	 * handler. This order is required because _REG(DISCONNECT) may
> +	 * access the EmbeddedControl operation regions.
> +	 *
> +	 * Flushing transactions before removing the GPE handler. This is
> +	 * required by the current ACPICA GPE design. ACPICA GPE will
> block
> +	 * a GPE if there is no way to handle it.
> +	 */
> +	acpi_ec_stop(ec, false);
> +
>  	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
>  		if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
>  					&acpi_ec_gpe_handler)))
