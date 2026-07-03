Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67F433E75;
	Fri,  3 Jul 2026 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107176; cv=none; b=LkqGJYhvVN21rvnBg9CVW343q4Pc8p1i065i/q0oVyeXbuwxtor+Mp0gw5MguFKowno3PoDSffGI2IRTqDKPhSiPP/bda3TknD5mzwTtKWlN55BD7PaDbnA3lJ0LNdgOVg4IkKI1QW3kpLz8TqnJK0Msk+8oqqlONgMR7/+ZWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107176; c=relaxed/simple;
	bh=M9zCv3L0xHLDg1okzYZNcZJ0o4Itr9XfbV0h9eUyRvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVrKGiXgrL+QpTycI8iizQkH7KK+mYOLGWRVZS+4Lq/kl2q+Ed6MYtpSk9pKfyy5DqNtHynCbNOmnQExrWfBSZYi+AKYf7yHJJiS2EnG1/TWVXDAMY/vG/DA0BgEUhQnSxBr+w6SmKLjPya20MpipAXhX8R+C0mpQnO4eOEnm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W7rNvD2K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W7rNvD2K"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61E6140E01D8;
	Fri,  3 Jul 2026 19:32:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id N8Ynh4n73QSr; Fri,  3 Jul 2026 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783107161; bh=XzgdP+h1bbSjmCTyUnKIibzEzM1p5xKL4eGkyoo2eAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7rNvD2KZ/g/HKZoVFpbjwlgPpoLgqUEWFqoZ7O2lqKkFyV6BhJl/6VizN/Sy0VYJ
	 HLj2XY67yo4/CQ/GJUFIkucZDYFjcJ7MOcEMDqVovG0ugfO3RXEkWpt64UCTgVLNiE
	 Ysl3YKB5Y3uI3zafjw20qyDqGLZc8YdLlNfdDF+FeKxJOn9xGFNylN+ELPTsLLD5Va
	 5l3+7Q7pFMOcbdq0fzfGYEwY4sim+mfgYgTodxP9j7zvWy+LUfQZkYYjog2OUyla7G
	 WcCsSUTQN0wBiSK6sCgRIbcA7rArT/5c15WndRoEMVlS2nWKZZYqSGGFeeMJOm/0Iy
	 TGjAFW9FlWHBGy1eUl7K66tZQsssAT5abHurIM7MnBTRPtuPVumyTOVaA7ZlwRLdH4
	 k88KaApCnWmwso3rpDnLFXmGi/1wOzPb8I4cZo/rZxHXmVoQcagSW1eQa8ee5K8Tru
	 obcCrO8twsRqG/ujwn2UJlK3y6wRTfGvKSENSEHwuWqYCJ2afQITP5WUP9/Gw9a07X
	 EguOZtSibhKEqM7XvRH9kT2l2812UFUh/qNoCuIHRvA3bPVngNfz7YaYO7zEloylks
	 1ssm6tsL4hz4v/A9D10/83t3p3kJC1vrs1ugG5hGZK9DuuBf1L40k6Y7Yb7SN5bPaa
	 2Nlmt9Z+xVjxSRuyiBV7u9zM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92FA840E01CE;
	Fri,  3 Jul 2026 19:32:25 +0000 (UTC)
Date: Fri, 3 Jul 2026 12:32:22 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
	wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
Message-ID: <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
 <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>

+ Dave and Pawan.

On Thu, Jul 02, 2026 at 04:03:37PM -0700, Borislav Petkov wrote:
> On Fri, Jul 03, 2026 at 12:06:32AM +0200, Thomas Gleixner wrote:
> > Just do the mapping to vendor-agnostic types _once_ when you enumerate the CPU
> > and store that information in the per CPU data.
> > 
> > Then you can do proper vendor agnostic matching against that and define
> > the TYPE_ANY value as you want without ever colliding with vendor
> > muck.
> > 
> > As a bonus get_topology_cpu_type() goes away too as the translation has
> > been done already.
> 
> Yeah, we should've done it from the very beginning this way. Lemme hack it up
> and see how it looks like.
> 
> Thanks for the cool idea.

Something like the totally untested below - but it builds at least.

We've allocated a u8 for the struct x86_cpu_id member type and we compare that
to enum x86_topology_cpu_type cpu_type. I guess that's ok for now...

There's potential for more cleanup by removing the ->intel_type and ->amd_type
and converting them all to our internal represenation of CPU_TYPE but that's
for later and other patches anyway.

Thoughts?

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 8d8f890c4bc0..746822bd71fb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -68,9 +68,13 @@ extern u16 __read_mostly tlb_lld_2m;
 extern u16 __read_mostly tlb_lld_4m;
 extern u16 __read_mostly tlb_lld_1g;
 
-/*
- * CPU type and hardware bug flags. Kept separately for each CPU.
- */
+enum x86_topology_cpu_type {
+	/* X86_CPU_TYPE_ANY */
+	TOPO_CPU_TYPE_ANY = 0,
+	TOPO_CPU_TYPE_PERFORMANCE,
+	TOPO_CPU_TYPE_EFFICIENCY,
+	TOPO_CPU_TYPE_UNKNOWN,
+};
 
 struct cpuinfo_topology {
 	// Real APIC ID read from the local APIC
@@ -104,7 +108,7 @@ struct cpuinfo_topology {
 
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
 
+/*
+ * CPU type and hardware bug flags. Kept separately for each CPU.
+ */
 struct cpuinfo_x86 {
 	union {
 		/*
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 8fb61d2465eb..ef76ba674f1b 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,12 +114,6 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
 };
 
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
 
 const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
-enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
 
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
-	enum x86_topology_cpu_type core_type = get_topology_cpu_type(&cpu_data(cpu));
 	bool prefcore;
 	int ret;
 	u32 tmp;
@@ -273,8 +272,9 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 
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
 
-/**
- * x86_match_vendor_cpu_type - helper function to match the hardware defined
- *                             cpu-type for a single entry in the x86_cpu_id
- *                             table. Note, this function does not match the
- *                             generic cpu-types TOPO_CPU_TYPE_EFFICIENCY and
- *                             TOPO_CPU_TYPE_PERFORMANCE.
- * @c: Pointer to the cpuinfo_x86 structure of the CPU to match.
- * @m: Pointer to the x86_cpu_id entry to match against.
- *
- * Return: true if the cpu-type matches, false otherwise.
- */
-static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
-{
-	if (m->type == X86_CPU_TYPE_ANY)
-		return true;
-
-	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return true;
-
-	if (c->x86_vendor == X86_VENDOR_INTEL)
-		return m->type == c->topo.intel_type;
-	if (c->x86_vendor == X86_VENDOR_AMD)
-		return m->type == c->topo.amd_type;
-
-	return false;
-}
-
 /**
  * x86_match_cpu - match current CPU against an array of x86_cpu_ids
  * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
@@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 			continue;
 		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
 			continue;
-		if (!x86_match_vendor_cpu_type(c, m))
+		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
 			continue;
 		return m;
 	}
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
index 37326297f80c..74e02bacd854 100644
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -22,6 +22,7 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 bool cpu_parse_topology_ext(struct topo_scan *tscan);
 void cpu_parse_topology_amd(struct topo_scan *tscan);
 void cpu_topology_fixup_amd(struct topo_scan *tscan);
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
 
 static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
 {
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index da080d732e10..c5a6944df86a 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -177,8 +177,10 @@ static void topoext_fixup(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
-		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
+		tscan->c->topo.hw_cpu_type = cpuid_ebx(0x80000026);
+		tscan->c->topo.cpu_type    = get_topology_cpu_type(tscan->c);
+	}
 
 	/*
 	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index cf7513416b70..b9d025f3373a 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -168,8 +168,12 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
-		if (c->cpuid_level >= 0x1a)
-			c->topo.cpu_type = cpuid_eax(0x1a);
+
+		if (c->cpuid_level >= 0x1a) {
+			c->topo.hw_cpu_type = cpuid_eax(0x1a);
+			c->topo.cpu_type    = get_topology_cpu_type(c);
+		}
+
 		break;
 	}
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
