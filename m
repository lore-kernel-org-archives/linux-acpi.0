From: Alok Kataria <akataria@vmware.com>
Subject: Fix "buggy BIOS check" when CPUs are hot removed
Date: Fri, 04 Apr 2008 16:48:44 -0700
Message-ID: <1207352924.6294.29.camel@promb-2n-dhcp158.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.113.40.141]:49128 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242AbYDDXsp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Apr 2008 19:48:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Arai <arai@vmware.com>, Zachary Amsden <zach@vmware.com>

Fixes a BUG in ACPI hotplugging.

processor_device_array[pr->id] needs to be set to NULL when removing a
CPU. Else the "buggy BIOS check" in acpi_processor_start mistakenly
fires when a CPU is removed from the system and then later re-added.

Signed-off-by: Alok N Kataria <akataria@vmware.com>
Signed-off-by: Dan Arai <arai@vmware.com>

---
drivers/acpi/processor_core.c |    1 +
1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_core.c
b/drivers/acpi/processor_core.c
index 61450f4..0f95f26 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -828,6 +828,7 @@ static int acpi_processor_remove(struct acpi_device
*device, int type)
}

processors[pr->id] = NULL;
+ processor_device_array[pr->id] = NULL;

kfree(pr);

-- 
1.5.4


