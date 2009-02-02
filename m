From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: [PATCH] Enable bit 11 in _PDC to advertise hw coord
Date: Mon, 2 Feb 2009 11:57:18 -0800
Message-ID: <20090202195717.GA24510@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61297 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140AbZBBT5W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Feb 2009 14:57:22 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Chris Mason <chris.mason@oracle.com>


Bit 11 in intel PDC definitions is meant for OS capability to handle
hardware coordination of P-states. In Linux we have always supported
hwardware coordination of P-states. Just let the BIOSes know that we
support it, by setting this bit.

Some BIOSes use this bit to choose between hardware or software coordination
and without this change below, BIOSes switch to software coordination, which
is not very optimal in terms of power consumption and extra wakeups from idle.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---
 include/acpi/pdc_intel.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/include/acpi/pdc_intel.h
===================================================================
--- linux-2.6.orig/include/acpi/pdc_intel.h	2009-01-20 16:11:20.000000000 -0800
+++ linux-2.6/include/acpi/pdc_intel.h	2009-02-02 10:32:06.000000000 -0800
@@ -14,6 +14,7 @@
 #define ACPI_PDC_SMP_T_SWCOORD		(0x0080)
 #define ACPI_PDC_C_C1_FFH		(0x0100)
 #define ACPI_PDC_C_C2C3_FFH		(0x0200)
+#define ACPI_PDC_SMP_P_HWCOORD		(0x0800)
 
 #define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
 					 ACPI_PDC_C_C1_HALT | \
@@ -22,6 +23,7 @@
 #define ACPI_PDC_EST_CAPABILITY_SWSMP	(ACPI_PDC_SMP_C1PT | \
 					 ACPI_PDC_C_C1_HALT | \
 					 ACPI_PDC_SMP_P_SWCOORD | \
+					 ACPI_PDC_SMP_P_HWCOORD | \
 					 ACPI_PDC_P_FFH)
 
 #define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3  | \
