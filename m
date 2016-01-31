From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] ACPI: Do not report _OSI("Darwin") when acpi_osi=!Darwin provided
Date: Sun, 31 Jan 2016 22:51:44 +0800
Message-ID: <1454251904-7514-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22164 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218AbcAaOqJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 31 Jan 2016 09:46:09 -0500
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
 drivers/acpi/osl.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 67da6fb..f945d54 100644
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
@@ -1695,6 +1698,27 @@ static struct osi_setup_entry
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

