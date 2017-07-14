From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 5/6] acpi: change memory allocations to GFP_NOIO
Date: Fri, 14 Jul 2017 16:11:47 -0600
Message-ID: <20170714221148.11232-6-vishal.l.verma@intel.com>
References: <20170714221148.11232-1-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:30967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbdGNWNc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jul 2017 18:13:32 -0400
In-Reply-To: <20170714221148.11232-1-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

With the ACPI NFIT 'DSM' methods, acpi can be called from IO paths.
Specifically, the DSM to clear media errors is called during writes, so
that we can provide a writes-fix-errors model.

However it is easy to imagine a scenario like:
 - write through the nvdimm driver
 - acpi allocation
 - writeback, causes more IO through the nvdimm driver
 - deadlock

Making the acpi allocations GPF_NOIO would ensure that it doesn't
trigger writeback, and avoids the above deadlock.

Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 include/acpi/platform/aclinuxex.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index efdff52..9bd54ec 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -83,12 +83,12 @@ acpi_status acpi_os_terminate(void);
  */
 static inline void *acpi_os_allocate(acpi_size size)
 {
-	return kmalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
+	return kmalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_NOIO);
 }
 
 static inline void *acpi_os_allocate_zeroed(acpi_size size)
 {
-	return kzalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
+	return kzalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_NOIO);
 }
 
 static inline void acpi_os_free(void *memory)
@@ -99,7 +99,7 @@ static inline void acpi_os_free(void *memory)
 static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 {
 	return kmem_cache_zalloc(cache,
-				 irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
+				 irqs_disabled()? GFP_ATOMIC : GFP_NOIO);
 }
 
 static inline acpi_thread_id acpi_os_get_thread_id(void)
-- 
2.9.3

