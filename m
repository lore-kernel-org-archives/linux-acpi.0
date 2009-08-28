From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 3/3] ACPI: EC: Drop orphan comment
Date: Fri, 28 Aug 2009 23:29:51 +0400
Message-ID: <20090828192951.19961.40354.stgit@thinkpad>
References: <20090828192938.19961.63714.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:34419 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752133AbZH1T3t (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 15:29:49 -0400
In-Reply-To: <20090828192938.19961.63714.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 829e62e..6ccb18b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -354,10 +354,6 @@ unlock:
 	return status;
 }
 
-/*
- * Note: samsung nv5000 doesn't work with ec burst mode.
- * http://bugzilla.kernel.org/show_bug.cgi?id=4980
- */
 static int acpi_ec_burst_enable(struct acpi_ec *ec)
 {
 	u8 d;

