From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 04/30] ACPI-processor: Delete two unnecessary initialisations
 in acpi_processor_get_performance_states()
Date: Sat, 10 Sep 2016 11:41:32 +0200
Message-ID: <59c06f54-fb35-e457-dea9-19fb8950642e@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 11:48:52 +0200

The local variables "pss" and "status" will be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 49889b1..1ebe580 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -320,11 +320,11 @@ static void amd_fixup_frequency(struct acpi_processor_px *px, int i) {};
 static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
+	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer format = { sizeof("NNNNNN"), "NNNNNN" };
 	struct acpi_buffer state = { 0, NULL };
-	union acpi_object *pss = NULL;
+	union acpi_object *pss;
 	int i;
 	int last_invalid = -1;
 
-- 
2.10.0

