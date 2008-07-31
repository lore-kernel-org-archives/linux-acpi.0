From: Thomas Rosner <kernel-bugs@digital-trauma.de>
Subject: [PATCH] IBM R40e blacklist for C2/C3 states: sort & remove duplicate
Date: Thu, 31 Jul 2008 23:35:35 +0200
Message-ID: <20080815160657.25828.qmail@serverkommune.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from serverkommune.de ([88.198.12.136]:43466 "EHLO serverkommune.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbYHOQNk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Aug 2008 12:13:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Andie Kleen <ak@linux.intel.com>, Thomas Rosner <kernel-bugs@digital-trauma.de>

Sort the entries in the IBM R40e C2/C3-states blacklist and remove a duplicate. Please apply.

Signed-off-by: Thomas Rosner <kernel-bugs@digital-trauma.de>
CC: Len Brown <len.brown@intel.com>
CC: Andie Kleen <ak@linux.intel.com>
---
 drivers/acpi/processor_idle.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 556ee15..3e9f59d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -128,12 +128,6 @@ static int set_max_cstate(const struct dmi_system_id *id)
 static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET70WW")}, (void *)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET43WW") }, (void*)1},
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
@@ -174,6 +168,9 @@ static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET70WW")}, (void *)1},
 	{ set_max_cstate, "Medion 41700", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
-- 
1.5.4.5

