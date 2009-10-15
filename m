From: Tim Hoppen <timhoppen@gmail.com>
Subject: [PATCH 1/1] Added an additional Sony laptop to acpi_osi_dmi_table
Date: Wed, 14 Oct 2009 17:59:51 -0700
Message-ID: <1255568391-8400-1-git-send-email-timhoppen@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762363AbZJOBEW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, jgarzik@redhat.com, tj@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Hoppen <timhoppen@gmail.com>
List-Id: linux-acpi@vger.kernel.org


Signed-off-by: Tim Hoppen <timhoppen@gmail.com>
---
 drivers/acpi/blacklist.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index e56b2a7..01cca5f 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -211,6 +211,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Sony VGN-SR290J"),
 		},
 	},
+	{
+        .callback = dmi_disable_osi_vista,
+        .ident = "Sony VGN-FW351J",
+        .matches = {
+                     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+                     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW351J"),
+                },
+        },
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.6.5
