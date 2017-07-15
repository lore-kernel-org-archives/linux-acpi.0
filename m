From: Ryan Kennedy <ryan5544@gmail.com>
Subject: [PATCH] ACPI / watchdog: Fix init failure with overlapping register regions
Date: Sat, 15 Jul 2017 17:48:18 -0400
Message-ID: <20170715214818.24979-1-ryan5544@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36693 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdGOVsq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Jul 2017 17:48:46 -0400
Received: by mail-qt0-f193.google.com with SMTP id v31so14189082qtb.3
        for <linux-acpi@vger.kernel.org>; Sat, 15 Jul 2017 14:48:45 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, Ryan Kennedy <ryan5544@gmail.com>

Partially overlapping regions cause platform device creation
to fail. The latter of two overlapping resources will fail to be
reserved. Fix this by merging overlapping resource ranges while
enumerating WDAT table entries.

Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
---
 drivers/acpi/acpi_watchdog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 8c4e0a1..bf22c29 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -86,7 +86,12 @@ void __init acpi_watchdog_init(void)
 
 		found = false;
 		resource_list_for_each_entry(rentry, &resource_list) {
-			if (resource_contains(rentry->res, &res)) {
+			if (rentry->res->flags == res.flags &&
+			    resource_overlaps(rentry->res, &res)) {
+				if (res.start < rentry->res->start)
+					rentry->res->start = res.start;
+				if (res.end > rentry->res->end)
+					rentry->res->end = res.end;
 				found = true;
 				break;
 			}
-- 
2.9.4

