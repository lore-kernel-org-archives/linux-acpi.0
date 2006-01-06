From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 3/9] acpi: Disable C2/C3 for _all_ IBM R40e Laptops
Date: Thu, 05 Jan 2006 22:30:53 -0800
Message-ID: <200601060631.k066V6tf008129@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, kernel-bugs-gyMb1R/nBgON7a6Aj5WzbLNAH6kLmebB@public.gmane.org, davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
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

 drivers/acpi/processor_idle.c |   67 ++++++++++++++++++++++++--------
 1 files changed, 51 insertions(+), 16 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549 drivers/acpi/processor_idle.c
--- devel/drivers/acpi/processor_idle.c~acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549	2006-01-05 22:28:12.000000000 -0800
+++ devel-akpm/drivers/acpi/processor_idle.c	2006-01-05 22:28:12.000000000 -0800
@@ -95,22 +95,57 @@ static int set_max_cstate(struct dmi_sys
 }
 
 static struct dmi_system_id __initdata processor_power_dmi_table[] = {
-	{set_max_cstate, "IBM ThinkPad R40e", {
-					       DMI_MATCH(DMI_BIOS_VENDOR,
-							 "IBM"),
-					       DMI_MATCH(DMI_BIOS_VERSION,
-							 "1SET60WW")},
-	 (void *)1},
-	{set_max_cstate, "Medion 41700", {
-					  DMI_MATCH(DMI_BIOS_VENDOR,
-						    "Phoenix Technologies LTD"),
-					  DMI_MATCH(DMI_BIOS_VERSION,
-						    "R01-A1J")}, (void *)1},
-	{set_max_cstate, "Clevo 5600D", {
-					 DMI_MATCH(DMI_BIOS_VENDOR,
-						   "Phoenix Technologies LTD"),
-					 DMI_MATCH(DMI_BIOS_VERSION,
-						   "SHE845M0.86C.0013.D.0302131307")},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET43WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET45WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET47WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET50WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET52WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET55WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET56WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET59WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET61WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET62WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET64WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET65WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
+	{ set_max_cstate, "Medion 41700", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
+	{ set_max_cstate, "Clevo 5600D", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
 	 (void *)2},
 	{},
 };
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
