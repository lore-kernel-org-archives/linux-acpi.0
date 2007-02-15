From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: ec locking issue
Date: Thu, 15 Feb 2007 23:16:18 +0300
Message-ID: <45D4BF92.5050401@linux.intel.com>
References: <20070215192616.GA31595@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020300060804000406090904"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:29284 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161153AbXBOUQZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Feb 2007 15:16:25 -0500
In-Reply-To: <20070215192616.GA31595@isilmar.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300060804000406090904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

ec is locked only in acpi_ec_transaction, and it is only once in your 
stack.
I doubt that this patch could change something, but worth a try...
Is bisect finds something?

Regards,
    Alex.
Dominik Brodowski wrote:
> Hi,
>
> Current kernels (e.g. 2.6.20-git-as-of-yesterday) don't boot for me, and
> it seems like ACPI is the cause: the last thing I can see in the log is
>
> swapper/1 is trying to acquire lock
> 	&ec->lock
>
> but task is already holding lock
> 	&ec->lock
>
> Snippets from the call trace:
>
> acpi_ec_transaction
> acpi_ec_read
> acpi_ec_space_handler
> acpi_ev_address_space_dispatch
> acpi_ex_access_region
> acpi_ex_field_datum_
> acpi_ex_extract_from_field
> ...
> acpi_ex_ns_evaluate
> acpi_ev_execute_reg_method
> acpi_ev_reg_run
> acpi_ns_walk_namespace
> acpi_ev_execute_reg_methods
> acpi_install_address_space_handler
> acpi_ec_start
> acpi_start_single_object
> acpi_device_probe
> really_probe
> ...
> bus_add_driver
> ...
> acpi_ec_init
>
>
>
> Ideas? Patches?
>
> Thanks,
> 	Dominik
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


--------------020300060804000406090904
Content-Type: text/plain;
 name="ec_unlock_mutex_in_error_path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_unlock_mutex_in_error_path.patch"

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 743ce27..8f5aaf7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -280,8 +280,10 @@ static int acpi_ec_transaction(struct ac
 	mutex_lock(&ec->lock);
 	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
+			mutex_unlock(&ec->lock);
 			return -ENODEV;
+		}
 	}
 
 	/* Make sure GPE is enabled before doing transaction */

--------------020300060804000406090904--
