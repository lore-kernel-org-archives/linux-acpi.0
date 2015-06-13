From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 09/12] ACPI / processor: constify DMI system id table
Date: Sat, 13 Jun 2015 14:26:57 +0200
Message-ID: <1434198420-8519-10-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37656 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbFMM1V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:21 -0400
Received: by wifx6 with SMTP id x6so37107493wif.0
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:19 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

There is no need to have processor_power_dmi_table[] writeable, constify
it.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/processor_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 39e0c8e36244..d540f42c9232 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -94,7 +94,7 @@ static int set_max_cstate(const struct dmi_system_id *id)
 	return 0;
 }
 
-static struct dmi_system_id processor_power_dmi_table[] = {
+static const struct dmi_system_id processor_power_dmi_table[] = {
 	{ set_max_cstate, "Clevo 5600D", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
-- 
1.7.10.4

