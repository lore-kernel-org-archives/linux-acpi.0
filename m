From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI SBS: Fix intermittent hangs on Apple Macbook
Date: Wed, 29 Apr 2015 02:37:57 +0200
Message-ID: <4435249.leKkNHm9IZ@vostro.rjw.lan>
References: <20150424012530.GA16763@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59728 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1031083AbbD2ANF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 20:13:05 -0400
In-Reply-To: <20150424012530.GA16763@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Friday, April 24, 2015 02:25:30 AM Chris Bainbridge wrote:
> Commit 7bc5a2b exposed the SBS on Apple hardware, resulting in
> intermittent hangs of several minutes on boot, and failure to detect or
> report the battery. We fix this two ways:
> 
>  - SMBUS hang should not hang the whole system. Respect the specified
>    timeout by busy waiting instead of sleeping.
>    This fix is already used on MSI hardware.
>  
>  - Stop the SBS from hanging in the first place by introducing a 5us
>    delay before each SMBUS transaction. This fix is the result of
>    experimentation. This particular delay was found to completely fix
>    the problem on an Ivybridge Macbook Pro 13. Hangs were observed with
>    3us delay but never with 5us.
> 
> Also, pr_warn if SBS communication fails instead of silently ignoring.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=94651
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>

Well, this looks like two patches combined to me.  Are the quirks actually
related except that they are both needed to fix the problem?

> ---
>  drivers/acpi/ec.c    | 14 +++++++++++++-
>  drivers/acpi/sbs.c   | 10 +++++++---
>  drivers/acpi/sbshc.c | 24 ++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 220d640..7c9dacc 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -131,6 +131,7 @@ struct acpi_ec *boot_ec, *first_ec;
>  EXPORT_SYMBOL(first_ec);
>  
>  static int EC_FLAGS_MSI; /* Out-of-spec MSI controller */
> +static int EC_FLAGS_APPLE; /* Out-of-spec Apple controller */
>  static int EC_FLAGS_VALIDATE_ECDT; /* ASUStec ECDTs need to be validated */
>  static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early DSDT scan */
>  static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
> @@ -505,7 +506,7 @@ static int ec_poll(struct acpi_ec *ec)
>  		unsigned long usecs = ACPI_EC_UDELAY_POLL;
>  		do {
>  			/* don't sleep with disabled interrupts */
> -			if (EC_FLAGS_MSI || irqs_disabled()) {
> +			if (EC_FLAGS_APPLE || EC_FLAGS_MSI || irqs_disabled()) {

Does EC_FLAGS_MSI do anything in addition to this?  If not, it might be better
to rename it and use it for both Apple and MSI.

>  				usecs = ACPI_EC_MSI_UDELAY;
>  				udelay(usecs);
>  				if (ec_transaction_completed(ec))
> @@ -1246,6 +1247,14 @@ static int ec_flag_msi(const struct dmi_system_id *id)
>  	return 0;
>  }
>  
> +/* Apple Macbook needs special treatment, enable it */
> +static int ec_flag_apple(const struct dmi_system_id *id)
> +{
> +	pr_debug("Detected Apple hardware, enabling workarounds.\n");
> +	EC_FLAGS_APPLE = 1;
> +	return 0;
> +}
> +
>  /*
>   * Clevo M720 notebook actually works ok with IRQ mode, if we lifted
>   * the GPE storm threshold back to 20
> @@ -1323,6 +1332,9 @@ static struct dmi_system_id ec_dmi_table[] __initdata = {
>  	DMI_MATCH(DMI_SYS_VENDOR, "CLEVO CO."),
>  	DMI_MATCH(DMI_PRODUCT_NAME, "W35_37ET"),}, NULL},
>  	{
> +	ec_flag_apple, "Apple", {
> +	DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc.")}, NULL},

Do we really need this for all Apple hardware?

> +	{
>  	ec_validate_ecdt, "ASUS hardware", {
>  	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
>  	{
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index cd82762..165519e 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -369,8 +369,11 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
>  					 info_readers[i].command,
>  					 (u8 *) battery +
>  						info_readers[i].offset);
> -		if (result)
> +		if (result) {
> +			pr_warn("sbs read battery failed (cmd=%x)\n",
> +				info_readers[i].command);

This should be a debug printk() and the one below too.  Also I'm not sure
why it belongs to this patch.

>  			break;
> +		}
>  	}
>  	return result;
>  }
> @@ -412,7 +415,6 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
>  
>  	int ret;
>  
> -
>  	if (sbs->manager_present) {
>  		ret = acpi_smbus_read(sbs->hc, SMBUS_READ_WORD, ACPI_SBS_MANAGER,
>  				0x01, (u8 *)&value);
> @@ -442,8 +444,10 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
>  	result = acpi_smbus_read(sbs->hc, SMBUS_READ_WORD, ACPI_SBS_CHARGER,
>  				 0x13, (u8 *) & status);
>  
> -	if (result)
> +	if (result) {
> +		pr_warn("sbs read charger failed\n");
>  		return result;
> +	}
>  
>  	/*
>  	 * The spec requires that bit 4 always be 1. If it's not set, assume
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 26e5b50..2d40c24 100644
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
> +static int SMBUS_FLAGS_APPLE;

Why upper case?  The EC driver has this weird naming convention, but is there
any good reason to spread it?

> +
>  static inline int smb_hc_read(struct acpi_smb_hc *hc, u8 address, u8 *data)
>  {
>  	return ec_read(hc->offset + address, data);
> @@ -132,6 +135,8 @@ static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
>  	}
>  
>  	mutex_lock(&hc->lock);
> +	if (SMBUS_FLAGS_APPLE)
> +		udelay(5);
>  	if (smb_hc_read(hc, ACPI_SMB_PROTOCOL, &temp))
>  		goto end;
>  	if (temp) {
> @@ -257,12 +262,31 @@ extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
>  			      acpi_handle handle, acpi_ec_query_func func,
>  			      void *data);
>  
> +static int smbus_flag_apple(const struct dmi_system_id *d)
> +{
> +	SMBUS_FLAGS_APPLE = 1;
> +	return 0;
> +}
> +
> +static struct dmi_system_id acpi_smbus_dmi_table[] = {
> +	{
> +		.callback = smbus_flag_apple,
> +		.ident = "Apple",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc.")

Again, is this really needed for all Apple hardware?

> +		},
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
