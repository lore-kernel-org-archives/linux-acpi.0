From: Alex Chiang <achiang@canonical.com>
Subject: [PATCH] ACPI: processor: fix processor_physically_present on UP
Date: Thu, 17 Jun 2010 09:08:54 -0600
Message-ID: <20100617150853.GF2138@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:54122 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897Ab0FQPJD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2010 11:09:03 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, Jan Pogadl <pogadl.jan@googlemail.com>
Cc: gong.chen@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

The commit 5d554a7bb06 (ACPI: processor: add internal
processor_physically_present()) is broken on uniprocessor (UP)
configurations, as acpi_get_cpuid() will always return -1.

We use the value of num_possible_cpus() to tell us whether we got
an invalid cpuid from acpi_get_cpuid() in the SMP case, or if
instead, we are UP, in which case num_possible_cpus() is #defined
as 1.

We use num_possible_cpus() instead of num_online_cpus() to
protect ourselves against the scenario of CPU hotplug, and we've
taken down all the CPUs except one.

Thanks to Jan Pogadl for initial report and analysis and Chen
Gong for review.

Reported-by: Jan Pogadl <pogadl.jan@googlemail.com>:
Cc: Chen Gong <gong.chen@linux.intel.com>
Signed-off-by: Alex Chiang <achiang@canonical.com>
---
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 5128435..e9699aa 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -223,7 +223,7 @@ static bool processor_physically_present(acpi_handle handle)
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
-	if (cpuid == -1)
+	if ((cpuid == -1) && (num_possible_cpus() > 1))
 		return false;
 
 	return true;
