From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/31] ACPICA: Resources: Correct conditional compilation definitions.
Date: Mon, 13 Apr 2015 11:49:47 +0800
Message-ID: <3925034ece2ef45ead389c4931c26b203c59e6bd.1428893937.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit f92a08512b0b35dce4a7fc6a73216674a3c2541b

Some conditional compilation definitions are wrong across header and source
files. This patch corrects them for the resources component.

NOTE that a further patch in this patchset cleans up all ACPI_EXEC_APP,
converting them into ACPI_DEBUGGER, including part of this change.

Link: https://github.com/acpica/acpica/commit/f92a0851
Reported-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acresrc.h |    2 ++
 drivers/acpi/acpica/rsdump.c  |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index 959be91..ac20b9d 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -301,9 +301,11 @@ acpi_rs_set_resource_length(acpi_rsdesc_size total_length,
 /*
  * rsdump
  */
+#ifdef ACPI_EXEC_APP
 void acpi_rs_dump_resource_list(struct acpi_resource *resource);
 
 void acpi_rs_dump_irq_list(u8 *route_table);
+#endif
 
 /*
  * Resource conversion tables
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 8d4f262..6d588d4 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -355,6 +355,7 @@ static void acpi_rs_dump_address_common(union acpi_resource_data *resource)
 	acpi_rs_dump_descriptor(resource, acpi_rs_dump_general_flags);
 }
 
+#ifdef ACPI_EXEC_APP
 /*******************************************************************************
  *
  * FUNCTION:    acpi_rs_dump_resource_list
@@ -464,6 +465,7 @@ void acpi_rs_dump_irq_list(u8 *route_table)
 					   prt_element, prt_element->length);
 	}
 }
+#endif
 
 /*******************************************************************************
  *
-- 
1.7.10
