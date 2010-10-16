From: Len Brown <lenb@kernel.org>
Subject: [2.6.35.stable] ACPI: Handle ACPI0007 Device in acpi_early_set_pdc
Date: Fri, 15 Oct 2010 22:12:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010152210530.2971@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:57065 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab0JPCMf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Oct 2010 22:12:35 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAD00AWX24Y5FT4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 15 Oct 2010 21:12:35 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>

upstream c1e0ddbf0a97e1704d7f13b4934f9acca002402d


After
| commit d8191fa4a33fdc817277da4f2b7f771ff605a41c
| Author: Alex Chiang <achiang@hp.com>
| Date:   Mon Feb 22 12:11:39 2010 -0700
|
|    ACPI: processor: driver doesn't need to evaluate _PDC
|
|    Now that the early _PDC evaluation path knows how to correctly
|    evaluate _PDC on only physically present processors, there's no
|    need for the processor driver to evaluate it later when it loads.
|
|    To cover the hotplug case, push _PDC evaluation down into the
|    hotplug paths.

only cpu with Processor Statement get processed with _PDC

If bios is using Device object instead of Processor statement.
SSDTs for Pstate/Cstate/Tstate can not be loaded dynamically.

Need to try to scan ACPI0007 in addition to Processor.

That commit is between 2.6.34-rc1 and 2.6.34-rc2, so stable tree for 2.6.34+
need this patch.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index e9699aa..df6e167 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -352,4 +352,5 @@ void __init acpi_early_processor_set_pdc(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    early_init_pdc, NULL, NULL, NULL);
+	acpi_get_devices("ACPI0007", early_init_pdc, NULL, NULL);
 }
-- 
1.7.3.1.120.g38a18

