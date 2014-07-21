From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v3 09/14] ACPI/EC: Add CPU ID to debugging messages.
Date: Mon, 21 Jul 2014 14:06:03 +0800
Message-ID: <0df1aae6d110e053dfe2df7377e5c938d4bbf076.1405922585.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1405922585.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1405922585.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds CPU ID to the context entries' debugging output. no
functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a729f31..065aabc 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -286,7 +286,8 @@ static bool advance_transaction(struct acpi_ec *ec)
 	u8 status;
 	bool wakeup = false;
 
-	pr_debug("===== %s =====\n", in_interrupt() ? "IRQ" : "TASK");
+	pr_debug("===== %s (%d) =====\n",
+		 in_interrupt() ? "IRQ" : "TASK", smp_processor_id());
 	status = acpi_ec_read_status(ec);
 	t = ec->curr;
 	if (!t)
-- 
1.7.10
