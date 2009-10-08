From: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
Subject: [PATH][RESUBMITTING] fixing harmless warning about __cpuinit in
	processor_idle.c
Date: Thu, 8 Oct 2009 13:27:53 -0700
Message-ID: <b92cb9ab0910081327u6fb1eex84537620c4aa421b__23758.1402565867$1255033934$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:32939 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757562AbZJHU2a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Oct 2009 16:28:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mathieu.rondonneau@gmail.com, rostedt <rostedt@goodmis.org>, fweisbec <fweisbec@gmail.com>, mingo <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-ac>

fix harmless warnings that causes compiler warning:

WARNING: drivers/acpi/built-in.o(.text+0x21945): Section mismatch in
reference from the function acpi_processor_add() to the function
.cpuinit.text:acpi_processor_power_init()
The function acpi_processor_add() references
the function __cpuinit acpi_processor_power_init().

change files: driver/acpi/processor_idle.c

Signed-off-by: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
---
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bbd066e..166457a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -105,7 +105,7 @@ static int set_max_cstate(const struct dmi_system_id *id)

 /* Actually this shouldn't be __cpuinitdata, would be better to fix the
    callers to only run once -AK */
-static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
+static struct dmi_system_id processor_power_dmi_table[] = {
        { set_max_cstate, "Clevo 5600D", {
          DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
          DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
@@ -1158,7 +1158,7 @@ int acpi_processor_cst_has_changed(struct
acpi_processor *pr)
        return ret;
 }

-int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
+int acpi_processor_power_init(struct acpi_processor *pr,
                              struct acpi_device *device)
 {
        acpi_status status = 0;
