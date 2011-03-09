From: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH]: cpufreq: pcc-cpufreq: don't load driver if get_freq fails during init.
Date: Wed,  9 Mar 2011 14:02:49 +0000 (UTC)
Message-ID: <20110309135906.6554.54389.sendpatchset@nchumbalkar.americas.hpqcorp.net>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-acpi@vger.kernel.org, Naga Chumbalkar <nagananda.chumbalkar@hp.com>, cpufreq@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


Return 0 on failure. This will cause the initialization of the driver
to fail and prevent the driver from loading if the BIOS cannot handle
the PCC interface command to "get frequency". Otherwise, the driver
will load and display a very high value like "4294967274" (which is
actually -EINVAL) for frequency:

# cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
4294967274

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
---

diff --git a/arch/x86/kernel/cpu/cpufreq/pcc-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/pcc-cpufreq.c
index 4f6f679..4a5a42b 100644
--- a/arch/x86/kernel/cpu/cpufreq/pcc-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/pcc-cpufreq.c
@@ -195,7 +195,7 @@ static unsigned int pcc_get_freq(unsigned int cpu)
 cmd_incomplete:
 	iowrite16(0, &pcch_hdr->status);
 	spin_unlock(&pcc_lock);
-	return -EINVAL;
+	return 0;
 }
 
 static int pcc_cpufreq_target(struct cpufreq_policy *policy,
