From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/30] ACPI-processor: Improve two size determinations in
 acpi_processor_get_performance_states()
Date: Sat, 10 Sep 2016 11:36:41 +0200
Message-ID: <b24c70c2-7b8f-26e2-6ceb-7eab56a73a28@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:49529 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbcIJJgy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 05:36:54 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 11:11:12 +0200

Replace the specification of a data structure by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 78f9025..004e24c 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -358,7 +358,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 
 		struct acpi_processor_px *px = &(pr->performance->states[i]);
 
-		state.length = sizeof(struct acpi_processor_px);
+		state.length = sizeof(*px);
 		state.pointer = px;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
@@ -400,7 +400,8 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 				 * Copy this valid entry over last_invalid entry
 				 */
 				memcpy(&(pr->performance->states[last_invalid]),
-				       px, sizeof(struct acpi_processor_px));
+				       px,
+				       sizeof(*px));
 				++last_invalid;
 			}
 		}
-- 
2.10.0

