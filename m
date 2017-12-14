From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] APEI / ERST: Fix missing error handling in erst_reader()
Date: Thu, 14 Dec 2017 13:31:16 +0100
Message-ID: <20171214123116.929-1-tiwai@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdLNMbd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Dec 2017 07:31:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jerry Tang <jtang@suse.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The commit f6f828513290 ("pstore: pass allocated memory region back to
caller") changed the check of the return value from erst_read() in
erst_reader() in the following way:

        if (len == -ENOENT)
                goto skip;
-       else if (len < 0) {
-               rc = -1;
+       else if (len < sizeof(*rcd)) {
+               rc = -EIO;
                goto out;

This introduced another bug: since the comparison with sizeof() is
cast to unsigned, a negative len value doesn't hit any longer.
As a result, when an error is returned from erst_read(), the code
falls through, and it may eventually lead to some weird thing like
memory corruption.

This patch adds the negative error value check more explicitly for
addressing the issue.

Fixes: f6f828513290 ("pstore: pass allocated memory region back to caller")
Cc: <stable@vger.kernel.org>
Tested-by: Jerry Tang <jtang@suse.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/acpi/apei/erst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 6742f6c68034..9bff853e85f3 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1007,7 +1007,7 @@ static ssize_t erst_reader(struct pstore_record *record)
 	/* The record may be cleared by others, try read next record */
 	if (len == -ENOENT)
 		goto skip;
-	else if (len < sizeof(*rcd)) {
+	else if (len < 0 || len < sizeof(*rcd)) {
 		rc = -EIO;
 		goto out;
 	}
-- 
2.15.1

