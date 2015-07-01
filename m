From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 25/26] ACPICA: Comment update, no functional change.
Date: Wed,  1 Jul 2015 14:45:38 +0800
Message-ID: <aa13d3ba2bd0ddfe6f298d551bc92dab0c8d4efa.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49521 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692AbbGAGpp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:45:45 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, gongzg <gongzhaogang@inspur.com>, Bob Moore <robert.moore@intel.com>

From: gongzg <gongzhaogang@inspur.com>

ACPICA commit 1a8ec7b83d55c7b957247d685bd1c73f6a012f1e

Remove redundant comment in nseval.c

Link: https://github.com/acpica/acpica/commit/1a8ec7b8
Signed-off-by: gongzg <gongzhaogang@inspur.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nseval.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index a725d88..80670cb 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -59,15 +59,14 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
  *
  * FUNCTION:    acpi_ns_evaluate
  *
- * PARAMETERS:  info            - Evaluation info block, contains:
+ * PARAMETERS:  info            - Evaluation info block, contains these fields
+ *                                and more:
  *                  prefix_node     - Prefix or Method/Object Node to execute
  *                  relative_path   - Name of method to execute, If NULL, the
  *                                    Node is the object to execute
  *                  parameters      - List of parameters to pass to the method,
  *                                    terminated by NULL. Params itself may be
  *                                    NULL if no parameters are being passed.
- *                  return_object   - Where to put method's return value (if
- *                                    any). If NULL, no value is returned.
  *                  parameter_type  - Type of Parameter list
  *                  return_object   - Where to put method's return value (if
  *                                    any). If NULL, no value is returned.
-- 
1.7.10

