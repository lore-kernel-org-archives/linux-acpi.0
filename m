From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] acpi/apei/erst: Remove "Error" from initialization and disable output
Date: Tue,  2 May 2017 09:14:51 -0400
Message-ID: <1493730891-13712-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdEBNOy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 May 2017 09:14:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

The word "Error" is used by many QA groups and users as a keyword to
indicate that there is a critical failure during system bootup. The ESRT
code would interact better with these scripts if the word "Error" was
dropped from non-error messages.  Other ACPI features only use the acronym
for initialization and disable messages so the ESRT code should do the
same.

Remove "Error Record Serialization Table" and replace it with "ACPI ESRT"
in the messages.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/apei/erst.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index ec4f507b524f..a796b9d91e20 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1129,8 +1129,7 @@ static int __init erst_init(void)
 		goto err;
 
 	if (erst_disable) {
-		pr_info(
-	"Error Record Serialization Table (ERST) support is disabled.\n");
+		pr_info("ACPI ERST support is disabled.\n");
 		goto err;
 	}
 
@@ -1187,8 +1186,7 @@ static int __init erst_init(void)
 	if (!erst_erange.vaddr)
 		goto err_release_erange;
 
-	pr_info(
-	"Error Record Serialization Table (ERST) support is initialized.\n");
+	pr_info("ACPI ERST support is initialized.\n");
 
 	buf = kmalloc(erst_erange.size, GFP_KERNEL);
 	spin_lock_init(&erst_info.buf_lock);
-- 
1.7.9.3

