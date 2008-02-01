From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/37] Hibernation: Fix comment in disk.c
Date: Thu, 31 Jan 2008 23:36:49 -0500
Message-ID: <9248efd164497b06c942e1c38d51a90c268265ef.1201840183.git.len.brown@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:38807 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752073AbYBAEly (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 23:41:54 -0500
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix a comment in kernel/power/disk.c so that it doesn't contain lines
longer that 80 characters.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/disk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 2a4bada..3e24a20 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -568,8 +568,8 @@ static int software_resume(void)
 
 	if (noresume) {
 		/**
-		 * FIXME: If noresume is specified, we need to find the partition
-		 * and reset it back to normal swap space.
+		 * FIXME: If noresume is specified, we need to find the
+		 * partition and reset it back to normal swap space.
 		 */
 		mutex_unlock(&pm_mutex);
 		return 0;
-- 
1.5.4.rc5.16.gc0279

