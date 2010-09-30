From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH] DMI to disable Vista compatibility on MSI GX723 Notebook
Date: Thu, 30 Sep 2010 18:44:11 +0800
Message-ID: <1285843451-24932-1-git-send-email-jlee@novell.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: melchior+kernel@cmu.edu, jerone.young@canonical.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, patrol@sinus.cz, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-acpi@vger.kernel.org

The brightness control hotkey don't work with Vista compatibility
, because MSI GX723 included a infinite while loop in DSDT when
brightness control hotkey pressed.
MSI GX723 used Nvida video card, the infinite while loop must be a
workaround with Nvidia's Vista driver.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/acpi/blacklist.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 2bb28b9..3e644d8 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -226,6 +226,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		},
 	},
 	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "MSI GX723",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "GX723"),
+		},
+	},
+	{
 	.callback = dmi_disable_osi_win7,
 	.ident = "ASUS K50IJ",
 	.matches = {
-- 
1.6.0.2
