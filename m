From: akpm@osdl.org
Subject: [patch 20/23] acpi signedness fix
Date: Tue, 21 Mar 2006 22:30:44 -0800
Message-ID: <200603220633.k2M6Xw7N019586@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:61885 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750918AbWCVGid (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 01:38:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, ashok.raj@intel.com, davej@codemonkey.org.uk, kaneshige.kenji@soft.fujitsu.com


From: Ashok Raj <ashok.raj@intel.com>

Local apic entries are only 8 bits, but it seemed to not be caught with u8
return value result in the check

cpu_index >= NR_CPUS becomming always false.

drivers/acpi/processor_core.c: In function `acpi_processor_get_info':
drivers/acpi/processor_core.c:483: warning: comparison is always false due to limited range of data type

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Dave Jones <davej@codemonkey.org.uk>
Cc: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/acpi/processor_core.c~acpi-signedness-fix-2 drivers/acpi/processor_core.c
--- devel/drivers/acpi/processor_core.c~acpi-signedness-fix-2	2006-03-21 22:30:07.000000000 -0800
+++ devel-akpm/drivers/acpi/processor_core.c	2006-03-21 22:30:07.000000000 -0800
@@ -382,7 +382,7 @@ static int acpi_processor_remove_fs(stru
 
 /* Use the acpiid in MADT to map cpus in case of SMP */
 #ifndef CONFIG_SMP
-#define convert_acpiid_to_cpu(acpi_id) (0xff)
+#define convert_acpiid_to_cpu(acpi_id) (-1)
 #else
 
 #ifdef CONFIG_IA64
@@ -395,7 +395,7 @@ static int acpi_processor_remove_fs(stru
 #define ARCH_BAD_APICID		(0xff)
 #endif
 
-static u8 convert_acpiid_to_cpu(u8 acpi_id)
+static int convert_acpiid_to_cpu(u8 acpi_id)
 {
 	u16 apic_id;
 	int i;
@@ -421,7 +421,7 @@ static int acpi_processor_get_info(struc
 	acpi_status status = 0;
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
-	u8 cpu_index;
+	int cpu_index;
 	static int cpu0_initialized;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_get_info");
@@ -466,7 +466,7 @@ static int acpi_processor_get_info(struc
 	cpu_index = convert_acpiid_to_cpu(pr->acpi_id);
 
 	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
-	if (!cpu0_initialized && (cpu_index == 0xff) &&
+	if (!cpu0_initialized && (cpu_index == -1) &&
 	    (num_online_cpus() == 1)) {
 		cpu_index = 0;
 	}
@@ -480,7 +480,7 @@ static int acpi_processor_get_info(struc
 	 *  less than the max # of CPUs. They should be ignored _iff
 	 *  they are physically not present.
 	 */
-	if (cpu_index >= NR_CPUS) {
+	if (cpu_index == -1) {
 		if (ACPI_FAILURE
 		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
 			ACPI_ERROR((AE_INFO,
_
