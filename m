From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPICA: Don't switch task then not allowed
Date: Fri, 28 Aug 2009 02:39:35 +0400
Message-ID: <20090827223935.25504.42480.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51684 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751276AbZH0Wjd (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 27 Aug 2009 18:39:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 include/acpi/platform/aclinux.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index fcb8e4b..23b262b 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -152,7 +152,7 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 
 #define ACPI_PREEMPTION_POINT() \
 	do { \
-		if (!irqs_disabled()) \
+		if (!in_atomic_preempt_off()) \
 			cond_resched(); \
 	} while (0)
 

