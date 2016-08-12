From: Baoquan He <bhe@redhat.com>
Subject: [Patch v2] x86, ACPI: Fix the wrong assignment when Handle apic/x2apic entries
Date: Fri, 12 Aug 2016 15:21:47 +0800
Message-ID: <1470986507-24191-1-git-send-email-bhe@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42638 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbcHLHcI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Aug 2016 03:32:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Baoquan He <bhe@redhat.com>

By pure accident the bug makes no functional difference, because the only
expression where we are using these values is (!count && !x2count), in which
the variables are interchangeable, but it makes sense to fix the bug
nevertheless.

Signed-off-by: Baoquan He <bhe@redhat.com>
[Ingo rewrote changelog]
---
v1-v2:
  -Just update change log.

 arch/x86/kernel/acpi/boot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 90d84c3..2b25d3f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1031,8 +1031,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
 			return ret;
 		}
 
-		x2count = madt_proc[0].count;
-		count = madt_proc[1].count;
+		count = madt_proc[0].count;
+		x2count = madt_proc[1].count;
 	}
 	if (!count && !x2count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
-- 
2.5.5

