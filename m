From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/11] ACPI: fix suspend regression due to idle update
Date: Thu, 14 Feb 2008 02:02:22 -0500
Message-ID: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:21951 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755674AbYBNHKm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:42 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Earlier patch (bc71bec91f9875ef825d12104acf3bf4ca215fa4) broke
suspend resume on many laptops. The problem was reported by
Carlos R. Mafra and Calvin Walton, who bisected the issue to above patch.

The problem was because, C2 and C3 code were calling acpi_idle_enter_c1
directly, with C2 or C3 as state parameter, while suspend/resume was in
progress. The patch bc71bec started making use of that state information,
assuming that it would always be referring to C1 state. This caused the
problem with suspend-resume as we ended up using C2/C3 state indirectly.

Fix this by adding acpi_idle_suspend check in enter_c1.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 32003fd..1f022b0 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1420,6 +1420,14 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 		return 0;
 
 	local_irq_disable();
+
+	/* Do not access any ACPI IO ports in suspend path */
+	if (acpi_idle_suspend) {
+		acpi_safe_halt();
+		local_irq_enable();
+		return 0;
+	}
+
 	if (pr->flags.bm_check)
 		acpi_idle_update_bm_rld(pr, cx);
 
-- 
1.5.4.1.122.gaa8d

