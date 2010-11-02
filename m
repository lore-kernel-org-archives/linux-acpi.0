From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] intel_idle: Do not load if user overrides idle function via idle= boot param
Date: Tue, 2 Nov 2010 14:41:08 +0100
Message-ID: <201011021441.09258.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47628 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab0KBNlL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Nov 2010 09:41:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org

Hi Len,

I found that by review, it's compile tested only.
Could you give this a review and apply if appropriate.

Thanks,

     Thomas

----

if idle= boot param is passed, cpuidle drivers should not register
and only arch specific idle routines should get active.

Ideally cpuidle subsystem would be made aware of this.
But acpi parses sleep state tables before registering for cpuidle
which should not happen if idle= is passed.

-> Check for boot_option_idle_override in cpuidle drivers, not
cpuidle subsystem.

Compare with:
arch/x86/kernel/process.c
and
drivers/acpi/processor_idle.c

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
CC: stable@kernel.org
CC: linux-pm@lists.linux-foundation.org                                                                                                                               
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 41665d2..e50389b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -410,6 +410,9 @@ static int __init intel_idle_init(void)
 {
 	int retval;
 
+	if (boot_option_idle_override)
+		return -ENODEV;
+
 	retval = intel_idle_probe();
 	if (retval)
 		return retval;
