From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/15] ACPICA: ACPI 6.0/iASL: Add support for the External AML opcode
Date: Fri, 19 Feb 2016 14:16:49 +0800
Message-ID: <5b32cad1ac2c9b90d9819f08431e5f8a944edf00.1455857583.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit 882892feeafe8b8e5be10463133405cd4f1309d9

Support for both the compiler and disassembler.
Also, the interpreter will ignore this opcode if it
is ever encountered (should not happen).
David Box.

Link: https://github.com/acpica/acpica/commit/882892fe
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exoparg3.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 28eb861..5aa21c4 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -123,8 +123,10 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 		 * op is intended for use by disassemblers in order to properly
 		 * disassemble control method invocations. The opcode or group of
 		 * opcodes should be surrounded by an "if (0)" clause to ensure that
-		 * AML interpreters never see the opcode.
+		 * AML interpreters never see the opcode. Thus, something is
+		 * wrong if an external opcode ever gets here.
 		 */
+		ACPI_ERROR((AE_INFO, "Executed External Op"));
 		status = AE_OK;
 		goto cleanup;
 
-- 
1.7.10
