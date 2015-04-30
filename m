From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/sbshc: Add 5us delay to fix SBS hang on MacBook
Date: Fri, 01 May 2015 00:15:10 +0200
Message-ID: <6222350.UNP9dleyUi@vostro.rjw.lan>
References: <20150424012530.GA16763@localhost> <4435249.leKkNHm9IZ@vostro.rjw.lan> <20150429202140.GB25904@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63205 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750717AbbD3VuQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 17:50:16 -0400
In-Reply-To: <20150429202140.GB25904@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wednesday, April 29, 2015 09:21:40 PM Chris Bainbridge wrote:
> Regression in commit 7bc5a2bad0b8d9d1ac9f7b8b33150e4ddf197334
> Author: Matthew Garrett <matthew.garrett@nebula.com>
> Date:   Sat Sep 20 13:19:47 2014 +0200
> 
>     ACPI: Support _OSI("Darwin") correctly
> 
> Supporting _OSI("Darwin") caused the MacBook firmware to expose the SBS,
> resulting in intermittent hangs of several minutes on boot, and failure
> to detect or report the battery. Fix this by adding a 5us delay to the
> start of each SMBUS transaction. This timing is the result of
> experimentation - hangs were observed with 3us but never with 5us.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=94651
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>

Looks much better, I've queued it up as a fix for 4.1, thanks!

> ---
>  drivers/acpi/sbshc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 26e5b50..bf034f8 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> +#include <linux/dmi.h>
>  #include "sbshc.h"
>  
>  #define PREFIX "ACPI: "
> @@ -87,6 +88,8 @@ enum acpi_smb_offset {
>  	ACPI_SMB_ALARM_DATA = 0x26,	/* 2 bytes alarm data */
>  };
>  
> +static bool macbook;
> +
>  static inline int smb_hc_read(struct acpi_smb_hc *hc, u8 address, u8 *data)
>  {
>  	return ec_read(hc->offset + address, data);
> @@ -132,6 +135,8 @@ static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
>  	}
>  
>  	mutex_lock(&hc->lock);
> +	if (macbook)
> +		udelay(5);
>  	if (smb_hc_read(hc, ACPI_SMB_PROTOCOL, &temp))
>  		goto end;
>  	if (temp) {
> @@ -257,12 +262,29 @@ extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
>  			      acpi_handle handle, acpi_ec_query_func func,
>  			      void *data);
>  
> +static int macbook_dmi_match(const struct dmi_system_id *d)
> +{
> +	pr_debug("Detected MacBook, enabling workaround\n");
> +	macbook = true;
> +	return 0;
> +}
> +
> +static struct dmi_system_id acpi_smbus_dmi_table[] = {
> +	{ macbook_dmi_match, "Apple MacBook", {
> +	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
> +	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBook") },
> +	},
> +	{ },
> +};
> +
>  static int acpi_smbus_hc_add(struct acpi_device *device)
>  {
>  	int status;
>  	unsigned long long val;
>  	struct acpi_smb_hc *hc;
>  
> +	dmi_check_system(acpi_smbus_dmi_table);
> +
>  	if (!device)
>  		return -EINVAL;
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
