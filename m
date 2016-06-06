From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Namespace: Fix wrong cleanup code in acpi_ns_execute_table()
Date: Mon,  6 Jun 2016 18:26:03 +0800
Message-ID: <71c3504e656f59305c4f3fba98a476e3cc46a0f3.1465208705.git.lv.zheng@intel.com>
References: <20160604140415.GA3344@mwanda>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160604140415.GA3344@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

An error was captured by the static checker. This patch fixes the issue.
introduced in:
  Subject: ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by switching to
           new TermList grammar for table loading

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsparse.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 2452bf3..72893a9 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -135,10 +135,12 @@ acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node *start_node)
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 
 cleanup:
-	acpi_ut_remove_reference(method_obj);
-	ACPI_FREE(info->full_pathname);
-	info->full_pathname = NULL;
+	if (info) {
+		ACPI_FREE(info->full_pathname);
+		info->full_pathname = NULL;
+	}
 	ACPI_FREE(info);
+	acpi_ut_remove_reference(method_obj);
 	return_ACPI_STATUS(status);
 }
 
-- 
1.7.10
