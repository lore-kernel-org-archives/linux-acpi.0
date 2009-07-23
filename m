From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] powernow-k8: don't load powernow-k8 driver when acpi=off
Date: Thu, 23 Jul 2009 12:09:12 +0200
Message-ID: <200907231209.13343.trenn@suse.de>
References: <1248315070.2670.16.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47859 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbZGWKJO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2009 06:09:14 -0400
In-Reply-To: <1248315070.2670.16.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: davej@redhat.com, linux-acpi <linux-acpi@vger.kernel.org>, cpufreq@vger.kernel.org, Len Brown <lenb@kernel.org>, howl.nsp@gmail.com, "Langsdorf, Mark" <mark.langsdorf@amd.com>

On Thursday 23 July 2009 04:11:10 Zhang Rui wrote:
> when acpi=off, powernow-k8 driver is still loaded, and fails with
> a firmware bug warning message.
> http://bugzilla.kernel.org/show_bug.cgi?id=13695#c5
> 
> this is misleading,
> we should not load powernow-k8 driver when acpi=off.
> http://bugzilla.kernel.org/show_bug.cgi?id=13695

Maybe this one is better:
  - It allows these special, deprecated PSB BIOS structure
    use in acpi=off case
  - It complains that powernow-k8 won't work without ACPI, instead
    of complaining about the BIOS missing _PSS ACPI structures
    (in acpi=off case).

Compile tested on latest 2.6.31-rc2.

   Thomas

----
CPUFREQ: Avoid powernow-k8 BIOS complains when acpi=off

  - It still allows these special, deprecated PSB BIOS structure
    use in acpi=off case
  - It complains that powernow-k8 won't work without ACPI, instead
    of complaining about the BIOS missing _PSS ACPI structures
    (in acpi=off case).

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 arch/x86/kernel/cpu/cpufreq/powernow-k8.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: cpufreq_governor_cleanups/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
--- cpufreq_governor_cleanups.orig/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
+++ cpufreq_governor_cleanups/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
@@ -1286,7 +1286,11 @@ static int __cpuinit powernowk8_cpu_init
 		 * an UP version, and is deprecated by AMD.
 		 */
 		if (num_online_cpus() != 1) {
-			printk_once(ACPI_PSS_BIOS_BUG_MSG);
+			if (acpi_disabled)
+				printk_once(KERN_WARN PFX
+					    "ACPI disabled, exiting\n");
+			else
+				printk_once(ACPI_PSS_BIOS_BUG_MSG);
 			goto err_out;
 		}
 		if (pol->cpu != 0) {

