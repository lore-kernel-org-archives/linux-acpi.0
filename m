From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/3] ACPI: don't walk tables if ACPI was disabled
Date: Sat, 28 Jun 2008 01:32:44 -0400
Message-ID: <4389ed2ff61de2b1485b31bf342da913dd342f59.1214631090.git.len.brown@intel.com>
References: <1214631165-1436-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:44622 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYF1Fcv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:32:51 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BS3REQQ8YB@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:32:51 -0500 (CDT)
In-reply-to: <1214631165-1436-1-git-send-email-lenb@kernel.org>
In-reply-to: <16d752397301b95abaa95cbaf9e785d221872311.1214631090.git.len.brown@intel.com>
References: <16d752397301b95abaa95cbaf9e785d221872311.1214631090.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Len Brown <len.brown@intel.com>

From: Vegard Nossum <vegard.nossum@gmail.com>

Ingo Molnar wrote:
> -tip auto-testing started triggering this spinlock corruption message
> yesterday:
>
> [    3.976213] calling  acpi_rtc_init+0x0/0xd3
> [    3.980213] ACPI Exception (utmutex-0263): AE_BAD_PARAMETER, Thread F7C50000 could not acquire Mutex [3] [20080321]
> [    3.992213] BUG: spinlock bad magic on CPU#0, swapper/1
> [    3.992213]  lock: c2508dc4, .magic: 00000000, .owner: swapper/1, .owner_cpu: 0

This is apparently because some parts of ACPI, including mutexes, are not
initialized when acpi=off is passed to the kernel.

Reported-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Vegard Nossum <vegard.nossum@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 2808dc6..9b227d4 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -333,6 +333,9 @@ static int __init acpi_rtc_init(void)
 {
 	struct device *dev = get_rtc_dev();
 
+	if (acpi_disabled)
+		return 0;
+
 	if (dev) {
 		rtc_wake_setup();
 		rtc_info.wake_on = rtc_wake_on;
-- 
1.5.6.1.89.gd544

