From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 11/30] ACPI-processor: Delete two unnecessary initialisations
 in acpi_processor_get_performance_control()
Date: Sat, 10 Sep 2016 11:52:57 +0200
Message-ID: <29792aed-58b9-00a6-f7ca-fff86f35f7d6@users.sourceforge.net>
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
Date: Tue, 6 Sep 2016 19:01:36 +0200

The local variables "pct" and "status" will be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 3a48c3a..07e5e59 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -223,9 +223,9 @@ void acpi_processor_ppc_exit(void)
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 {
 	int result = 0;
-	acpi_status status = 0;
+	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *pct = NULL;
+	union acpi_object *pct;
 	union acpi_object obj = { 0 };
 
 
-- 
2.10.0
