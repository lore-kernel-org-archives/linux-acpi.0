From: Johann Felix Soden <johfel@gmx.de>
Subject: [PATCH] buffer array one byte too short in drivers/acpi/system.c
Date: Thu, 06 Mar 2008 15:30:53 +0100
Message-ID: <1204813853.25336.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39008 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759709AbYCFOa7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Mar 2008 09:30:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

From: Johann Felix Soden <johfel@users.sourceforge.net>

Since "ff_gbl_lock" has a length of 10 chars and is copied with sprintf to
char buffer[10], there is a problem because of the closing zero byte. We
need char buffer[11].

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
---
 drivers/acpi/system.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 55cf4c0..037b679 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -319,7 +319,7 @@ void acpi_irq_stats_init(void)
 		goto fail;
 
 	for (i = 0; i < num_counters; ++i) {
-		char buffer[10];
+		char buffer[11];
 		char *name;
 
 		if (i < num_gpes)
-- 
1.5.4.3



