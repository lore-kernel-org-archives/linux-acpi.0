From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: passive cooling policy
Date: Sun, 12 Sep 2004 13:15:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040912111549.GA18788@dominikbrodowski.de>
References: <413CA0D9.5030901@renninger.de> <20040908085423.GA7785@dominikbrodowski.de> <414417A4.3070009@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <414417A4.3070009-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Sep 12, 2004 at 11:32:20AM +0200, Thomas Renninger wrote:
> >Why do cpufreq daemons want to know that? And the ordering is important:
> >first scale CPU frequency be means of cpufreq, _then_ throttle the CPU.
> Maybe I miss some easy solution to work around this problem, but 
> currently I have the problem that:
> 
> E.g. machine enters passive cooling mode, cpu usage is high, cpufreq 
> daemon sets machine to highest cpufreq step, but it is ignored.
> Processor cools down, cpu usage is still high, cpufreq is still in 
> lowered step, because the daemon thinks it already set the frequency to 
> highest step.
> 
> I did a short test some time ago and I thought that kernel does not 
> remember userspace cpufreq settings while in passive mode.
> I currently see three solutions for this:
> 
> Checking whether the cpufreq setting really took place.
> Polling whether machine is in passive cooling mode.
> Last and for my opinion most proper one is by just send a thermal event 
> when entering/leaving passive cooling mode. I saw that some kind of 
> hysteresis algorithm is implemented, so the event should not be thrown 
> too often.

What about this patch? Untested, uncompiled, just that you get the picture.
As all changes in passive cooling utilizing cpufreq result in a
cpufreq_update_policy() call, and that calls the governor with
CPUFREQ_GOV_LIMITS, the userspace-desired frequency is restored. A good
side-effect is that resume doesn't need to be special-cased any longer.

--- 2.6.9-rc1+/drivers/cpufreq/cpufreq_userspace.c.orig	2004-09-05 14:16:26.000000000 +0200
+++ 2.6.9-rc1+/drivers/cpufreq/cpufreq_userspace.c	2004-09-12 13:12:50.881408256 +0200
@@ -68,7 +68,8 @@
  */
 static unsigned int	cpu_max_freq[NR_CPUS];
 static unsigned int	cpu_min_freq[NR_CPUS];
-static unsigned int	cpu_cur_freq[NR_CPUS];
+static unsigned int	cpu_cur_freq[NR_CPUS]; /* current CPU freq */
+static unsigned int	cpu_set_freq[NR_CPUS]; /* CPU freq desired by userspace */
 static unsigned int	cpu_is_managed[NR_CPUS];
 static struct cpufreq_policy current_policy[NR_CPUS];
 
@@ -82,13 +83,6 @@
 {
         struct cpufreq_freqs *freq = data;
 
-	/* Don't update cur_freq if CPU is managed and we're
-	 * waking up: else we won't remember what frequency 
-	 * we need to set the CPU to.
-	 */
-	if (cpu_is_managed[freq->cpu] && (val == CPUFREQ_RESUMECHANGE))
-		return 0;
-
 	cpu_cur_freq[freq->cpu] = freq->new;
 
         return 0;
@@ -119,6 +113,8 @@
 	if (freq > cpu_max_freq[cpu])
 		freq = cpu_max_freq[cpu];
 
+	cpufreq_set_freq[cpu] = freq;
+
 	/*
 	 * We're safe from concurrent calls to ->target() here
 	 * as we hold the userspace_sem lock. If we were calling
@@ -523,6 +519,7 @@
 		cpu_min_freq[cpu] = policy->min;
 		cpu_max_freq[cpu] = policy->max;
 		cpu_cur_freq[cpu] = policy->cur;
+		cpu_set_freq[cpu] = policy->cur;
 		sysfs_create_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		up(&userspace_sem);
@@ -532,6 +529,7 @@
 		cpu_is_managed[cpu] = 0;
 		cpu_min_freq[cpu] = 0;
 		cpu_max_freq[cpu] = 0;
+		cpu_set_freq[cpu] = 0;
 		sysfs_remove_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		up(&userspace_sem);
 		break;
@@ -539,15 +537,18 @@
 		down(&userspace_sem);
 		cpu_min_freq[cpu] = policy->min;
 		cpu_max_freq[cpu] = policy->max;
-		if (policy->max < cpu_cur_freq[cpu])
+		if (policy->max < cpu_cur_freq[cpu]) {
+			cpu_set_freq[cpu] = policy->max;
 			__cpufreq_driver_target(&current_policy[cpu], policy->max, 
 			      CPUFREQ_RELATION_H);
-		else if (policy->min > cpu_cur_freq[cpu])
+		} else if (policy->min > cpu_cur_freq[cpu]) {
+			cpu_set_freq[cpu] = policy->min;
 			__cpufreq_driver_target(&current_policy[cpu], policy->min, 
 			      CPUFREQ_RELATION_L);
-		else
-			__cpufreq_driver_target(&current_policy[cpu], cpu_cur_freq[cpu],
+		} else {
+			__cpufreq_driver_target(&current_policy[cpu], cpu_set_freq[cpu],
 			      CPUFREQ_RELATION_L);
+		}
 		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		up(&userspace_sem);
 		break;

> My main concern is stated above, but it could also be convenient for 
> informing the user or monitoring programs.

for the other reasons: OK.

	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
