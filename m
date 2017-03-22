From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/3] ACPI: Don't create a platform_device for IOAPIC/IOxAPIC
Date: Wed, 22 Mar 2017 18:33:25 +0100
Message-ID: <1490204005-2733-4-git-send-email-joro@8bytes.org>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:40666 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935430AbdCVRdh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:37 -0400
In-Reply-To: <1490204005-2733-1-git-send-email-joro@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>

From: Joerg Roedel <jroedel@suse.de>

No platform-device is required for IO(x)APICs, so don't even
create them.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/acpi_platform.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index b4c1a6a..03250e1 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -25,9 +25,11 @@
 ACPI_MODULE_NAME("platform");
 
 static const struct acpi_device_id forbidden_id_list[] = {
-	{"PNP0000", 0},	/* PIC */
-	{"PNP0100", 0},	/* Timer */
-	{"PNP0200", 0},	/* AT DMA Controller */
+	{"PNP0000",  0},	/* PIC */
+	{"PNP0100",  0},	/* Timer */
+	{"PNP0200",  0},	/* AT DMA Controller */
+	{"ACPI0009", 0},	/* IOxAPIC */
+	{"ACPI000A", 0},	/* IOAPIC */
 	{"", 0},
 };
 
-- 
1.9.1

