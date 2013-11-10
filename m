From: al.stone@linaro.org
Subject: [PATCH 12/12] ACPI: correct #ifdef so compilation without ACPI_REDUCED_HARDWARE works
Date: Sat,  9 Nov 2013 18:36:22 -0700
Message-ID: <1384047382-20623-13-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:43284 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758586Ab3KJBgp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:45 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so5857616iec.13
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:44 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f41949a..e868de3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -513,7 +513,7 @@ void __init acpi_early_init(void)
 
 	acpi_gbl_permanent_mmap = 1;
 
-#if !(CONFIG_ARM || CONFIG_ARM64)
+#if !(defined(CONFIG_ARM) || defined(CONFIG_ARM64))
 	/*
 	 * NB: ARM does not use DMI at present.
 	 *
@@ -544,7 +544,7 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-#if (!CONFIG_ACPI_REDUCED_HARDWARE)
+#if !(defined(CONFIG_ARM) || defined(CONFIG_ARM64)) && (!ACPI_REDUCED_HARDWARE)
 	/* NB: in HW reduced mode, FADT sci_interrupt has no meaning */
 	if (!acpi_ioapic) {
 		/* compatible (0) means level (3) */
-- 
1.8.3.1

