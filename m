From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 8/9] acpi: Disable C2/C3 for _all_ IBM R40e Laptops
Date: Fri, 28 Oct 2005 14:59:53 -0700
Message-ID: <200510282159.j9SLxZFb021625@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, kernel-bugs-gyMb1R/nBgON7a6Aj5WzbLNAH6kLmebB@public.gmane.org, davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Thomas Rosner <kernel-bugs-gyMb1R/nBgON7a6Aj5WzbLNAH6kLmebB@public.gmane.org>

This adds all known BIOS versions of IBM R40e Laptops to the C2/C3
processor state blacklist and thus prevents them from crashing.  Fixes Bug
#3549.

Implementation is probably overly verbose, but DMI_MATCH seems to give us
no choice.

Signed-off-by: Thomas Rosner <kernel-bugs-gyMb1R/nBgON7a6Aj5WzbLNAH6kLmebB@public.gmane.org>
Cc: <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/processor_idle.c |  115 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 101 insertions(+), 14 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549 drivers/acpi/processor_idle.c
--- 25/drivers/acpi/processor_idle.c~acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549	Fri Oct 28 14:59:13 2005
+++ 25-akpm/drivers/acpi/processor_idle.c	Fri Oct 28 14:59:13 2005
@@ -94,23 +94,110 @@ static int set_max_cstate(struct dmi_sys
 }
 
 static struct dmi_system_id __initdata processor_power_dmi_table[] = {
+	/* The known versions of IBM R40e BIOS */
 	{set_max_cstate, "IBM ThinkPad R40e", {
-					       DMI_MATCH(DMI_BIOS_VENDOR,
-							 "IBM"),
-					       DMI_MATCH(DMI_BIOS_VERSION,
-							 "1SET60WW")},
-	 (void *)1},
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET32WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET43WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET45WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET47WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET50WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET52WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET55WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET56WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET59WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET60WW")},
+			(void *)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET61WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET62WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET64WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET65WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET68WW") },
+			(void*)1},
+	/* Other laptops, same problem */
 	{set_max_cstate, "Medion 41700", {
-					  DMI_MATCH(DMI_BIOS_VENDOR,
-						    "Phoenix Technologies LTD"),
-					  DMI_MATCH(DMI_BIOS_VERSION,
-						    "R01-A1J")}, (void *)1},
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"R01-A1J")},
+			(void *)1},
 	{set_max_cstate, "Clevo 5600D", {
-					 DMI_MATCH(DMI_BIOS_VENDOR,
-						   "Phoenix Technologies LTD"),
-					 DMI_MATCH(DMI_BIOS_VERSION,
-						   "SHE845M0.86C.0013.D.0302131307")},
-	 (void *)2},
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"SHE845M0.86C.0013.D.0302131307")},
+			(void *)2},
 	{},
 };
 
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
