From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] Introduce FW_BUG and FW_INFO to consistenly tell users about BIOS bugs
Date: Wed, 27 Aug 2008 15:27:09 +0200
Message-ID: <1219843631-26015-2-git-send-email-trenn@suse.de>
References: <200808210919.07642.bjorn.helgaas@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:57135 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524AbYH0N1N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 09:27:13 -0400
In-Reply-To: <200808210919.07642.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, arjan@linux.intel.com, linux-acpi@vger.kernel.org, ckornacker@suse.de, Thomas Renninger <trenn@suse.de>

The idea is to add this to printk after the severity:
printk(KERN_ERR FW_BUG "This is not our fault\n");

If a Firmware issue should be hidden, because it is
work-arounded, but you still want to see something popping up e.g.
for info only:
printk(KERN_INFO FW_INFO "This is done stupid, we can handle it,
but it should better be avoided in future\n");

or on the Linuxfirmwarekit to tell vendors that they did something
stupid or wrong without bothering the user:
printk(KERN_INFO FW_BUG "This is done stupid, we can handle it,
but it should better be avoided in future\n");

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 include/linux/kernel.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2651f80..68ebfc2 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -190,6 +190,9 @@ extern int kernel_text_address(unsigned long addr);
 struct pid;
 extern struct pid *session_of_pgrp(struct pid *pgrp);
 
+#define FW_BUG		"[FW Bug]: "
+#define FW_INFO		"[FW Info]: "
+
 #ifdef CONFIG_PRINTK
 asmlinkage int vprintk(const char *fmt, va_list args)
 	__attribute__ ((format (printf, 1, 0)));
-- 
1.5.4.5

