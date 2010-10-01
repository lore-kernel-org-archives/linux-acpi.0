From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPI: Remove unused #define ACPI_PROCESSOR_FILE_POWER
Date: Fri,  1 Oct 2010 10:54:53 +0200
Message-ID: <1285923293-31903-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38073 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab0JAIy4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Oct 2010 04:54:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Looks like a left over from /proc/acpi/processor/*/power which got removed

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Zhang Rui <rui.zhang@intel.com>
CC: Len Brown <len.brown@intel.com>
CC: <linux-acpi@vger.kernel.org>
---
 drivers/acpi/processor_idle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f4428e8..175c89a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -64,7 +64,6 @@
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
-#define ACPI_PROCESSOR_FILE_POWER	"power"
 #define PM_TIMER_TICK_NS		(1000000000ULL/PM_TIMER_FREQUENCY)
 #define C2_OVERHEAD			1	/* 1us */
 #define C3_OVERHEAD			1	/* 1us */
-- 
1.6.3

