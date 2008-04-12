From: Len Brown <lenb@kernel.org>
Subject: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
Date: Sat, 12 Apr 2008 00:25:53 -0400
Message-ID: <16ff5d276b6f17288051f32accdbd675242e5282.1207973801.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:11821 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756908AbYDLE2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:16 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented another change to eliminate/suppress spurious or
stray GPEs. The AcpiEvDisableGpe function will now disable GPEs
that are neither enabled nor disabled -- meaning that the GPE is
unknown to the system. This will prevent future interrupts from
that GPE. (Zhang Rui) BZ 6217

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpe.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index 897baed..6940f5d 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -250,7 +250,14 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	ACPI_FUNCTION_TRACE(ev_disable_gpe);
 
-	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
+	/*
+	 * Ignore this if the GPE is valid and not enabled.
+	 *
+	 * Flags is only zero if GPE is neither enabled or disabled -- it may
+	 * be a spurious or stray GPE -- disable it in the default case below.
+	 */
+	if (gpe_event_info->flags &&
+	    (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK))) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
-- 
1.5.5.29.g7134

