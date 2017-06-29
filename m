From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / osi: make local function acpi_osi_dmi_linux static
Date: Thu, 29 Jun 2017 10:49:25 +0100
Message-ID: <20170629094925.10884-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60233 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdF2Jt2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jun 2017 05:49:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function acpi_osi_dmi_linux is local and does not need to be in
global scope, so make it static.

Cleans up sparse warning:
"symbol 'acpi_osi_dmi_linux' was not declared. Should it be static?"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/osi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 849f9d2245ca..723bee58bbcf 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -265,7 +265,8 @@ static void __init acpi_osi_dmi_darwin(bool enable,
 	__acpi_osi_setup_darwin(enable);
 }
 
-void __init acpi_osi_dmi_linux(bool enable, const struct dmi_system_id *d)
+static void __init acpi_osi_dmi_linux(bool enable,
+				      const struct dmi_system_id *d)
 {
 	pr_notice("DMI detected to setup _OSI(\"Linux\"): %s\n", d->ident);
 	osi_config.linux_dmi = 1;
-- 
2.11.0

