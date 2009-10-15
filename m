From: Tim Hoppen <timhoppen@gmail.com>
Subject: [PATCH 2/2] Patch for bug with ACPI for Sony VGN-FW351 to acpi_osi_dmi_table Similar to bug http://bugzilla.kernel.org/show_bug.cgi?id=12904 (same video controller)
Date: Thu, 15 Oct 2009 13:56:31 -0700
Message-ID: <1255640191-14807-1-git-send-email-timhoppen@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762970AbZJOVAM@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, jgarzik@redhat.com, tj@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Hoppen <timhoppen@gmail.com>
List-Id: linux-acpi@vger.kernel.org


Signed-off-by: Tim Hoppen <timhoppen@gmail.com>
---
 drivers/acpi/blacklist.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 01cca5f..782f330 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -212,13 +212,13 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		},
 	},
 	{
-        .callback = dmi_disable_osi_vista,
-        .ident = "Sony VGN-FW351J",
-        .matches = {
-                     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-                     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW351J"),
-                },
-        },
+	.callback = dmi_disable_osi_vista,
+	.ident = "Sony VGN-FW351J",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW351J"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.6.5
