From: Thomas Renninger <trenn@suse.de>
Subject: [RESEND] [PATCH 3/3] Remove R40e c-state blacklist
Date: Sun, 19 Oct 2008 23:52:07 +0200
Message-ID: <200810192352.09782.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:32822 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbYJSVwE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 17:52:04 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "devel@acpica.org" <devel@acpica.org>

Remove R40e c-state blacklist

References: http://bugzilla.kernel.org/show_bug.cgi?id=8246

The FADT pointed to through XSDT is wrong on this (and similar)
machines.
Previous patches blacklist this machine to use the right FADT and
C-states finally work fine.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: Mark Doughty <me@markdoughty.co.uk>
CC: Yakui Zhao <yakui.zhao@intel.com>

---
 drivers/acpi/processor_idle.c |   51 ------------------------------------------
 1 file changed, 51 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -127,57 +127,6 @@ static int set_max_cstate(const struct d
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
