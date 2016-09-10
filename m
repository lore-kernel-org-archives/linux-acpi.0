From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 28/30] ACPI-processor: Rename a jump label in
 acpi_processor_get_platform_limit()
Date: Sat, 10 Sep 2016 12:10:37 +0200
Message-ID: <5db577f7-d95a-4af5-15a5-5d63734824f4@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:54149 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755210AbcIJKKr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 06:10:47 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 21:50:04 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index d22bcfc..7e54a83 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -294,7 +294,7 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 		return -EINVAL;
 
 	if (ignore_tpc)
-		goto end;
+		goto limit_throttling;
 
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
 	if (ACPI_FAILURE(status)) {
@@ -303,8 +303,7 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 		}
 		return -ENODEV;
 	}
-
-end:
+ limit_throttling:
 	pr->throttling_platform_limit = (int)tpc;
 	return 0;
 }
-- 
2.10.0

