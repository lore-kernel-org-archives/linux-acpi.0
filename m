From: gongzg <gongzhaogang@inspur.com>
Subject: [PATCH] The same content in the comment appear twice.
Date: Tue, 16 Jun 2015 10:32:43 -0400
Message-ID: <1434465163-22873-1-git-send-email-gongzhaogang@inspur.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: yanxiaofeng@inspur.com, gongzhaogang <gongzhaogang@inspur.com>
List-Id: linux-acpi@vger.kernel.org

From: gongzhaogang <gongzhaogang@inspur.com>

Delect the extra content in the comment.
 return_object   - Where to put method's return value (if
	  	   any). If NULL, no value is returned.
---
 drivers/acpi/acpica/nseval.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 7bcc68f..82e2eef 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -69,8 +69,6 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
  *                  return_object   - Where to put method's return value (if
  *                                    any). If NULL, no value is returned.
  *                  parameter_type  - Type of Parameter list
- *                  return_object   - Where to put method's return value (if
- *                                    any). If NULL, no value is returned.
  *                  flags           - ACPI_IGNORE_RETURN_VALUE to delete return
  *
  * RETURN:      Status
-- 
1.7.1
