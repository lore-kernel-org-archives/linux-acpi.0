From: Len Brown <lenb@kernel.org>
Subject: [PATCH 55/85] x86: remove magic number from ACPI sleep stack buffer
Date: Sat, 11 Oct 2008 02:36:15 -0400
Message-ID: <d0d0f7432c9cbd52cb2f31d499f8292b13a7ecac.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:39166 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbYJKGhH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:37:07 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>, Len Brown <len.brown@intel.com>

From: Matt Mackall <mpm@selenic.com>

x86_64 SMP suspend to RAM uses a 10k temporary stack for saving the
kernel state, but only 4k of it is used. Shrink it to 4k.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/sleep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 426e5d9..29cf340 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -97,7 +97,7 @@ int acpi_save_state_mem(void)
 #else /* CONFIG_64BIT */
 	header->trampoline_segment = setup_trampoline() >> 4;
 #ifdef CONFIG_SMP
-	stack_start.sp = temp_stack + 4096;
+	stack_start.sp = temp_stack + sizeof(temp_stack);
 #endif
 	initial_code = (unsigned long)wakeup_long64;
 	saved_magic = 0x123456789abcdef0;
-- 
1.5.5.1

