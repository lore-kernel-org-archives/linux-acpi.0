From: Edward Lin <yidi.lin@canonical.com>
Subject: [PATCH v2] ACPI: blacklist win8 OSI for Dell Inspiron 7737
Date: Wed,  7 May 2014 10:47:24 +0800
Message-ID: <1399430844-7006-1-git-send-email-yidi.lin@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:38599 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbaEGCrz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 May 2014 22:47:55 -0400
Received: by mail-vc0-f169.google.com with SMTP id ij19so472926vcb.28
        for <linux-acpi@vger.kernel.org>; Tue, 06 May 2014 19:47:54 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: yidi.lin@canonical.com, yk@canonical.com

With win8 capabiltiy, the machine will boot itself immediately after shutdown command has executed.
Work around this issue by disabling win8 capcability.
This workaround also makes wireless hotkey work.

ChangeLog (v1 -> v2):
 - fix typos in commit message

Signed-off-by: Edward Lin <yidi.lin@canonical.com>
---
 drivers/acpi/blacklist.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index afec452..4fc6cf5 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -314,6 +314,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 7737",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7737"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.7.9.5

