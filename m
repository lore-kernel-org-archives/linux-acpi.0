From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/16] ACPI: add missing __percpu markup in
 arch/x86/kernel/acpi/cstate.c
Date: Tue, 28 Sep 2010 23:44:40 -0400
Message-ID: <bd126b23a2f30c3c7d268db2b96866923eb732a5.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:58382 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab0I2DyS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:54:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00JMZPI2KR79@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:54:05 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Namhyung Kim <namhyung@gmail.com>, Len Brown <len.brown@intel.com>

From: Namhyung Kim <namhyung@gmail.com>

cpu_cstate_entry is a percpu pointer
but was missing __percpu markup.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/cstate.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index fb7a5f0..fb16f17 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -61,7 +61,7 @@ struct cstate_entry {
 		unsigned int ecx;
 	} states[ACPI_PROCESSOR_MAX_POWER];
 };
-static struct cstate_entry *cpu_cstate_entry;	/* per CPU ptr */
+static struct cstate_entry __percpu *cpu_cstate_entry;	/* per CPU ptr */
 
 static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
 
-- 
1.7.3.2.g9027fa

