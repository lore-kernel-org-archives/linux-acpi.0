From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [patch (for 2.6.25?) 1/3] ACPI: EC: fix regression
Date: Wed, 05 Mar 2008 02:24:09 +0300
Message-ID: <47CDDA19.3060908@gmail.com>
References: <200803042300.m24N0CD9001543@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030106080400090609060806"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:52411 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935296AbYCDXYQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 18:24:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2956599ugc.16
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2008 15:24:13 -0800 (PST)
In-Reply-To: <200803042300.m24N0CD9001543@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, m.s.tsirkin@gmail.com, rjw@sisk.pl

This is a multi-part message in MIME format.
--------------030106080400090609060806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

Please drop this patch. I would like to just revert the patch that causes this bug.
It is appended to #10100, attaching it here too.

Thanks,
Alex.

akpm@linux-foundation.org wrote:
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> no changelog?
> 
> Tested-by: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/ec.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff -puN drivers/acpi/ec.c~acpi-ec-fix-regression drivers/acpi/ec.c
> --- a/drivers/acpi/ec.c~acpi-ec-fix-regression
> +++ a/drivers/acpi/ec.c
> @@ -129,7 +129,8 @@ static struct acpi_ec {
>  	struct mutex lock;
>  	wait_queue_head_t wait;
>  	struct list_head list;
> -	u8 handlers_installed;
> +	u8 handlers_installed:1;
> +	u8 from_ecdt:1;
>  } *boot_ec, *first_ec;
>  
>  /* --------------------------------------------------------------------------
> @@ -772,16 +773,18 @@ static int acpi_ec_add(struct acpi_devic
>  
>  	/* Check for boot EC */
>  	if (boot_ec) {
> -		if (boot_ec->handle == device->handle) {
> -			/* Pre-loaded EC from DSDT, just move pointer */
> -			ec = boot_ec;
> -			boot_ec = NULL;
> -			goto end;
> -		} else if (boot_ec->handle == ACPI_ROOT_OBJECT) {
> +		if (boot_ec->from_ecdt &&
> +		    (boot_ec->handle == device->handle ||
> +		     boot_ec->handle == ACPI_ROOT_OBJECT)) {
>  			/* ECDT-based EC, time to shut it down */
>  			ec_remove_handlers(boot_ec);
>  			kfree(boot_ec);
>  			first_ec = boot_ec = NULL;
> +		} else if (boot_ec->handle == device->handle) {
> +			/* Pre-loaded EC from DSDT, just move pointer */
> +			ec = boot_ec;
> +			boot_ec = NULL;
> +			goto end;
>  		}
>  	}
>  
> @@ -943,6 +946,7 @@ int __init acpi_ec_ecdt_probe(void)
>  		boot_ec->command_addr = ecdt_ptr->control.address;
>  		boot_ec->data_addr = ecdt_ptr->data.address;
>  		boot_ec->gpe = ecdt_ptr->gpe;
> +		boot_ec->from_ecdt = 1;
>  		if (ACPI_FAILURE(acpi_get_handle(NULL, ecdt_ptr->id,
>  				&boot_ec->handle))) {
>  			pr_info("Failed to locate handle for boot EC\n");
> _


--------------030106080400090609060806
Content-Type: text/plain;
 name="revert-208c70a45624400fafd7511b96bc426bf01f8f5e"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="revert-208c70a45624400fafd7511b96bc426bf01f8f5e"

ACPI: EC: Revert 208c70a45624400fafd7511b96bc426bf01f8f5e

From: Alexey Starikovskiy <astarikovskiy@suse.de>

This patch for non-fatal error causes some fatal ones.
Just revert it and find better solution for original problem.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index caf873c..7222a18 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -943,11 +943,7 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->command_addr = ecdt_ptr->control.address;
 		boot_ec->data_addr = ecdt_ptr->data.address;
 		boot_ec->gpe = ecdt_ptr->gpe;
-		if (ACPI_FAILURE(acpi_get_handle(NULL, ecdt_ptr->id,
-				&boot_ec->handle))) {
-			pr_info("Failed to locate handle for boot EC\n");
-			boot_ec->handle = ACPI_ROOT_OBJECT;
-		}
+		boot_ec->handle = ACPI_ROOT_OBJECT;
 	} else {
 		/* This workaround is needed only on some broken machines,
 		 * which require early EC, but fail to provide ECDT */

--------------030106080400090609060806--
