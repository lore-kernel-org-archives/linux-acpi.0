From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 4/6] ec.c: Fix ACPI EC resume non-query interrupt message
Date: Sun, 12 Apr 2009 20:26:29 +0900
Message-ID: <1239535591-15514-5-git-send-email-malattia@linux.it>
References: <1239535591-15514-1-git-send-email-malattia@linux.it>
 <1239535591-15514-2-git-send-email-malattia@linux.it>
 <1239535591-15514-3-git-send-email-malattia@linux.it>
 <1239535591-15514-4-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:41434
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758619AbZDLL0d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 07:26:33 -0400
In-Reply-To: <1239535591-15514-4-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Almer S. Tigelaar" <almer@gnome.org>, Mattia Dongili <malattia@linux.it>, Alexey Starikovskiy <astarikovskiy@suse.de>

From: Almer S. Tigelaar <almer@gnome.org>

When resuming from standby (on a laptop) I see the following message in
my kernel.log:
"ACPI: EC: non-query interrupt received, switching to interrupt mode"
This apparently prevented sony-laptop to properly restore the brightness
level on resume.

The cause: In drivers/acpi/ec.c the acpi_ec_suspend function clears the
GPE mode bit, but this is not restored in acpi_ec_resume (the function
below it). The patch below fixes this by properly restoring the GPE_MODE
bit. Tested and confirmed to work.

Signed-off-by: Almer S. Tigelaar <almer@gnome.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ec.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 04e9044..391f331 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1065,6 +1065,7 @@ static int acpi_ec_resume(struct acpi_device *device)
 	struct acpi_ec *ec = acpi_driver_data(device);
 	/* Enable use of GPE back */
 	clear_bit(EC_FLAGS_NO_GPE, &ec->flags);
+	set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	acpi_enable_gpe(NULL, ec->gpe);
 	return 0;
 }
-- 
1.6.2.2

