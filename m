From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] ACPI: Ensure lock is acquired before accessing ec struct members
Date: Fri, 15 Nov 2013 11:41:29 -0800
Message-ID: <1384544489-18098-1-git-send-email-olof@lixom.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:46758 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab3KOTlX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Nov 2013 14:41:23 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so1780961pde.20
        for <linux-acpi@vger.kernel.org>; Fri, 15 Nov 2013 11:41:22 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Puneet Kumar <puneetster@chromium.org>, Olof Johansson <olof@lixom.net>, Feng Tang <feng.tang@intel.com>

From: Puneet Kumar <puneetster@chromium.org>

A bug was introduced by commit b76b51ba0cef ('ACPI / EC: Add more debug
info and trivial code cleanup') that erroneously caused the struct member
to be accessed before acquiring the required lock.  This change fixes
it by ensuring the lock acquisition is done first.

Found by Aaron Durbin <adurbin@chromium.org>

Fixes: b76b51ba0cef ('ACPI / EC: Add more debug info and trivial code cleanup')
References: http://crbug.com/319019
Signed-off-by: Puneet Kumar <puneetster@chromium.org>
Reviewed-by: Aaron Durbin <adurbin@chromium.org>
[olof: Commit message reworded a bit]
Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Feng Tang <feng.tang@intel.com>
Cc: <stable@vger.kernel.org> # 3.8+
---
 drivers/acpi/ec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d5309fd..ba5b56d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -173,9 +173,10 @@ static void start_transaction(struct acpi_ec *ec)
 static void advance_transaction(struct acpi_ec *ec, u8 status)
 {
 	unsigned long flags;
-	struct transaction *t = ec->curr;
+	struct transaction *t;
 
 	spin_lock_irqsave(&ec->lock, flags);
+	t = ec->curr;
 	if (!t)
 		goto unlock;
 	if (t->wlen > t->wi) {
-- 
1.7.10.4

