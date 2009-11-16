From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] x86/cpufreq: don't use acpi_processor_get_bios_limit
 when not available
Date: Mon, 16 Nov 2009 15:32:42 -0800
Message-ID: <20091116153242.3c194a5a.randy.dunlap@oracle.com>
References: <20091116181453.b42247cf.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755937AbZKPXfR@vger.kernel.org>
In-Reply-To: <20091116181453.b42247cf.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, lenb@kernel.org, cpufreq@vger.kernel.org, akpm <akpm@linux-foundation.org>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, davej@redhat.com
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Only reference this function when the kconfig makes it available.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/x86/kernel/cpu/cpufreq/powernow-k7.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20091113.orig/arch/x86/kernel/cpu/cpufreq/powernow-k7.c
+++ linux-next-20091113/arch/x86/kernel/cpu/cpufreq/powernow-k7.c
@@ -717,7 +717,9 @@ static struct cpufreq_driver powernow_dr
 	.verify		= powernow_verify,
 	.target		= powernow_target,
 	.get		= powernow_get,
+#ifdef CONFIG_X86_POWERNOW_K7_ACPI
 	.bios_limit	= acpi_processor_get_bios_limit,
+#endif
 	.init		= powernow_cpu_init,
 	.exit		= powernow_cpu_exit,
 	.name		= "powernow-k7",
