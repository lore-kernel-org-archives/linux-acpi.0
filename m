From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 3/4] ACPI / APEI: Drop uninformative messages during boot
Date: Thu, 20 Jul 2017 12:04:01 +0100
Message-ID: <20170720110402.15313-4-punit.agrawal@arm.com>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720110402.15313-1-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Punit Agrawal <punit.agrawal@arm.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>
List-Id: linux-acpi@vger.kernel.org

When booting an ACPI enabled system that does not provide the hardware
error source table (HEST), the ghes driver prints the following message
in the kernel log -

[    3.460067] GHES: HEST is not enabled!

which is not helpful.

The message is also output when HEST is explicitly disabled using kernel
command line parameter.

Drop this message. While we are touching this code, also drop similar
message when GHES is disabled using the module parameter.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d452b238..3ddd1bd714fc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1265,15 +1265,8 @@ static int __init ghes_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (hest_disable) {
-		pr_info(GHES_PFX "HEST is not enabled!\n");
+	if (hest_disable || ghes_disable)
 		return -EINVAL;
-	}
-
-	if (ghes_disable) {
-		pr_info(GHES_PFX "GHES is not enabled!\n");
-		return -EINVAL;
-	}
 
 	ghes_nmi_init_cxt();
 
-- 
2.11.0
