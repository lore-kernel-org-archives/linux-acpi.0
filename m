From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/12] ACPI: fix section mismatch in processor_core.c:acpi_processor_hotplug_notify
Date: Tue, 11 Mar 2008 02:51:38 -0400
Message-ID: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:14880 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751392AbYCKGyx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:53 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Len Brown <len.brown@intel.com>

From: Sam Ravnborg <sam@ravnborg.org>

Fix following warning:
WARNING: vmlinux.o(.text+0x55586c): Section mismatch in reference from the function acpi_processor_hotplug_notify() to the function .cpuinit.text:acpi_processor_start()

acpi_processor_hotplug_notify() may safely reference __cpuinit
stuff as it ids defined inside an ACPI_HOTPLUG_CPU block.
So annotate it __ref to silence the warning.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 75ccf5d..d3cc07f 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -881,8 +881,8 @@ int acpi_processor_device_add(acpi_handle handle, struct acpi_device **device)
 	return 0;
 }
 
-static void
-acpi_processor_hotplug_notify(acpi_handle handle, u32 event, void *data)
+static void __ref acpi_processor_hotplug_notify(acpi_handle handle,
+						u32 event, void *data)
 {
 	struct acpi_processor *pr;
 	struct acpi_device *device = NULL;
-- 
1.5.4.3.422.g34cd6

