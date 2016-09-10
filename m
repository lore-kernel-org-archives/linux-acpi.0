From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 14/30] ACPI-processor: Delete an unnecessary initialisation in
 acpi_processor_get_performance_info()
Date: Sat, 10 Sep 2016 11:56:15 +0200
Message-ID: <bf13507b-b985-11a5-5b70-4441077968af@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:65502 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755513AbcIJJ4Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 05:56:25 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 19:09:32 +0200

The local variable "result" will be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 43f8eef..de82338 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -423,7 +423,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 
 int acpi_processor_get_performance_info(struct acpi_processor *pr)
 {
-	int result = 0;
+	int result;
 
 	if (!pr || !pr->performance || !pr->handle)
 		return -EINVAL;
-- 
2.10.0

