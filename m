From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/16] ACPICA: iASL compiler: allow compilation of externals with paths that refer to existing names
Date: Mon, 10 Jul 2017 15:23:02 +0800
Message-ID: <6f2fb73928649f8f4e8adde5901a9fb368c2465f.1499671181.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16097 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753418AbdGJHXH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:23:07 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 9a252114197409290813bee570e9d53c22b99d32

This change allows compilation of code like the following:

definition_block (...)
{
    External (ABCD.EFGH)
    Device (ABCD)
    {
        Name (IJLK,0)
    }
}

but does not allow compilation of code like the following:

definition_block (...)
{
    External (ABCD)
    Device (ABCD)
    {
        Name (EFGH,0)
    }
}

Link: https://github.com/acpica/acpica/commit/9a252114
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h  | 1 +
 drivers/acpi/acpica/nsaccess.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 822dbc5..bae943b 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -199,6 +199,7 @@ struct acpi_namespace_node {
 #define ANOBJ_EVALUATED                 0x20	/* Set on first evaluation of node */
 #define ANOBJ_ALLOCATED_BUFFER          0x40	/* Method AML buffer is dynamic (install_method) */
 
+#define IMPLICIT_EXTERNAL               0x02	/* iASL only: This object created implicitly via External */
 #define ANOBJ_IS_EXTERNAL               0x08	/* iASL only: This object created via External() */
 #define ANOBJ_METHOD_NO_RETVAL          0x10	/* iASL only: Method has no return value */
 #define ANOBJ_METHOD_SOME_NO_RETVAL     0x20	/* iASL only: Method has at least one return value */
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index e5f4fa4..14be12f 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -634,6 +634,12 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 					    this_node->object;
 				}
 			}
+#ifdef ACPI_ASL_COMPILER
+			if (!acpi_gbl_disasm_flag &&
+			    (this_node->flags & ANOBJ_IS_EXTERNAL)) {
+				this_node->flags |= IMPLICIT_EXTERNAL;
+			}
+#endif
 		}
 
 		/* Special handling for the last segment (num_segments == 0) */
-- 
2.7.4

