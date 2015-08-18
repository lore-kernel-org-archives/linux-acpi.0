From: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
Subject: [RFC] ACPICA: save a function call
Date: Tue, 18 Aug 2015 22:07:43 +0800
Message-ID: <1439906863-5681-1-git-send-email-yizhouzhou@ict.ac.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lv.zheng@intel.com, robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
List-Id: linux-acpi@vger.kernel.org

In function acpi_ps_build_named_op, the if statement
in line 221 ensure the argument status to function call
acpi_ps_next_parse_state has the value 0, while 
acpi_ps_next_parse_state do not change any global state
when called with callback_status==0.

I think following lines should be removed to save some CPU 
cycles because the compilers won't do it (the callee
is defined in another compiling unit, so it can't be inlined).  


Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>

---
 drivers/acpi/acpica/psobject.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 2f5ddd8..4ff6530 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -230,14 +230,6 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 	}
 
-	status = acpi_ps_next_parse_state(walk_state, *op, status);
-	if (ACPI_FAILURE(status)) {
-		if (status == AE_CTRL_PENDING) {
-			status = AE_CTRL_PARSE_PENDING;
-		}
-		return_ACPI_STATUS(status);
-	}
-
 	acpi_ps_append_arg(*op, unnamed_op->common.value.arg);
 
 	if ((*op)->common.aml_opcode == AML_REGION_OP ||
-- 
1.7.10.4
