From: Len Brown <lenb@kernel.org>
Subject: [PATCH 013/171] PM: arch/x86/kernel/apm_32.c: fix build warning
Date: Tue, 29 Apr 2008 04:44:04 -0400
Message-ID: <5373fd72577ffc4689ade0a2a1a885293c32c711.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:1417 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755335AbYD2Iow (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:52 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Andrew Morton <akpm@linux-foundation.org>

arch/x86/kernel/apm_32.c:1215: warning: label 'out' defined but not used

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/apm_32.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index d7e92bf..bc8b57d 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1212,7 +1212,6 @@ static int suspend(int vetoable)
 	local_irq_enable();
 	device_resume();
 	queue_event(APM_NORMAL_RESUME, NULL);
- out:
 	spin_lock(&user_list_lock);
 	for (as = user_list; as != NULL; as = as->next) {
 		as->suspend_wait = 0;
-- 
1.5.5.1.99.gf0ec4

