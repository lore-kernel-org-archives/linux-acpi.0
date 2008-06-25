From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/4] ACPI: don't walk tables if ACPI was disabled
Date: Tue, 24 Jun 2008 23:07:45 -0400
Message-ID: <afd64787e881408dbc4c6487f3babd29957aae0d.1214362900.git.len.brown@intel.com>
References: <20080620135639.GA5073@damson.getinternet.no>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:36798 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbYFYDHv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jun 2008 23:07:51 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K300038U0P2WWN1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 24 Jun 2008 22:07:51 -0500 (CDT)
In-reply-to: <20080620135639.GA5073@damson.getinternet.no>
In-reply-to: <27587d0c4b2f6aecf5c54d943c1dc8deebcfcc1a.1214362900.git.len.brown@intel.com>
References: <27587d0c4b2f6aecf5c54d943c1dc8deebcfcc1a.1214362900.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernrel@vger.kernrel.org
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
1.5.6.56.g29b0d

