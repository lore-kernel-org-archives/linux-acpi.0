From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 06/14] x86 ioapic: Only export mp_find_ioapic and mp_find_ioapic_pin in io_apic.h
Date: Mon, 29 Mar 2010 16:20:17 -0700
Message-ID: <1269904825-27462-6-git-send-email-ebiederm@xmission.com>
References: <m1r5n2wwah.fsf_-_@fess.ebiederm.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:54157 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab0C2XUt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2010 19:20:49 -0400
In-Reply-To: <m1r5n2wwah.fsf_-_@fess.ebiederm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, len.brown@intel.com, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org, Iranna D Ankad <iranna.ankad@in.ibm.com>, Gary Hade <garyhade@us.ibm.com>, Natalie Protasevich <protasnb@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>

From: Eric W. Biederman <ebiederm@xmission.com>

Multiple declarations of the same function in different headers
is a pain to maintain.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86/include/asm/mpspec.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index d8bf23a..29994f0 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -106,10 +106,6 @@ struct device;
 extern int mp_register_gsi(struct device *dev, u32 gsi, int edge_level,
 				 int active_high_low);
 extern int acpi_probe_gsi(void);
-#ifdef CONFIG_X86_IO_APIC
-extern int mp_find_ioapic(int gsi);
-extern int mp_find_ioapic_pin(int ioapic, int gsi);
-#endif
 #else /* !CONFIG_ACPI: */
 static inline int acpi_probe_gsi(void)
 {
-- 
1.6.5.2.143.g8cc62

