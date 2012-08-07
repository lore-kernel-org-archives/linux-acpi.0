From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH][Trivial] drivers/acpi/osl.c: delete trailing whitespace
Date: Tue, 7 Aug 2012 22:05:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208072203500.3227@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9eaf708..b9eb753 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1061,7 +1061,7 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 		jiffies = MAX_SCHEDULE_TIMEOUT;
 	else
 		jiffies = msecs_to_jiffies(timeout);
-	
+
 	ret = down_timeout(sem, jiffies);
 	if (ret)
 		status = AE_TIME;
-- 
1.7.11.4


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
