From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 15/30] ACPI-processor: Delete an unnecessary initialisation in
 acpi_processor_get_platform_limit()
Date: Sat, 10 Sep 2016 11:57:03 +0200
Message-ID: <042b1648-3d48-96ef-7d32-d0ce620700aa@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 19:12:06 +0200

The local variable "status" will be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index de82338..bab5a564d 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -112,7 +112,7 @@ static struct notifier_block acpi_ppc_notifier_block = {
 
 static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
-	acpi_status status = 0;
+	acpi_status status;
 	unsigned long long ppc = 0;
 
 
-- 
2.10.0
