Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4F37F743
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327248; cv=none; b=ag4HfBvU3LvJmrQyl+tDVnR3PrrF3AVhpa3KGajf/4oY7NA4vyTpIy2dCnhn9Fm9/iUuHL7jfrmBbLxHqcpHk44Lto8Q7LvGGd7JnBSFo4YltMDn5IitPDpE0wcEHwmVPsA3VHQs0QjWTZYkPfDCgKgLRRjAWPq6jdAgfb7ctHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327248; c=relaxed/simple;
	bh=GIEKKn7eeP8BcrovTLwKGu0Mv7eaUlPrnhNrBJjqSW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=fNBcl1xqDRnawTjryv1bh0pz4h1rDnK9IASFUgNGUOe1E0em9I3RH7upzaky65TxqRCpujmySY7Qo/92VOlK0pmzLie8cEGY54prAUVvW/eRgRdFvcWwRZB3JbV89hAokLTttL7CGIsk3akiC3Lwbf7ifvK2x7XgC5nZrB70E58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=p1JJHxfG; arc=none smtp.client-ip=66.163.185.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="p1JJHxfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777327246; bh=xYM+HEaj8Jfb8vQ1iF+EU3k50+XlNg/9MWVKSYcY2xM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=p1JJHxfGPGFvPUKOGnh/XWYlnVy9nhuKCy1jLnguyPZ/QjhS/peZkXdWM5Iiop/NQI2hY05KDeqXAP5UH9M3LBz2rOrojDREesSPDcCNFYFHvTy44/O8SQkGGkbRKbbOUNd9wBi9xDyc0MMBecAV5rkoq3WPIT1YWXBrI9xEstBy7AyP7cQVaJXrTAxEPdKM7TosDL3EfrA2zspTNUEw/vvqCSzR/s6pPJpmQTnIUvL95eFo4Hygj4nWKNdMiNXUuV9xjHNGd8sju2l0LSmbM+3XAGOOgHNdGrYmVA8Z+02pCK/8I06HekouBFABiL8e0KlZYzuK7IF/o5zmrZsVag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777327246; bh=XrqrhKIL23sc8jbszCDnCb/aCfEwVCQ7jcnpDM70KF2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UGZvAUAmHjDXPE3rO87CRU2DpaidkZbp/n9Q5Mib3HFtOzF0cUflyaND+qltw68TzaTXi/PRdZ9bbbh3fKrEzJv2SZUzZElTXFkICzkYkKgd9qoSBAkZ0FQVz2QzykbJLZ1wsiD5rkHHuGw45J+NxjXxeetHSCoEgqgPrfKaZc9cqCPq8JudBNNeX8tqaHtzNmi7cRQCpaQ4yxffyldK1t+0EhhF4pbfm/qDWVFm7fmw4mbhLpipuO04m76Q81G4M4HdpLOvOnInYnHXkwJXXb4uYvtbfwGr1jopZ5Z0om27+HN1o1HGhxkRHOfiAyw5PCRZFuy8i1gHGDVIb4WoJQ==
X-YMail-OSG: qEEHY18VM1m1s1KFV4kbYUxIIrwrLS_ZOsqav4Vbjt_jdDW9koOOsBWe8pS4FKS
 sNmIsUvd2h6eZe.EX5RM_stfFJPl4s5gH0emKFJDOCaKCdBz3gv19_qIhg0dmo9LLcXFz7PFWe0w
 qK9kbX8G0Yar5LfNIfZGSqjQmQLGCq80Zj2uw3TTKjrVB0NVhLtGwnjpf1NxYuWA8_CfOBCRhmrb
 C0lMbsgTJLQh_ANNZhvCLhZ9KobLeEc.ZPg98tpG9ZUtmRsQm9telmtDvP7CzxymbF263UdiLzBL
 8uE2cEzjd1viDVkE_Zn8Q4zMRhqx4cowf.Chz.yTn94Gtx.g4SsMzvSs7LLa6yq5F1We72v5.Tag
 xm80vhzAxJq3gVIzyUDveESZFe0JbyfUPKWfbHjYR0Qm0j_dLR6SZwaW.WYA2IPKMEeqAGKC4NSg
 D.EwIe3HAm.RnFBOEixumiKRKeWS8gtElVJrn7_ZjrzuwMNQrxXBbGiWK_PBy90NNoqyGSqy3KCh
 B0LTHOSlAZPiRSsjLGMP43zRF8okoRhGReUYhKJc4fOMjp3PhEKL9PIJuP82VT5vD8OuiqJn_qoN
 NSDIcbkUldZ6X6p4Ts6r7lzYlsX6f00fhYXiUuZPSvgeI8IsIP_979ClehlxZ7lEadMRDB2M1OBI
 VoGBhtY.gSlYvc79MBEUO5N3UTWLYYuKRBFYP.51N30gZcCBCA3cN3vI_UHMRX18q5rvJHFTjstH
 FDcZiPKnbDHZUHXl9K5BsyEb2R_ROEVTPuhOVveEovdYGqu3_jY30ZW9xWipu.QVnsAyRVB5QXDs
 ZzDRUgCpGHOCvFTmQaMU6a733237HRc4jgQdBxmad.w58Tgm_Q.TCVgjvUeUSna7rKOaQVL7WKAW
 OZo8KXT8x9b56PLYDhl0qXP6P4twI0vUIWjjZlruxGyveLpFYQhGZDAmDLL8Gyam9CXbd_X9k7VJ
 pMV6JKNxhE8cp8CVHGy_TX5w8zaCt2naL1ZB0546QY8X1pmXvl3zWJt6QrJLqjBeic82jxnPqvUH
 H0IfHSYFlF6mKesnVXoRj7fV9V7RwFzlk2wXQ3fGWM_rcNJ.VVadfYZtIsW4aN6EcUDz8Xq6WzlE
 0ucJylflQ2rqw1QCmjrQrZxi1Iq_SPe_kEMJA3PHKE0yPMa2.2stpFI23_jLYtTLGJHhlduJy587
 i.tO3uUx8eDvNvBPCyun.ti7SfPNRQz6Du0fIpE5CukXA8xoPhCqvVT8e8sfsBlAS8.Zh1EuBAcY
 Y2nBM9ysaIh1CPE6O6YjQgJuZ2.ATxsdWFIAEG.s4SfPEH6NWI1NrIbU_DqCtmLLdh5ABDsDT8oh
 isiLVcx9Vu9m48qMqXkND6fo.0vNxE1HcpoSlOe0DeFtZeAuUhW0d.6m2J8mVrBVU58rPlkPWhAJ
 T.RoZZgmG08.vDEhKai1g8_aZZNrVXSKiHM59Txv1mp5NL4Z_ERgah63avk2uvJaVpxgu8t.Bu8y
 y5H5N13FAK6wAv.GeR.zkrfuqp_wPlU4NAce8AdOsQVfumU1CxwcIELyXf0lAPEFE_BQtSffy3ZI
 626ERDgDJpUe3D1QFbIHgV_7sLbC650CmS5UnYYVyC6H2lSTUaVv1LEX66xEhU8vsf7VJwBkjaug
 ZmIfZA.bNSVGsA2gBub06ms13BJeu5A44cFsUggmeP8aC3OIV3rFyVXTUTjYSDvuEkgaT2jc0Hk1
 28cFGxf0oCxH.kEbAIP3._dijPK8O0wKhWkSod5cVuGkMxSRsdCGzc8c1XnnOWL7j5jG_zcE.Pqz
 QldAESh8tTNApA4UDSI.AwnYcwCozqkMgGQOQKEs_X2H7C8ezyat96ObeC7ipvOvi_xh8CB9RFuU
 kPALIlR2olNsF.EkGSQhSol6gwrXA2cFxSk3KcEDVtRKhi9sRmWHTUPsetgNloVP2eaOPcNxWn_q
 25dqJqeNHH1W_JAN3p_hkO8WOMDXph4hJnNfDdphTLI3FZuuJcDbdtQ2y1ISO780.IwTZGCt96VV
 EZBcmj9VJ7_l4wWZ3VSK8nzMVrhbljwFQFCINoWHgz5oKsPgIx5S5B6RCNoOP34UvziMW5Cu3r1A
 VZlNpF3Mg9.21BvG4E4Ic2So9SNFD9ZhrLt4Leh3YxGvtFb9uU7anRfa6tByxJ47CQCbuUcjKfvT
 9u.vFqU71g0emO285e.RmU5s24fMCl2BVe7cmJHmJNz5S62s7ajMdE15E5N_81rGtgt4_KA8G9Zc
 Mw_HFJkNXlaNVVQTQzgZA6oZVWiQyWamyuM_CWeXKk7eo1uTxNO.2_LM2Z8cQbMZQtg26kDmiSQ-
 -
X-Sonic-MF: <sakunix@yahoo.com>
X-Sonic-ID: 1d8179e3-e1e1-4a9c-b65e-20b57deded64
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Apr 2026 22:00:46 +0000
Received: by hermes--production-gq1-7bb7df5c46-wwcch (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 55e9b8e7de17180eb792caa1913c05f8;
          Mon, 27 Apr 2026 20:51:34 +0000 (UTC)
From: Manuel Quintero Fonseca <sakunix@yahoo.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Manuel Quintero Fonseca <sakunix@yahoo.com>
Subject: [PATCH v2] ACPI: resource: Add quirk for Dell PMC memory region overlap
Date: Mon, 27 Apr 2026 13:51:30 -0700
Message-ID: <20260427205130.5609-1-sakunix@yahoo.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260427205130.5609-1-sakunix.ref@yahoo.com>

On Dell OptiPlex 3080 systems, specifically during the initialization
of the intel_pmc_core driver, the kernel reports a resource sanity
check conflict. The issue was identified via dmesg logs showing:

resource sanity check: requesting [mem 0xfdffe800-0xfe0007ff], which
spans more than PNP0C02:03 [mem 0xfdb00000-0xfdffffff]

And subsequently:

resource sanity check: requesting [mem 0xfdffe800-0xfe0007ff], which
spans more than Reserved [mem 0xfe000000-0xfe010fff]

Investigation of /proc/iomem and ACPI tables on this specific model
revealed that the BIOS defines reserved regions (as a PNP0C02 resource
and an E820 reserved entry) that overlap with the Power Management
Controller (PMC) register space.

This overlap is harmless for system stability but produces persistent
warnings in dmesg. This patch introduces a quirk to:

1. Filter out the conflicting fixed memory resources in
   drivers/acpi/resource.c.
2. Skip the iomem sanity check for the specific problematic range in
   kernel/resource.c.

This ensures a clean boot log on these Dell units and allows the
Intel PMC driver to bind correctly without resource conflicts.

Signed-off-by: Manuel Quintero Fonseca <sakunix@yahoo.com>
---
v2:
  - Add DMI matching to restrict the quirk to Dell systems.
  - Include <linux/dmi.h> to fix compilation errors.
  - Expand commit description with specific hardware (Dell OptiPlex 3080).
  - Include dmesg logs showing the resource conflict.
  - Reformat description to 75 characters per line.

 drivers/acpi/resource.c | 32 ++++++++++++++++++++++++++++++++
 kernel/resource.c       |  9 +++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index bc8050d8a6f5..464195e30080 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -50,6 +50,20 @@ static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
 }
 #endif
 
+/*
+ * List of Dell systems requiring memory resource quirks due to BIOS
+ * reservations overlapping with Intel PMC register space.
+ */
+static const struct dmi_system_id dell_memory_quirks[] = {
+	{
+		.ident = "Dell Inc.",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+	},
+	{ }
+};
+
 static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
 {
 	u64 reslen = end - start + 1;
@@ -110,6 +124,24 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
 	struct acpi_resource_memory32 *memory32;
 	struct acpi_resource_fixed_memory32 *fixed_memory32;
 
+	/*
+	 * Quirk for Dell systems: ignore BIOS memory reservations that overlap
+	 * with Intel PMC resources. Restricted via DMI to avoid impact on
+	 * other manufacturers.
+	 */
+	if (dmi_check_system(dell_memory_quirks)) {
+		u32 addr = 0;
+
+		if (ares->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32)
+			addr = ares->data.fixed_memory32.address;
+		else if (ares->type == ACPI_RESOURCE_TYPE_MEMORY32)
+			addr = ares->data.memory32.minimum;
+
+		if (addr == 0xfdb00000 ||
+		    (addr >= 0xfe000000 && addr <= 0xfe000fff))
+			return false;
+	}
+
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 		memory24 = &ares->data.memory24;
diff --git a/kernel/resource.c b/kernel/resource.c
index bb966699da31..16c82d9ea14f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -30,6 +30,7 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <asm/io.h>
+#include <linux/dmi.h>
 
 
 struct resource ioport_resource = {
@@ -1857,6 +1858,14 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 		 */
 		if (p->flags & IORESOURCE_BUSY)
 			continue;
+		/*
+		 * Only apply this quirk on Dell systems to avoid false
+		 * positives elsewhere.
+		 */
+		if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.")) {
+			if (p->start == 0xfe000000 && p->end == 0xfe010fff)
+				continue;
+		}
 
 		pr_warn("resource sanity check: requesting [mem %pa-%pa], which spans more than %s %pR\n",
 			&addr, &end, p->name, p);
-- 
2.47.3

