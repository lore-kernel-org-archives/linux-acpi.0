From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/2] x86/MCE: Export memory_error()
Date: Mon, 24 Apr 2017 13:36:20 +0200
Message-ID: <20170424113620.6iq2466yhkhb33rp@pd.tnic>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
 <CAPcyv4ijU2V-4WOPysL12ByOovAXDO=Mci1D4wNDFqxRjdvT2w@mail.gmail.com>
 <1492804517.2738.25.camel@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F6127653B@ORSMSX114.amr.corp.intel.com>
 <CAPcyv4jAkCE2QBuxfxxmZfQZLCVOGLrLXqDu5TyGCVA+xJMEVg@mail.gmail.com>
 <20170421202741.GA16423@intel.com>
 <20170421210704.c5pvpn6zivvruzx3@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:40106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168575AbdDXLgc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Apr 2017 07:36:32 -0400
Content-Disposition: inline
In-Reply-To: <20170421210704.c5pvpn6zivvruzx3@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

From: Borislav Petkov <bp@suse.de>
Date: Mon, 24 Apr 2017 13:16:50 +0200
Subject: [PATCH 1/2] x86/MCE: Export memory_error()

Export the function which checks whether an MCE is a memory error to
other users so that we can reuse the logic. Drop the boot_cpu_data use,
while at it, as mce.cpuvendor already has the CPU vendor in there.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h       |  1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 12 +++++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4fd5195deed0..3f9a3d2a5209 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -266,6 +266,7 @@ static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *s
 #endif
 
 int mce_available(struct cpuinfo_x86 *c);
+bool mce_is_memory_error(struct mce *m);
 
 DECLARE_PER_CPU(unsigned, mce_exception_count);
 DECLARE_PER_CPU(unsigned, mce_poll_count);
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 4a29f7481761..5e79dd211d35 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -510,16 +510,14 @@ static int mce_usable_address(struct mce *m)
 	return 1;
 }
 
-static bool memory_error(struct mce *m)
+bool mce_is_memory_error(struct mce *m)
 {
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (m->cpuvendor == X86_VENDOR_AMD) {
 		/* ErrCodeExt[20:16] */
 		u8 xec = (m->status >> 16) & 0x1f;
 
 		return (xec == 0x0 || xec == 0x8);
-	} else if (c->x86_vendor == X86_VENDOR_INTEL) {
+	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
 		 *
@@ -547,7 +545,7 @@ static bool cec_add_mce(struct mce *m)
 		return false;
 
 	/* We eat only correctable DRAM errors with usable addresses. */
-	if (memory_error(m) &&
+	if (mce_is_memory_error(m) &&
 	    !(m->status & MCI_STATUS_UC) &&
 	    mce_usable_address(m))
 		if (!cec_add_elem(m->addr >> PAGE_SHIFT))
@@ -724,7 +722,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 
 		severity = mce_severity(&m, mca_cfg.tolerant, NULL, false);
 
-		if (severity == MCE_DEFERRED_SEVERITY && memory_error(&m))
+		if (severity == MCE_DEFERRED_SEVERITY && mce_is_memory_error(&m))
 			if (m.status & MCI_STATUS_ADDRV)
 				m.severity = severity;
 
-- 
2.11.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
