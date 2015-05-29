From: Gong Zhaogang <gongzhaogang@inspur.com>
Subject: [PATCH] The same content in the comment appear twice.
Date: Fri, 29 May 2015 17:04:57 +0800
Message-ID: <1432890297-32057-1-git-send-email-gongzhaogang@inspur.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m50-110.126.com ([123.125.50.110]:51086 "EHLO m50-110.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbbE2JFf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 May 2015 05:05:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yanxiaofeng@inspur.com, wunan@inspur.com, gongzhaogang <gongzhaogang@inspur.com>

From: gongzhaogang <gongzhaogang@inspur.com>

Delete the extra content in the comment.
 return_object   - Where to put method's return value (if
	  	   any). If NULL, no value is returned.

Signed-off-by: Gong Zhaogang <gongzhaogang@inspur.com>
---
 drivers/acpi/acpica/nseval.c | 2 --
 1 file changed, 2 deletions(-)

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
1.9.1


