From: Bartlomiej Swiercz <swierczu@dmcs.p.lodz.pl>
Subject: Patch for ThinkPad R40e
Date: Mon, 29 May 2006 13:16:28 +0200
Message-ID: <1148901389.4554.13.camel@lap>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-a18G4VZxeyHtT/yCa0YE"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.dmcs.p.lodz.pl ([212.51.219.1]:6043 "EHLO
	mail.dmcs.p.lodz.pl") by vger.kernel.org with ESMTP
	id S1750827AbWE2LP7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 May 2006 07:15:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


--=-a18G4VZxeyHtT/yCa0YE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

This very simple and obvious patch for the ThinkPad R40e with the latest
bios version. This patch adds entry for the latest bios version to the
processor_power_dmi_table[] table (file:
drivers/acpi/processor_idle.c). 

-- 
Pozdrawiam/Regards,
Bartlomiej Swiercz

--=-a18G4VZxeyHtT/yCa0YE
Content-Disposition: attachment; filename=acpi_thinkpad_r40e.patch
Content-Type: text/x-patch; name=acpi_thinkpad_r40e.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- linux/drivers/acpi/processor_idle.c.orig	2006-05-22 20:04:35.000000000 +0200
+++ linux/drivers/acpi/processor_idle.c	2006-05-29 01:10:31.000000000 +0200
@@ -99,6 +99,9 @@ static int set_max_cstate(struct dmi_sys
 static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET70WW")}, (void *)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),

--=-a18G4VZxeyHtT/yCa0YE--

