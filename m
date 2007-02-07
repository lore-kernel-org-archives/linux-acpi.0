From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/140] ACPI: correct id for fixed buttons
Date: Wed,  7 Feb 2007 13:50:54 -0500
Message-ID: <11708744263395-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:31152 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422761AbXBGSx7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:59 -0500
In-Reply-To: <11708744253790-git-send-email-lenb@kernel.org>
Message-Id: <bfd80223d73f80e1d1c69dace9151756b3ef3b49.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

ACPI_BUTTON_HID_POWERF was changed, but this change was not propogated to
button.c, thus breaking detection of fixed power and sleep buttons.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 5ef885e..7fda02c 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -74,7 +74,7 @@ static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
 static struct acpi_driver acpi_button_driver = {
 	.name = ACPI_BUTTON_DRIVER_NAME,
 	.class = ACPI_BUTTON_CLASS,
-	.ids = "ACPI_FPB,ACPI_FSB,PNP0C0D,PNP0C0C,PNP0C0E",
+	.ids = "button_power,button_sleep,PNP0C0D,PNP0C0C,PNP0C0E",
 	.ops = {
 		.add = acpi_button_add,
 		.remove = acpi_button_remove,
-- 
1.5.0.rc3.39.gec804
