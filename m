From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 14/20] x86, acpi, lss: use Intel family name macros for lpss driver
Date: Thu, 02 Jun 2016 17:19:46 -0700
Message-ID: <20160603001946.264CE704@viggo.jf.intel.com>
References: <20160603001927.F2A7D828@viggo.jf.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55917 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161319AbcFCATs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jun 2016 20:19:48 -0400
In-Reply-To: <20160603001927.F2A7D828@viggo.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, jacob.jun.pan@intel.com, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Another straightforward replacement of magic numbers.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---

 b/drivers/acpi/acpi_lpss.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/acpi_lpss.c~x86-intel-families-lpss drivers/acpi/acpi_lpss.c
--- a/drivers/acpi/acpi_lpss.c~x86-intel-families-lpss	2016-06-02 15:19:21.576366389 -0700
+++ b/drivers/acpi/acpi_lpss.c	2016-06-02 15:19:21.581366616 -0700
@@ -29,6 +29,7 @@ ACPI_MODULE_NAME("acpi_lpss");
 #ifdef CONFIG_X86_INTEL_LPSS
 
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
 #include <asm/pmc_atom.h>
 
@@ -229,8 +230,8 @@ static const struct lpss_device_desc bsw
 #define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
 
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	ICPU(0x37),	/* Valleyview, Bay Trail */
-	ICPU(0x4c),	/* Braswell, Cherry Trail */
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	/* Valleyview, Bay Trail */
+	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
 	{}
 };
 
_
