From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/41] ACPI: cleanup: make disable_acpi() valid w/o CONFIG_ACPI
Date: Tue, 13 Feb 2007 00:49:43 -0500
Message-ID: <11713458301625-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org> <11713458222751-git-send-email-lenb@kernel.org> <11713458233765-git-send-email-lenb@kernel.org> <11713458242872-git-send-email-lenb@kernel.org> <11713458251648-git-send-email-lenb@kernel.org> <11713458262743-git-send-email-lenb@kernel.org> <11713458271675-
 git-send-email-lenb@kernel.org> <11713458271642-git-send-email-lenb@kernel.org> <11713458283253-git-send-email-lenb@kernel.org> <11713458293698-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:19853 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751074AbXBMFub (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:31 -0500
In-Reply-To: <11713458293698-git-send-email-lenb@kernel.org>
Message-Id: <a795ca5852fb944f21bd71c1230fcc5456e7d5ef.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Len Brown <len.brown@intel.com>

From: Rusty Russell <rusty@rustcorp.com.au>

Len Brown <lenb@kernel.org> said:
> Okay, but better to use disable_acpi()
> indeed, since this would be the first code not already inside CONFIG_ACPI
> to invoke disable_acpi(), we could define the inline as empty and you could
> then scratch the #ifdef too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/asm-i386/acpi.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-i386/acpi.h b/include/asm-i386/acpi.h
index 5e657eb..449f3f2 100644
--- a/include/asm-i386/acpi.h
+++ b/include/asm-i386/acpi.h
@@ -127,6 +127,7 @@ extern int acpi_irq_balance_set(char *str);
 #define acpi_ioapic 0
 static inline void acpi_noirq_set(void) { }
 static inline void acpi_disable_pci(void) { }
+static inline void disable_acpi(void) { }
 
 #endif	/* !CONFIG_ACPI */
 
-- 
1.5.0.rc4.345.gb4d2
