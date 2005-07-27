From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 3/7] acpi: Disable C2/C3 for _all_ IBM R40e Laptops (Bug #3549)
Date: Wed, 27 Jul 2005 01:01:31 -0700
Message-ID: <200507270802.j6R82SVp009261@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, Thomas.Roesner-gyMb1R/nBgON7a6Aj5WzbLNAH6kLmebB@public.gmane.org, kernel-bugs-gyMb1R/nBgON7a6Aj5WzbLNAH6kLmebB@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Thomas Roesner <Thomas.Roesner-gyMb1R/nBgON7a6Aj5WzbLNAH6kLmebB@public.gmane.org>

This adds all known BIOS versions of IBM R40e Laptops to the C2/C3
processor state blacklist and thus prevents them from crashing.  Fixes Bug
#3549.

Implementation is probably overly verbose, but DMI_MATCH seems to give us
no choice.

Signed-off-by: Thomas Roesner <kernel-bugs-gyMb1R/nBgON7a6Aj5WzbLNAH6kLmebB@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/processor_idle.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+)

diff -puN drivers/acpi/processor_idle.c~acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-bug-3549 drivers/acpi/processor_idle.c
--- devel/drivers/acpi/processor_idle.c~acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-bug-3549	2005-07-14 15:53:34.000000000 -0700
+++ devel-akpm/drivers/acpi/processor_idle.c	2005-07-14 15:53:34.000000000 -0700
@@ -101,7 +101,46 @@ static int no_c2c3(struct dmi_system_id 
 static struct dmi_system_id __initdata processor_power_dmi_table[] = {
 	{ no_c2c3, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET32WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET43WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET45WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET47WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET50WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET52WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET55WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET56WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET59WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET61WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET62WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET64WW") }},
+	{ no_c2c3, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET65WW") }},
 	{ no_c2c3, "Medion 41700", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J") }},
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
