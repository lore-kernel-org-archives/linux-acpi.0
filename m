From: Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v4 2/5] x86: fix memory corruption in acpi_unmap_lsapic()
Date: Mon, 14 Apr 2014 17:11:14 +0200
Message-ID: <1397488277-14865-3-git-send-email-imammedo@redhat.com>
References: <1397488277-14865-1-git-send-email-imammedo@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397488277-14865-1-git-send-email-imammedo@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, imammedo@redhat.com, bp@suse.de, paul.gortmaker@windriver.com, JBeulich@suse.com, prarit@redhat.com, drjones@redhat.com, toshi.kani@hp.com, riel@redhat.com, gong.chen@linux.intel.com, andi@firstfloor.org, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

if during CPU hotplug master CPU failed to wake up AP
it set percpu x86_cpu_to_apicid to BAD_APICID=0xFFFF for AP.

However following attempt to unplug that CPU will lead to
out of bound write access to __apicid_to_node[] which is
32768 items long on x86_64 kernel.

So drop setting x86_cpu_to_apicid to BAD_APICID in do_boot_cpu()
and allow acpi_processor_remove()->acpi_unmap_lsapic() cleanly
remove CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 arch/x86/kernel/smpboot.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6124f15..2988f69 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -859,8 +859,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 
 		/* was set by cpu_init() */
 		cpumask_clear_cpu(cpu, cpu_initialized_mask);
-
-		per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
 	}
 
 	/* mark "stuck" area as not stuck */
-- 
1.7.1
