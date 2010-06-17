From: Alex Chiang <achiang@canonical.com>
Subject: Re: [BUG, REGRESSION] ACPI: Set _PDC
Date: Wed, 16 Jun 2010 21:24:14 -0600
Message-ID: <20100617032413.GC2138@canonical.com>
References: <201006170040.24736.pogadl.jan@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:45878 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0FQDYT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2010 23:24:19 -0400
Content-Disposition: inline
In-Reply-To: <201006170040.24736.pogadl.jan@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Pogadl <pogadl.jan@googlemail.com>
Cc: linux-acpi@vger.kernel.org

Hi Jan,

* Jan Pogadl <pogadl.jan@googlemail.com>:
> Hi,
> 
> with commit commit 5d554a7bb0643a6151a84319bfeba8270bf5269e (ACPI: processor: 
> add internal processor_physically_present()) a new function got introduced which 
> always fails on machines with CONFIG_SMP disabled. Thus _PDC will never be 
> initialized? set?. 

My apologies for the regression and the slow response. Please
note my new email address.

Does this patch fix it?

---
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 5128435..bcf0cf8 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -223,7 +223,7 @@ static bool processor_physically_present(acpi_handle handle)
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
-	if (cpuid == -1)
+	if ((cpuid == -1) && (num_online_cpus() > 1))
 		return false;
 
 	return true;
