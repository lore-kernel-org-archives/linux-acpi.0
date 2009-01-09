From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] R40e using rsdt (previous patch) makes all Cstates work -> remove blacklisting
Date: Fri,  9 Jan 2009 11:58:58 +0100
Message-ID: <1231498738-32714-3-git-send-email-trenn@suse.de>
References: <1229504118.3991.63.camel@yakui_zhao.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:42019 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbZAIK7A (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 9 Jan 2009 05:59:00 -0500
In-Reply-To: <1229504118.3991.63.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, yakui.zhao@intel.com, Linux-acpi@vger.kernel.org, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net
Cc: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/processor_idle.c |   51 -----------------------------------------
 1 files changed, 0 insertions(+), 51 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 66a9d81..93bd366 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -127,57 +127,6 @@ static int set_max_cstate(const struct dmi_system_id *id)
 /* Actually this shouldn't be __cpuinitdata, would be better to fix the
    callers to only run once -AK */
 static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET70WW")}, (void *)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET43WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET45WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET47WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET50WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET52WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET55WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET56WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET59WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET61WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET62WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET64WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET65WW") }, (void*)1},
-	{ set_max_cstate, "IBM ThinkPad R40e", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
-	{ set_max_cstate, "Medion 41700", {
-	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
-	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
 	{ set_max_cstate, "Clevo 5600D", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
-- 
1.6.0.2

