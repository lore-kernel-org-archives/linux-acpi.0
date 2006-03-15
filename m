From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.16-rc6 calls check_acpi_pci() on x86 with ACPI
 disabled
Date: Tue, 14 Mar 2006 17:45:40 -0800
Message-ID: <20060314174540.5c138458.akpm@osdl.org>
References: <20060315013125.GA24402@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:53227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932582AbWCOBsP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Mar 2006 20:48:15 -0500
In-Reply-To: <20060315013125.GA24402@MAIL.13thfloor.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> 
> Hi Andrew! Folks!
> 
> check_acpi_pci() is called form arch/i386/kernel/setup.c
> even if CONFIG_ACPI is not defined, but the code in
> include/asm/acpi.h doesn't provide it in this case, 

Well that's a shame.

> so either we need to move the declaration outside the 
> CONFIG_ACPI check, or alternatively move the call in
> setup.c inside the CONFIG_ACPI one
> 
> attached two patches which would do this

Prefer the first version.  But it'll break if CONFIG_X86_IO_APIC &&
!CONFIG_ACPI

So how's about this?



From: Herbert Poetzl <herbert@13thfloor.at>

check_acpi_pci() is called from arch/i386/kernel/setup.c even if
CONFIG_ACPI is not defined, but the code in include/asm/acpi.h doesn't
provide it in this case.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm/acpi.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -puN include/asm/acpi.h~dont-check_acpi_pci-on-x86-with-acpi-disabled include/asm/acpi.h
--- devel/include/asm/acpi.h~dont-check_acpi_pci-on-x86-with-acpi-disabled	2006-03-14 17:42:11.000000000 -0800
+++ devel-akpm/include/asm/acpi.h	2006-03-14 17:44:50.000000000 -0800
@@ -103,6 +103,12 @@ __acpi_release_global_lock (unsigned int
         :"=r"(n_hi), "=r"(n_lo)     \
         :"0"(n_hi), "1"(n_lo))
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_X86_IO_APIC)
+extern void check_acpi_pci(void);
+#else
+static inline void check_acpi_pci(void) { }
+#endif
+
 #ifdef CONFIG_ACPI 
 extern int acpi_lapic;
 extern int acpi_ioapic;
@@ -128,8 +134,6 @@ extern int acpi_gsi_to_irq(u32 gsi, unsi
 extern int skip_ioapic_setup;
 extern int acpi_skip_timer_override;
 
-extern void check_acpi_pci(void);
-
 static inline void disable_ioapic_setup(void)
 {
 	skip_ioapic_setup = 1;
@@ -142,8 +146,6 @@ static inline int ioapic_setup_disabled(
 
 #else
 static inline void disable_ioapic_setup(void) { }
-static inline void check_acpi_pci(void) { }
-
 #endif
 
 static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
_

