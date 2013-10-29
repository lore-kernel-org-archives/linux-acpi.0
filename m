From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI: Fix spelling mistake in error messages
Date: Tue, 29 Oct 2013 10:34:19 +0000
Message-ID: <1383042859-22683-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56752 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab3J2KeW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Oct 2013 06:34:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix spelling mistake "expecing" --> "expecting"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 552248b..c537f40 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -121,7 +121,7 @@ acpi_extract_package(union acpi_object *package,
 				break;
 			default:
 				printk(KERN_WARNING PREFIX "Invalid package element"
-					      " [%d]: got number, expecing"
+					      " [%d]: got number, expecting"
 					      " [%c]\n",
 					      i, format_string[i]);
 				return AE_BAD_DATA;
@@ -148,7 +148,7 @@ acpi_extract_package(union acpi_object *package,
 			default:
 				printk(KERN_WARNING PREFIX "Invalid package element"
 					      " [%d] got string/buffer,"
-					      " expecing [%c]\n",
+					      " expecting [%c]\n",
 					      i, format_string[i]);
 				return AE_BAD_DATA;
 				break;
-- 
1.8.3.2

