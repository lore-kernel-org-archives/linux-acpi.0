From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPI: Do not try to set up acpi processor stuff on cores exceeding maxcpus=
Date: Wed, 26 May 2010 17:03:33 +0200
Message-ID: <1274886213-16337-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46331 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754797Ab0EZPDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 May 2010 11:03:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, travis@sgi.com, linux-acpi@vger.kernel.org, lenb@kernel.org

Patch is against latest Linus master branch and is expected to be
safe bug fix.

You get:
ACPI: HARDWARE addr space,NOT supported yet
for each ACPI defined CPU which status is active, but exceeds
maxcpus= count.

As these "not booted" CPUs do not run an idle routine
and echo X >/proc/acpi/processor/*/throttling did not work
I couldn't find a way to really access not onlined/booted
machines. Still this should get fixed and
/proc/acpi/processor/X dirs of cores exceeding maxcpus
should not show up.

I wonder whether this could get cleaned up by truncating possible cpu mask
and nr_cpu_ids to setup_max_cpus early some day
(and not exporting setup_max_cpus anymore then).
But this needs touching of a lot other places...

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: travis@sgi.com
CC: linux-acpi@vger.kernel.org
CC: lenb@kernel.org
---
 drivers/acpi/processor_driver.c |    5 +++++
 init/main.c                     |    4 +++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 5675d97..7615bc2 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -581,6 +581,11 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		return 0;
 	}
 
+#ifdef CONFIG_SMP
+	if (pr->id >= setup_max_cpus && pr->id != 0)
+		return 0;
+#endif
+
 	BUG_ON((pr->id >= nr_cpu_ids) || (pr->id < 0));
 
 	/*
diff --git a/init/main.c b/init/main.c
index 22881b5..fc104db 100644
--- a/init/main.c
+++ b/init/main.c
@@ -125,7 +125,9 @@ static char *ramdisk_execute_command;
 
 #ifdef CONFIG_SMP
 /* Setup configured maximum number of CPUs to activate */
-unsigned int __initdata setup_max_cpus = NR_CPUS;
+unsigned int setup_max_cpus = NR_CPUS;
+EXPORT_SYMBOL(setup_max_cpus);
+
 
 /*
  * Setup routine for controlling SMP activation
-- 
1.6.3

