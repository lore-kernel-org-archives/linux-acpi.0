From: Len Brown <lenb@kernel.org>
Subject: Re: ec locking issue
Date: Fri, 16 Feb 2007 12:54:55 -0500
Message-ID: <200702161254.55430.lenb@kernel.org>
References: <20070215192616.GA31595@isilmar.linta.de> <45D4BF92.5050401@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45708 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946026AbXBPR4T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 12:56:19 -0500
In-Reply-To: <45D4BF92.5050401@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org

On Thursday 15 February 2007 15:16, Alexey Starikovskiy wrote:
> Hi,
> 
> ec is locked only in acpi_ec_transaction, and it is only once in your 
> stack.
> I doubt that this patch could change something, but worth a try...
> Is bisect finds something?
> 
> Regards,
>     Alex.
> Dominik Brodowski wrote:
> > Hi,
> >
> > Current kernels (e.g. 2.6.20-git-as-of-yesterday) don't boot for me, and
> > it seems like ACPI is the cause: the last thing I can see in the log is
> >
> > swapper/1 is trying to acquire lock
> > 	&ec->lock
> >
> > but task is already holding lock
> > 	&ec->lock
> >
> > Snippets from the call trace:
> >
> > acpi_ec_transaction
> > acpi_ec_read
> > acpi_ec_space_handler
> > acpi_ev_address_space_dispatch
> > acpi_ex_access_region
> > acpi_ex_field_datum_
> > acpi_ex_extract_from_field
> > ...
> > acpi_ex_ns_evaluate
> > acpi_ev_execute_reg_method
> > acpi_ev_reg_run
> > acpi_ns_walk_namespace
> > acpi_ev_execute_reg_methods
> > acpi_install_address_space_handler
> > acpi_ec_start
> > acpi_start_single_object
> > acpi_device_probe
> > really_probe
> > ...
> > bus_add_driver
> > ...
> > acpi_ec_init

Alexey,
Thanks for the fix -- it is applied.

Dominik,
Did this fix help, or is the problem elsehwere?

thanks,
-Len


commit c24e912b61b1ab2301c59777134194066b06465c
Author: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Date:   Thu Feb 15 23:16:18 2007 +0300

    ACPI: ec: add unlock in error path
    
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 743ce27..8f5aaf7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -280,8 +280,10 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
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


