From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 01/12] ACPI / AC: constify DMI system id table
Date: Sat, 13 Jun 2015 14:26:49 +0200
Message-ID: <1434198420-8519-2-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38206 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbbFMM1N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:13 -0400
Received: by wibdq8 with SMTP id dq8so37102617wib.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:12 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

There is no need to have ac_dmi_table[] writeable, constify it.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/ac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index bbcc2b5a70d4..9b5354a2cd08 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -308,7 +308,7 @@ static int thinkpad_e530_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
-static struct dmi_system_id ac_dmi_table[] = {
+static const struct dmi_system_id ac_dmi_table[] = {
 	{
 	.callback = thinkpad_e530_quirk,
 	.ident = "thinkpad e530",
-- 
1.7.10.4

