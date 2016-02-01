From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v2] ACPI: Do not report _OSI("Darwin") when acpi_osi=!Darwin provided
Date: Mon,  1 Feb 2016 10:26:52 +0800
Message-ID: <1454293612-13161-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27743 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933509AbcBACVN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 31 Jan 2016 21:21:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, matthew.garrett@nebula.com, rui.zhang@intel.com, Chen Yu <yu.c.chen@intel.com>

Commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly") always
reports positive value when Apple hardware queries _OSI("Darwin").
But sometimes the users might want to tell the hardware they don't
need the Darwin feature, for example, users may leverage the hardware
to power off the Thunderbolt, by appending acpi_osi=!Darwin in command
line, thus Apple hardware regards it as an incompatible OS X system,
hence turns off the Thunderbolt.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=92111
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2:
 - Convert osi_setup_entries to non-initdata variable, to
   eliminate the warning from 0-DAY test infrastructure.
---
 drivers/acpi/osl.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 67da6fb..738431a 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -97,6 +97,7 @@ static LIST_HEAD(acpi_ioremaps);
 static DEFINE_MUTEX(acpi_ioremap_lock);
 
 static void __init acpi_osi_setup_late(void);
+static bool acpi_osi_setup_disabled(char *str);
 
 /*
  * The story of _OSI(Linux)
@@ -149,11 +150,13 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 			osi_linux.dmi ? " via DMI" : "");
 	}
 
-	if (!strcmp("Darwin", interface)) {
+	if (!strcmp("Darwin", interface) &&
+	    !acpi_osi_setup_disabled(interface)) {
 		/*
 		 * Apple firmware will behave poorly if it receives positive
 		 * answers to "Darwin" and any other OS. Respond positively
-		 * to Darwin and then disable all other vendor strings.
+		 * to Darwin and then disable all other vendor strings if
+		 * acpi_osi="!Darwin" is not appended in cmdline.
 		 */
 		acpi_update_interfaces(ACPI_DISABLE_ALL_VENDOR_STRINGS);
 		supported = ACPI_UINT32_MAX;
@@ -1688,13 +1691,34 @@ struct osi_setup_entry {
 };
 
 static struct osi_setup_entry
-		osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
+		osi_setup_entries[OSI_STRING_ENTRIES_MAX] = {
 	{"Module Device", true},
 	{"Processor Device", true},
 	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
 };
 
+static bool acpi_osi_setup_disabled(char *str)
+{
+	int i;
+	struct osi_setup_entry *osi;
+
+	if (!str)
+		return false;
+
+	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
+		osi = &osi_setup_entries[i];
+		if (!strcmp(osi->string, str)) {
+			if (!osi->enable)
+				return true;
+			else
+				return false;
+		}
+	}
+
+	return false;
+}
+
 void __init acpi_osi_setup(char *str)
 {
 	struct osi_setup_entry *osi;
-- 
1.8.4.2

