From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/16] ACPICA: iASL: Ensure that the target node is valid in acpi_ex_create_alias
Date: Mon, 10 Jul 2017 15:24:02 +0800
Message-ID: <8b2008a06d325888551846dd7f610cf80c64946c.1499671182.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63493 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752427AbdGJHYU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:24:20 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Alex James <theracermaster@gmail.com>, Bob Moore <robert.moore@intel.com>

From: Alex James <theracermaster@gmail.com>

ACPICA commit 8b14afac65d983610cc5387ede6d85ea5ee075be

The following ACPI table contains an invalid target node within the
Alias operator:

definition_block ("", "SSDT", 1, "Bug", "BugTable", 0x00001000)
{
    Scope (_SB)
    {
        Device (DEV0)
        {
            Name (_ADR, 1)

            Device (DEV1)
            {
                Alias (_ADR, _ADR)
            }
        }
    }
}

If an ACPI table contains such an invalid target node in an Alias
operator, a segmentation fault will occur when the target node is
dereferenced within acpi_ex_create_alias. Add a check for such an invalid
target node in acpi_ex_create_alias and return AE_NULL_OBJECT as suggested
by @acpibob.

Link: https://github.com/acpica/acpica/commit/8b14afac
Signed-off-by: Alex James <theracermaster@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/excreate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index d43d7da..6867586 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -87,6 +87,11 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 				  target_node->object);
 	}
 
+	/* Ensure that the target node is valid */
+	if (!target_node) {
+		return_ACPI_STATUS(AE_NULL_OBJECT);
+	}
+
 	/*
 	 * For objects that can never change (i.e., the NS node will
 	 * permanently point to the same object), we can simply attach
-- 
2.7.4

