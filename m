From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH] ACPI, APEI: Remove X86 redundant dependency for APEI Generic Hardware Error Source.
Date: Mon, 10 Feb 2014 17:23:36 +0100
Message-ID: <1392049416-31240-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:48415 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbaBJQXa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Feb 2014 11:23:30 -0500
Received: by mail-ee0-f54.google.com with SMTP id e53so3083941eek.13
        for <linux-acpi@vger.kernel.org>; Mon, 10 Feb 2014 08:23:29 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

ACPI_APEI is already dependent on X86, hence, there is no need to
define such dependency for ACPI_APEI_GHES again.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/apei/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 786294b..1d7ca6e 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -13,7 +13,7 @@ config ACPI_APEI
 
 config ACPI_APEI_GHES
 	bool "APEI Generic Hardware Error Source"
-	depends on ACPI_APEI && X86
+	depends on ACPI_APEI
 	select ACPI_HED
 	select IRQ_WORK
 	select GENERIC_ALLOCATOR
-- 
1.7.9.5

