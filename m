Received: from sonic308-9.consmr.mail.ne1.yahoo.com (sonic308-9.consmr.mail.ne1.yahoo.com [66.163.187.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A551E9B3D
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532426; cv=none; b=EU2RzA0to1Mg2aT/wYhUINhl7vLWVxGx73Ief+ha651OHCrlbuK0+mtAsNKdjfMF64gNZOHkSiRGjp3nng3eFp0OEVYCHBttENhInu4m6FxH5psdcacwDMo2X8b2WPiW0kvgtjsc0RvEBupFnyzOPTE3OWYBcb2vTTweybNlhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532426; c=relaxed/simple;
	bh=GIEKKn7eeP8BcrovTLwKGu0Mv7eaUlPrnhNrBJjqSW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=f/52L6m1TN41TB1nEZTeSy+fI9Iycd3EiJX5kPEKca9F7Qd7uPw/TqrM644CBbalqgaVK9Rk5kClWZyL3EHPBPOUJf54gcD7I9mb8P5n8bSDwA6gUH8sgtYlK2ilG2qyqJD2MVHeVEDtXhuVMkHR4faKj3ToKd2KWsSc56NcsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Tfg8qQ26; arc=none smtp.client-ip=66.163.187.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Tfg8qQ26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778532418; bh=xYM+HEaj8Jfb8vQ1iF+EU3k50+XlNg/9MWVKSYcY2xM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Tfg8qQ26C4bY5iIbt3H+C4kUL7x8HvfkGJBAeFnDqmwPkly5yl9SoZfe3k+0+QNzzxaqhVZbHO8sHijBmPc1r0prxn7UkfKQhOxH6h6rTP2c2tR9nGhpfaIYSUTtR9WgvHqfNOTZydm4eAxilK9X1MY/b5JBdliVsvIkHOF7vRrz81OOpvKeZVWDjNOB879uOP4KUDkYO7y4iFj22dGyJYGbtDC/wROBDUu5v6sCIqChil34ALqkFMQITrEZ9OPnFxb2hzmYjLLGa99hB/FB2kjb2jgf+0D17zr1dQFvsTsixLwMbVtLzTU9rhgPLjEMFGO8Zenb5/s+vdbvxB+OMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778532418; bh=H9PwbeAHbQ1qNuQYRT+5toxa6lHTzkQpl3RC8cMfVkU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ND7VhRWNv6UyyjNGrTglmXQcKlTEFpcSDKbqpYap4npCrZOxeBMC/MWSDwLIHVGasEry/fDMSmjBJr8V8gEX15ZQ3qgbRVEj1aDB/o8yiOPVot9k/U+f3nycgu95UThNTo4xO39Lp/pSfjqzwrhvNF8nXyMdBWzeD6LeO2zZkN04vRLEOKGnn2jvtGQQwsBCM71F13mHMOaFN54vgbk1XKYfg6sRgsoGx3OkZ7VoK2endFFQink/WCfQTLUQ4DvkAXcoG99glupa802nd4VoMnPdisLQpJbzF8cqeQzacfITQefjyWAzMyZF60um3o0p3co3bKgw0tbgu2HGERAi0A==
X-YMail-OSG: V_XxSCIVM1nflOtQ8QH.p7lRJCqoOwZLy0hba6eghyag5q19.nyjvQ6HtUKNI2V
 sM9xazSOmdtguRaJ6nFkzKEA4iaiYf85L0CYCA.uW77rtS05AJDR9tr8312mYikZlcPdxuxl0JTR
 aIV4GeuUtOC92bfIxwyXBIdecV1X_p5wbQ3f.l4LlVIvW1vbsgo7HwmiwtIvGbpPi90Ds5z4XB0t
 jvoR545AYft9MDEFROPFyk1iBU1rRsHv0bXp9rETjo4E.5iaEhpcrUomqNSrBRt5lkr10Cj8ZA4G
 ChLs7sPCbae6NouEFc7esN5N59R6TY9eM3aTQxR9VzOt6Hc7QpndbtTMaPn2QyUilGj.wWc1y4Vn
 uBnkbidgqdaSM_UfnZScWMk40hDXWE1PkTn43ImAaBQXbjvP6Xub5O1npbI0FBN9Em3YeApoAYu4
 fONAQwIiwiBrM8X38P_OEckKdbyIsAvF8ULKRJYQcnQK__sm1Mw3Uv7Amexl7Lq44xfnLHWh6U4Z
 1xCPqlbOpWvTBYuvQlxpLxXw6g5o5ayaoBsj_qOPMipQC0aIwE3quKQECfimGEoZoQ4c1AZFkgUA
 kK0_cwnpyHS0GAvPgxQl3TxhU7FPBoJfrnGjprMsZyIN.w8hBNAp2O_WJwGqYL_Qk5W2ztOQe3Cd
 WiTgvXWORJrl6R7fsjLOZc14PL0OCEmATj6jj3mAxeZSbLyToUJc2lwCCeKaGbVQnXZK3i0mzt9E
 a.BhDn6qG6yVVFrNoUoax97_5JVsJYkoLkv6dl8YCulRl_ll3oxNBnWlhFmGRLsONKxX4RPbGZ55
 XpyA0gFx7CY8nWO8XlkUhP3BQ7K.SI21AnfgXYY_wZJqTZoEhFcUKT_ZjDXZqrou9EqJGnYrDgYK
 U7xvgZ75Vdnsjmrz.ZIDPps9RurWYZtPGGUSqp7mFhRKmPVflhxWnxRE4mEqPjTkwVP1HugmteTR
 wUxggsLpORfb2bwTf.gSHOJEJj3w.Wgv4z8PvhLGKxIsEHdb422KoxFhOYEJnlyTAFP1dIph.5s4
 GtgsumGhM7ooR1kzCm12oX0BiEou2weOEuomQ.TMtrEuGJwqtlW7P9Dt8U1NxYrTYNPxJbbrCEJo
 ASx0WOJyd79Qby07V68sStdcGrwY8fQnif.94N5rXPgCWxP8XX_VsiRjiz94LQ7iuQ5vwaLzcAcM
 WT0Q9MprnzFAJVliLI3iV_8HbLGsJF4v6Adymtdws1Id7gM2u3awM7ANNj02UmrjAw9G79P2CUX5
 UnWoXm80eac3Gj0heJjMY1iJtgMhG2EKREF1MGrd4cOl49a9AwZh6c.wTO532fki.OF3heSzKtQ6
 n_FnGwGi9k03gQ0lxCpi45l1OM..m.qUEgr.6jTzc0.6LFpvjQYbmfJnpHPjbBquaQUMvafocqHO
 awcudVBe.XYI52FNjcwtaUeaYPOfNa0gHJxuGkOnVSARAT1CGQGnGq_75iq0Woyo54Raw6sgh4lS
 WrrHiizr4EnaHfNr9FHFoRMWoSCCRq_EfkGyXBCTt7rSJBtst58yk43T3DmndrO9_EXk5Z6VuQle
 jTc7Y1ttaf6VxNTg1mxsqmcXCuFjXF6tJ32jgh8kEKs3NVeaLJ9XNGJPt_wtt3fjTCz7CF6IwDC5
 he4mKGV6M9zHPvp4N0XJLrZmqOeSI59FuhTi2s_ElnOA66S9a3GDOJP.ZG8_V9A_e1jv4c.m.wGe
 j16.Dz5yDnjfdGTXRbEl8cCdbkvh2d4ICONRIirxVpw1syAWMizOhOoccfw5yc3WvW6fdiuxx4N_
 FUUprPAFt0tCENryucnVikV8cVHYL_9hBLr6FZQ0IylS5UMm.uFxD83SV4nW6RlqJw48iK93bZvc
 Gi14LXRFljO2tge9MkA2jzfcKFtDTywYbTOoM5NRzAG1Alrim.mhRjzMcqMgq8E3UefM0uqGbIUI
 q3zbAnqskmkDKRBGQclfWkU2J9uYU5mIxqbfWBjMPMKjF08PPJrAnq9anFfsHlP2LsoLLfk9.Yz8
 bspuXlGG3cOqgLCcAV22pPEo2FFMkNpi0.M84vwO0kuuzuW16owt.29YqbEenel7PgZ2Y4TnfkQR
 XhipW3RDMwHuCq9OU8D9F65VZDJTzvEGLQjh0ARhmYo.ffYfXXSOLa4a.GubNOyRVyBxtJs6ZQqJ
 XpoIzTyezlcrxrgi1y1RmCWPHt.ZBhbFPS_gNUiyNPk6Y.u1uABp3X34EicfHQYqq1VN7bsWn5EE
 l30BMJf9guv5LVuhyuS11fEjnm6zd5bF4oIByxHakUPYReaw7QVzJ6sNTAe4GtiBhsWs4G.T.g2g
 -
X-Sonic-MF: <sakunix@yahoo.com>
X-Sonic-ID: b461df6e-840d-43ad-a652-0b07a97d9db0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 11 May 2026 20:46:58 +0000
Received: by hermes--production-gq1-7bb7df5c46-m4r75 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3781108c1c84388c145e835546274a8b;
          Mon, 11 May 2026 20:46:55 +0000 (UTC)
From: Manuel Quintero Fonseca <sakunix@yahoo.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	skhan@linuxfoundation.org,
	Manuel Quintero Fonseca <sakunix@yahoo.com>
Subject: [PATCH v2] ACPI: resource: Add quirk for Dell PMC memory region overlap
Date: Mon, 11 May 2026 13:46:46 -0700
Message-ID: <20260511204646.4863-1-sakunix@yahoo.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260511204646.4863-1-sakunix.ref@yahoo.com>

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

