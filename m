From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/37] Suspend: Fix comment in main.c
Date: Thu, 31 Jan 2008 23:36:48 -0500
Message-ID: <531ca296b97439089a9976c3344e4e2eaa0381a6.1201840183.git.len.brown@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:61249 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759267AbYBAEmF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 23:42:05 -0500
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix a comment in kernel/power/main.c so that it doesn't contain lines
longer that 80 characters.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 7fb805d..d0cedaa 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -250,8 +250,8 @@ static int suspend_enter(suspend_state_t state)
 }
 
 /**
- *	suspend_devices_and_enter - suspend devices and enter the desired system sleep
- *			  state.
+ *	suspend_devices_and_enter - suspend devices and enter the desired system
+ *				    sleep state.
  *	@state:		  state to enter
  */
 int suspend_devices_and_enter(suspend_state_t state)
-- 
1.5.4.rc5.16.gc0279

