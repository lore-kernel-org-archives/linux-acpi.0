From: akpm@osdl.org
Subject: [patch 12/18] acpi: Add IBM R60E laptop to proc-idle blacklist
Date: Sat, 24 Jun 2006 16:37:00 -0700
Message-ID: <200606242337.k5ONb1xG008077@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:37532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751252AbWFXXpL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:45:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, randy.dunlap@oracle.com, bcollins@ubuntu.com, luming.yu@intel.com


From: Randy Dunlap <randy.dunlap@oracle.com>

Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/38228
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commit;h=ce5e62bc55056049d192c422b6032f6a406e0ba2

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN drivers/acpi/processor_idle.c~acpi-add-ibm-r60e-laptop-to-proc-idle-blacklist drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-add-ibm-r60e-laptop-to-proc-idle-blacklist
+++ a/drivers/acpi/processor_idle.c
@@ -142,6 +142,9 @@ static struct dmi_system_id __cpuinitdat
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
 	{ set_max_cstate, "Medion 41700", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
_
