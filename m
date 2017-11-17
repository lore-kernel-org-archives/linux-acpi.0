From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 08/11] ACPICA: iASL: change processing of external op namespace nodes for correctness
Date: Fri, 17 Nov 2017 15:40:21 -0800
Message-ID: <20171117234024.833-9-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29666 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759270AbdKQXp0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:26 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

ACPICA commit aa866a9b4f24bbec9f158d10325b486d7d12d90f

The declaration External (ABCD.EFGH) creates two nodes in the namespace: ABCD
and EFGH where ABCD is marked as an implicit external node. ABCD is labeled as
implicit because there does not exist a specific External (ABCD) declaration.

Before this change, the declaration External (ABCD.EFGH) and
External (ABCD.EFGH.IJKL) creates the namespace nodes ABCD, EFGH, and IJKL
where ABCD and EFGH are labeled as implicit external nodes. This is incorrect.
The only implicit node should be ABCD because EFGH and IJKL are explicit nodes.
This change fixes the labeling procecess of external op namespace nodes so that
nodes are properly labeled as implicit external.

Due to this commit, the below ASL code results in a compilation error.

definition_block ("DSDT.aml", "DSDT", 0x02, "INTEL", "BDW    ", 0x0)
{
    External(\_SB.PCI0.GFX0, device_obj)
    External(\_SB.PCI0.GFX0.ALSI)

    Scope(\_SB)
    {
        Device(PCI0)
        {
            Device(GFX0)
            {
                Name(_ADR, 0x00020000)
            }
        }
    }
}

Link: https://github.com/acpica/acpica/commit/aa866a9b
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsaccess.c | 13 +++++++------
 drivers/acpi/acpica/nssearch.c |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index f2733f51ca8d..33e652a12fca 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -644,17 +644,18 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 					    this_node->object;
 				}
 			}
-#ifdef ACPI_ASL_COMPILER
-			if (!acpi_gbl_disasm_flag &&
-			    (this_node->flags & ANOBJ_IS_EXTERNAL)) {
-				this_node->flags |= IMPLICIT_EXTERNAL;
-			}
-#endif
 		}
 
 		/* Special handling for the last segment (num_segments == 0) */
 
 		else {
+#ifdef ACPI_ASL_COMPILER
+			if (!acpi_gbl_disasm_flag
+			    && (this_node->flags & ANOBJ_IS_EXTERNAL)) {
+				this_node->flags &= ~IMPLICIT_EXTERNAL;
+			}
+#endif
+
 			/*
 			 * Sanity typecheck of the target object:
 			 *
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 5de8957f5ef0..e91dbee9235f 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -417,6 +417,7 @@ acpi_ns_search_and_enter(u32 target_name,
 	if (flags & ACPI_NS_EXTERNAL ||
 	    (walk_state && walk_state->opcode == AML_SCOPE_OP)) {
 		new_node->flags |= ANOBJ_IS_EXTERNAL;
+		new_node->flags |= IMPLICIT_EXTERNAL;
 	}
 #endif
 
-- 
2.13.6

