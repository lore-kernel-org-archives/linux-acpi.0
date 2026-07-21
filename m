Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6678F26;
	Tue, 21 Jul 2026 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784603973; cv=none; b=qKAg3uCDA5zEndmuutNHdVnpcZIUUgZXOdqpcKgRkhpJ6IPYHkrT1JldbPxJc6L47VAzS3viX/ah42r/DpjjvDYD1oFXGJ5tRAsW8EJCHOedF9EFgC/Df1pVBuDG/MMaCfJycCvASku550Dooyd8mTfaSaBk+YqgMBMsDdfNjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784603973; c=relaxed/simple;
	bh=ZUfPA7wKNjGsvX0L6/hRjpGbIUoIQgfrremgUr/KIQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iemmLLtN96JieVhCe/cSFdgGHjDXtzqYH8UoFLf8lDzjMKLpmO2XriIqv8ZGaRuQ57I/Uo1gCPqkEf+Jd9cKNlLYm71H2Nida82UFOZfU2WxfJ5HuBnp8VbahvUpzKBnkQ41wCEljpwhAjTEGmurVIQZc4BWdr+8JH/TRRFEUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AWaiBDhF reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AWaiBDhF"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E43640E00E6;
	Tue, 21 Jul 2026 03:19:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JaKpt61QJbf4; Tue, 21 Jul 2026 03:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784603957; bh=TsJ8iCG3+AAqhJx4pGjtKcubspnzoHAyEaFoNP+7Ktg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWaiBDhFHKtotJ1P/kgfOId8nF2CKGrpeWcW8giTYB3fkC27UrvmbbCBFk4ONOm4v
	 G0tCtuQFghQRDFITIj2Zjt3FmYN2Vn3vFgV/0m62HR1f7tgtZON4lwOdN7FdbcjCZ+
	 c4+CMDwyRqc9Q3ICfw3i+YjIiovfk4yVyzM44xn/l5g1CWBKKPOhxGpVa9Q6ytyDD5
	 9JNwKIBBnWeyEvUiB7MAVk0X2xzyvhr7I27e23q0LGZdrHBinFhSVkYYVTAFTa4Qkw
	 gEXY/lAZTvSYinlRcul7+q+XG5LIsKNCszxFiUwq7xJRBBVZTkbiXq506WjNJhLEhd
	 DRMJSEAh8nEG1pM5bTNdNrwytA5FLFHlCrlv0IE3OmJJGVzu2YUXHb2R7mw6KiDKLT
	 /ZGWGireKbJhQojM40ZxQw1XCIDxzgcZ9uJ/QX+TQbiy440EgLsI2WtkyeIqsJOMlq
	 UHWgEYVpqAVTUlBN+ktrb3kfvVM+NvSh8KQB5K0MAGOzGBb+lQo3hC4vTMjkn5/qaq
	 M8d+qMOnMbZPFVYinF7YaUQQBBDGMKv6hyyX9dKhk8jR/hEUVC3PUvDEnFXmNNXKHZ
	 HeKlfj426U6FuwMxbP43K1B87vbOmXWaz7L9knHu1OUvhRagZsEgSpmWNiB59/fiaW
	 y1g/iAh9fF1meNDCUh5IgehM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0542A40E00C3;
	Tue, 21 Jul 2026 03:19:01 +0000 (UTC)
Date: Mon, 20 Jul 2026 20:18:58 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	dave.hansen@linux.intel.com, Vishal Badole <Vishal.Badole@amd.com>,
	mingo@redhat.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, peterz@infradead.org,
	tony.luck@intel.com, chang.seok.bae@intel.com,
	wei.w.wang@hotmail.com
Subject: [PATCH] x86/topo: Map vendor CPU types to generic Linux such types
Message-ID: <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
References: <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
 <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fr1us7sa.ffs@fw13>
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 01:24:05AM +0200, Thomas Gleixner wrote:
> If that's the only case to handle, then sure that open coded check is
> fine.

This is ontop of tip:x86/cpu which already has Pawan's change that drops =
the
one Intel-specific CPU type use.

It boots here so... :-P

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Thu, 2 Jul 2026 17:00:28 -0700
Subject: [PATCH] x86/topo: Map vendor CPU types to generic Linux such typ=
es
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Sashiko reported=C2=B9 that a confusion could ensue if a vendor-specific =
CPU
type 0 (performance) gets attempted to be used in a x86_cpu_id match
table. The current logic treats 0 as the wildcard X86_CPU_TYPE_ANY and
such a thing would end up matching the wrong CPUs.

This is all backwards because we started using the vendor-specific CPU
type number instead of using a Linux-defined, generic CPU type which
is agnostic.

Convert the current logic to it before users start appearing.

  =C2=B9https://sashiko.dev/#/patchset/20260629094349.533301-1-Vishal.Bad=
ole%40amd.com

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20260629094349.533301-2-Vishal.Badole@amd=
.com
---
 arch/x86/include/asm/processor.h      | 18 ++++++++++++----
 arch/x86/include/asm/topology.h       |  7 -------
 arch/x86/kernel/acpi/cppc.c           |  4 ++--
 arch/x86/kernel/cpu/match.c           | 30 +--------------------------
 arch/x86/kernel/cpu/topology.h        |  1 +
 arch/x86/kernel/cpu/topology_amd.c    |  6 ++++--
 arch/x86/kernel/cpu/topology_common.c |  8 +++++--
 7 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
index 87b1d4c0727e..fc0350fe8f5e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -68,9 +68,13 @@ extern u16 __read_mostly tlb_lld_2m;
 extern u16 __read_mostly tlb_lld_4m;
 extern u16 __read_mostly tlb_lld_1g;
=20
-/*
- * CPU type and hardware bug flags. Kept separately for each CPU.
- */
+enum x86_topology_cpu_type {
+	/* X86_CPU_TYPE_ANY */
+	TOPO_CPU_TYPE_ANY =3D 0,
+	TOPO_CPU_TYPE_PERFORMANCE,
+	TOPO_CPU_TYPE_EFFICIENCY,
+	TOPO_CPU_TYPE_UNKNOWN,
+};
=20
 struct cpuinfo_topology {
 	// Real APIC ID read from the local APIC
@@ -104,7 +108,7 @@ struct cpuinfo_topology {
=20
 	// Hardware defined CPU-type
 	union {
-		u32		cpu_type;
+		u32		hw_cpu_type;
 		struct {
 			// CPUID.1A.EAX[23-0]
 			u32	intel_native_model_id	:24;
@@ -119,8 +123,14 @@ struct cpuinfo_topology {
 				amd_type		:4;
 		};
 	};
+
+	// Linux vendor-agnostic CPU type
+	enum x86_topology_cpu_type cpu_type;
 };
=20
+/*
+ * CPU type and hardware bug flags. Kept separately for each CPU.
+ */
 struct cpuinfo_x86 {
 	union {
 		/*
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topol=
ogy.h
index 8fb61d2465eb..ef76ba674f1b 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,12 +114,6 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
 };
=20
-enum x86_topology_cpu_type {
-	TOPO_CPU_TYPE_PERFORMANCE,
-	TOPO_CPU_TYPE_EFFICIENCY,
-	TOPO_CPU_TYPE_UNKNOWN,
-};
-
 struct x86_topology_system {
 	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int	dom_size[TOPO_MAX_DOMAIN];
@@ -160,7 +154,6 @@ extern unsigned int __num_nodes_per_package;
 struct cpuinfo_x86;
=20
 const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
-enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
=20
 static inline unsigned int topology_max_packages(void)
 {
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index be4c5e9e5ff6..b8f5dd0a8117 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -241,7 +241,6 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
  */
 int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
-	enum x86_topology_cpu_type core_type =3D get_topology_cpu_type(&cpu_dat=
a(cpu));
 	bool prefcore;
 	int ret;
 	u32 tmp;
@@ -273,8 +272,9 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u=
64 *numerator)
=20
 	/* detect if running on heterogeneous design */
 	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
-		switch (core_type) {
+		switch (cpu_data(cpu).topo.cpu_type) {
 		case TOPO_CPU_TYPE_UNKNOWN:
+		case TOPO_CPU_TYPE_ANY:
 			pr_warn("Undefined core type found for cpu %d\n", cpu);
 			break;
 		case TOPO_CPU_TYPE_PERFORMANCE:
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 4604802692da..7ab077f0cc66 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -5,34 +5,6 @@
 #include <linux/export.h>
 #include <linux/slab.h>
=20
-/**
- * x86_match_vendor_cpu_type - helper function to match the hardware def=
ined
- *                             cpu-type for a single entry in the x86_cp=
u_id
- *                             table. Note, this function does not match=
 the
- *                             generic cpu-types TOPO_CPU_TYPE_EFFICIENC=
Y and
- *                             TOPO_CPU_TYPE_PERFORMANCE.
- * @c: Pointer to the cpuinfo_x86 structure of the CPU to match.
- * @m: Pointer to the x86_cpu_id entry to match against.
- *
- * Return: true if the cpu-type matches, false otherwise.
- */
-static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struc=
t x86_cpu_id *m)
-{
-	if (m->type =3D=3D X86_CPU_TYPE_ANY)
-		return true;
-
-	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return true;
-
-	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
-		return m->type =3D=3D c->topo.intel_type;
-	if (c->x86_vendor =3D=3D X86_VENDOR_AMD)
-		return m->type =3D=3D c->topo.amd_type;
-
-	return false;
-}
-
 /**
  * x86_match_cpu - match current CPU against an array of x86_cpu_ids
  * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
@@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86=
_cpu_id *match)
 			continue;
 		if (m->feature !=3D X86_FEATURE_ANY && !cpu_has(c, m->feature))
 			continue;
-		if (!x86_match_vendor_cpu_type(c, m))
+		if (m->type !=3D X86_CPU_TYPE_ANY && c->topo.cpu_type !=3D m->type)
 			continue;
 		return m;
 	}
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topolog=
y.h
index 37326297f80c..74e02bacd854 100644
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -22,6 +22,7 @@ void topology_set_dom(struct topo_scan *tscan, enum x86=
_topology_domains dom,
 bool cpu_parse_topology_ext(struct topo_scan *tscan);
 void cpu_parse_topology_amd(struct topo_scan *tscan);
 void cpu_topology_fixup_amd(struct topo_scan *tscan);
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
=20
 static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domain=
s dom)
 {
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/top=
ology_amd.c
index da080d732e10..c5a6944df86a 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -177,8 +177,10 @@ static void topoext_fixup(struct topo_scan *tscan)
=20
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
-		tscan->c->topo.cpu_type =3D cpuid_ebx(0x80000026);
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
+		tscan->c->topo.hw_cpu_type =3D cpuid_ebx(0x80000026);
+		tscan->c->topo.cpu_type    =3D get_topology_cpu_type(tscan->c);
+	}
=20
 	/*
 	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/=
topology_common.c
index cf7513416b70..b9d025f3373a 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -168,8 +168,12 @@ static void parse_topology(struct topo_scan *tscan, =
bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan=
))
 			parse_legacy(tscan);
-		if (c->cpuid_level >=3D 0x1a)
-			c->topo.cpu_type =3D cpuid_eax(0x1a);
+
+		if (c->cpuid_level >=3D 0x1a) {
+			c->topo.hw_cpu_type =3D cpuid_eax(0x1a);
+			c->topo.cpu_type    =3D get_topology_cpu_type(c);
+		}
+
 		break;
 	}
 }
--=20
2.53.0

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
