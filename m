From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] ACPI: check mutex release status
Date: Mon, 26 Sep 2011 08:39:44 -0300
Message-ID: <1317037184.2697.1.camel@offbook>
Reply-To: dave@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Davidlohr Bueso <dave@gnu.org>

If this is not done we have a bogus ACPI_FAILURE() call.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 drivers/acpi/acpica/nsload.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 5f7dc69..f3070fd 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -115,7 +115,7 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 	}
 
       unlock:
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	status = acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
-- 
1.7.4.1
