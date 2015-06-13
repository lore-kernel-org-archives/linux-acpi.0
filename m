From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 08/12] ACPI / HED: constify ACPI device ids
Date: Sat, 13 Jun 2015 14:26:56 +0200
Message-ID: <1434198420-8519-9-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33953 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbbFMM1U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:20 -0400
Received: by wgv5 with SMTP id 5so39179513wgv.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:19 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

Constify the acpi_hed_ids[] ACPI device IDs array -- no need to have it
writeable.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/hed.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index aafe3ca829c2..a322710b5ba4 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -27,7 +27,7 @@
 #include <linux/acpi.h>
 #include <acpi/hed.h>
 
-static struct acpi_device_id acpi_hed_ids[] = {
+static const struct acpi_device_id acpi_hed_ids[] = {
 	{"PNP0C33", 0},
 	{"", 0},
 };
-- 
1.7.10.4

