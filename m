From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Thu, 17 Jan 2008 05:24:50 -0500
Message-ID: <0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com>
References: <1200565490-29619-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:31761 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754554AbYAQKZB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 05:25:01 -0500
In-Reply-To: <1200565490-29619-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5204731..0bfebda 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1317,6 +1317,15 @@ static struct dmi_system_id acpi_osl_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
 		     },
 	 },
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad T61",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+		},
+	},
+
 
 	/*
 	 * Boxes that need _OSI(Linux) NOT set
-- 
1.5.4.rc3.14.g44397

