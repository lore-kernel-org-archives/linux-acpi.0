From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 8/8] CPUFREQ: Add documentation for new average_freq cpufreq_stats sysfs file
Date: Fri, 17 Apr 2009 16:22:12 +0200
Message-ID: <1239978132-6261-9-git-send-email-trenn@suse.de>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49968 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358AbZDQOWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Apr 2009 10:22:14 -0400
In-Reply-To: <1239978132-6261-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, venkatesh.pallipadi@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Cc: <linux-acpi@vger.kernel.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <cpufreq@vger.kernel.org>
---
 Documentation/cpu-freq/cpufreq-stats.txt |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
index fc64749..aa05b65 100644
--- a/Documentation/cpu-freq/cpufreq-stats.txt
+++ b/Documentation/cpu-freq/cpufreq-stats.txt
@@ -44,11 +44,28 @@ the stats driver insertion.
 total 0
 drwxr-xr-x  2 root root    0 May 14 16:06 .
 drwxr-xr-x  3 root root    0 May 14 15:58 ..
+-r--r--r--  1 root root 4096 May 14 16:06 average_freq
 -r--r--r--  1 root root 4096 May 14 16:06 time_in_state
 -r--r--r--  1 root root 4096 May 14 16:06 total_trans
 -r--r--r--  1 root root 4096 May 14 16:06 trans_table
 --------------------------------------------------------------------------------
 
+-  average_freq
+Shows the average frequency the processor stayed in since the file was read
+the last time. Zero is shown if it is read the first time or "not supported".
+
+CONFIG_X86_AVERAGE_FREQUENCY=y config needs to be set and the processor must
+support overclocking of single cores (ida flag in /proc/cpuinfo).
+This is the only way to detect, monitor and optimze for the feature that the
+BIOS can overclock single CPU cores behind the kernel's back if thermal
+requirements are met (e.g. other cores of the socket run at low frequency or
+sleep).
+
+Also on multi-core processors the shown current CPU frequency the machine is
+running on in cpufreq/cpufreq_scaling_cur and /proc/cpuinfo can be wrong with
+current kernels if the frequency of several cores must be the same because of
+HW restritions. average_freq should show the real frequency.
+
 -  time_in_state
 This gives the amount of time spent in each of the frequencies supported by
 this CPU. The cat output will have "<frequency> <time>" pair in each line, which
-- 
1.6.0.2

