From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 1/3] ACPI / dock: Fix __init attribute locations
Date: Tue, 13 Aug 2013 18:31:13 +0800
Message-ID: <1376389876-11791-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:52736 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab3HMKcZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2013 06:32:25 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so7865798pbb.41
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2013 03:32:24 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

__init belongs after the return type on functions, not before it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/dock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 8265607..c90112c 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -1055,7 +1055,7 @@ err_unregister:
  *
  * This is called by acpi_walk_namespace to look for dock stations and bays.
  */
-static __init acpi_status
+static acpi_status __init
 find_dock_and_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	if (is_dock(handle) || is_ejectable_bay(handle))
-- 
1.7.9.5

