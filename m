From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH] acpi/apei: Fix in-correct return value
Date: Tue, 18 Oct 2016 17:07:19 +0100
Message-ID: <20161018160719.31252-1-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, tbaicar@codeaurora.org, bp@suse.de, Punit Agrawal <punit.agrawal@arm.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Although ghes_proc tests for error while reading the error status, it
always return success (0). Fix this by propagating the return value.

Fixes: d334a49113a4a33 ("ACPI, APEI, Generic Hardware Error Source memory error support")
Signed-of-by: Punit Agrawal <punit.agrawa.@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0a029e..0d099a2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -662,7 +662,7 @@ static int ghes_proc(struct ghes *ghes)
 	ghes_do_proc(ghes, ghes->estatus);
 out:
 	ghes_clear_estatus(ghes);
-	return 0;
+	return rc;
 }
 
 static void ghes_add_timer(struct ghes *ghes)
-- 
2.9.3
