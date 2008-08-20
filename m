From: "Dennis Jansen" <Dennis.Jansen@web.de>
Subject: [PATCH] ACPI: Fix typo in "Disable MWAIT via DMI on broken Compal board"
Date: Wed, 20 Aug 2008 16:44:03 +0200
Message-ID: <e678b6ed0808200744k14429ab4sf8e636d0a97ca2e4@mail.gmail.com>
Reply-To: d.g.jansen@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:35041 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbYHTOoE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Aug 2008 10:44:04 -0400
Received: by wr-out-0506.google.com with SMTP id 69so422578wri.5
        for <linux-acpi@vger.kernel.org>; Wed, 20 Aug 2008 07:44:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This fixes a typo in commit 2a2a64714d9c40f7705c4de1e79a5b855c7211a9
"Disable MWAIT via DMI on broken Compal board".

It allows the nomwait dmi check to actually detect the Acer 5220.

Signed-off-by: Dennis Jansen <dennis.jansen@web.de>
Tested-by: Dennis Jansen <dennis.jansen@web.de>
Acked-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index e36422a..499f2fa 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -138,7 +138,7 @@ static struct dmi_system_id __cpuinitdata
processor_idle_dmi_table[] = {
 	{
 	set_no_mwait, "Extensa 5220", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-	DMI_MATCH(DMI_SYS_VENDOR, "ACER"),
+	DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 	DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
 	DMI_MATCH(DMI_BOARD_NAME, "Columbia") }, NULL},
 	{},
--
1.5.4.3
