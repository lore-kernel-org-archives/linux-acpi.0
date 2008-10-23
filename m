From: Len Brown <lenb@kernel.org>
Subject: [PATCH 056/122] ACPI Suspend: Enable ACPI during resume if SCI_EN is
 not set
Date: Thu, 23 Oct 2008 02:38:30 -0400
Message-ID: <d0c71fe7ebc180f1b7bc7da1d39a07fc19eec768.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:46373 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbYJWGkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:20 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KFQIIRS2L2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:04 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

On some machines, like for example MSI Wind U100, the BIOS doesn't
enable ACPI before returning control to the OS, which sometimes
causes resume to fail.  This is against the ACPI specification,
which clearly states that "When the platform is waking from an S1, S2
or S3 state, OSPM assumes the hardware is already in the ACPI mode
and will not issue an ACPI_ENABLE", but it won't hurt to check the
SCI_EN bit and enable ACPI during resume from S3 if this bit is not
set.

Fortunately, we already have acpi_enable() for that, so use it in the
resume code path, before executing _BFS, in analogy with the
resume-from-hibernation code path.

NOTE: We aren't supposed to set SCI_EN directly, because it's owned
by the hardware.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index c7f0c9c..5419938 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -233,6 +233,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		break;
 	}
 
+	/* If ACPI is not enabled by the BIOS, we need to enable it here. */
+	acpi_enable();
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(acpi_state);
 
-- 
1.5.5.1

