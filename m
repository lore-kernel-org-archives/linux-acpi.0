From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 2/9] 2.6-sony_acpi4 warning fix
Date: Thu, 05 Jan 2006 22:30:52 -0800
Message-ID: <200601060631.k066V4I3008126@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, bboissin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benoit.boissinot-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Benoit Boissinot <bboissin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Fix unused variable warning

Signed-off-by: Benoit Boissinot <benoit.boissinot-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~git-acpi-warning-fix arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
--- devel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~git-acpi-warning-fix	2006-01-05 22:28:07.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-01-05 22:28:07.000000000 -0800
@@ -306,10 +306,6 @@ acpi_cpufreq_cpu_init (
 	struct cpufreq_acpi_io	*data;
 	unsigned int		result = 0;
 
-	union acpi_object		arg0 = {ACPI_TYPE_BUFFER};
-	u32				arg0_buf[3];
-	struct acpi_object_list 	arg_list = {1, &arg0};
-
 	dprintk("acpi_cpufreq_cpu_init\n");
 
 	data = kzalloc(sizeof(struct cpufreq_acpi_io), GFP_KERNEL);
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
