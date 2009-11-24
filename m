From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH] CPUFREQ: Enable ACPI PDC handshake for VIA/Centaur CPUs
Date: Tue, 24 Nov 2009 16:53:00 +0100
Message-ID: <20091124155300.GC27506@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:33819 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267AbZKXPxH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2009 10:53:07 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org
Cc: Thomas Schlichter <thomas.schlichter@web.de>, Bruce Chang <BruceChang@via.com.tw>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

In commit 0de51088e6a82bc8413d3ca9e28bbca2788b5b53, we introduced the
use of acpi-cpufreq on VIA/Centaur CPU's by removing a vendor check for
VENDOR_INTEL.  However, as it turns out, at least the Nano CPU's also
need the PDC (processor driver capabilities) handshake in order to
activate the methods required for acpi-cpufreq.

Since arch_acpi_processor_init_pdc() contains another vendor check for
Intel, the PDC is not initialized on VIA CPU's.  The resulting behavior
of a current mainline kernel on such systems is:  acpi-cpufreq
loads and it indicates CPU frequency changes.  However, the CPU stays at
a single frequency

This trivial patch ensures that init_intel_pdc() is called on Intel and
VIA/Centaur CPU's alike.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 arch/x86/kernel/acpi/processor.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/processor.c
index d296f4a..d85d1b2 100644
--- a/arch/x86/kernel/acpi/processor.c
+++ b/arch/x86/kernel/acpi/processor.c
@@ -79,7 +79,8 @@ void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
 	struct cpuinfo_x86 *c = &cpu_data(pr->id);
 
 	pr->pdc = NULL;
-	if (c->x86_vendor == X86_VENDOR_INTEL)
+	if (c->x86_vendor == X86_VENDOR_INTEL ||
+	    c->x86_vendor == X86_VENDOR_CENTAUR)
 		init_intel_pdc(pr, c);
 
 	return;
-- 
1.5.6.5
