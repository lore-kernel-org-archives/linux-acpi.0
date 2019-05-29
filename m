Return-Path: <SRS0=p9Ck=T5=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D76C28CC0
	for <linux-acpi@archiver.kernel.org>; Wed, 29 May 2019 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D8021670
	for <linux-acpi@archiver.kernel.org>; Wed, 29 May 2019 12:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfE2MZf (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 29 May 2019 08:25:35 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:53044 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfE2MZf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 May 2019 08:25:35 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 08:25:34 EDT
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 03DE24BDAE;
        Wed, 29 May 2019 14:18:39 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
Date:   Wed, 29 May 2019 14:18:20 +0200
Message-Id: <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If an ACPI SSDT overlay is loaded after built-in tables
have been loaded e.g. via configfs or efivar_ssdt_load()
it is necessary to rewalk the namespace to resolve
references. Without this, relative and absolute paths
like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
correctly.

Make configfs load use the same method as efivar_ssdt_load().

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/acpi/acpi_configfs.c   |  6 +-----
 drivers/acpi/acpica/tbxfload.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index f92033661239..663f0d88f912 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -56,11 +56,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
 	if (!table->header)
 		return -ENOMEM;
 
-	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
-	ret = acpi_tb_install_and_load_table(
-			ACPI_PTR_TO_PHYSADDR(table->header),
-			ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
-			&table->index);
+	ret = acpi_load_table(table->header);
 	if (ret) {
 		kfree(table->header);
 		table->header = NULL;
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 4f30f06a6f78..61f2d46e52ba 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
 						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
 						FALSE, &table_index);
+
+	if (!ACPI_FAILURE(status)) {
+		/* Complete the initialization/resolution of package objects */
+
+		status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE,
+						ACPI_ROOT_OBJECT,
+						ACPI_UINT32_MAX, 0,
+						acpi_ns_init_one_package,
+						NULL, NULL, NULL);
+	}
+
 	return_ACPI_STATUS(status);
 }
 
-- 
2.17.1

