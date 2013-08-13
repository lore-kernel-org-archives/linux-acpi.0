From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 3/3] ACPI / osl: Fix __initdata attribute locations
Date: Tue, 13 Aug 2013 18:31:15 +0800
Message-ID: <1376389876-11791-3-git-send-email-hanjun.guo@linaro.org>
References: <1376389876-11791-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:45233 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab3HMKfQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2013 06:35:16 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so7824919pbc.21
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2013 03:35:15 -0700 (PDT)
In-Reply-To: <1376389876-11791-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

__initdata should come after the variable name being declared and
nowhere else, in this way the variable will be placed in the intended
section.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/osl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 6ab2c35..5c81f20 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1351,8 +1351,8 @@ struct osi_setup_entry {
 	bool enable;
 };
 
-static struct osi_setup_entry __initdata
-		osi_setup_entries[OSI_STRING_ENTRIES_MAX] = {
+static struct osi_setup_entry
+		osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Module Device", true},
 	{"Processor Device", true},
 	{"3.0 _SCP Extensions", true},
-- 
1.7.9.5

