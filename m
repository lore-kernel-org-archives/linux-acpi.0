From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Bogus "APIC: NR_CPUS/possible_cpus limit of 4 reached"
 messages
Date: Fri, 7 Oct 2016 15:55:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610071549330.19804@nanos>
References: <20161006112737.GA308@x4> <20161006124800.5a824dfc@lxorguk.ukuu.org.uk> <20161006115220.GB308@x4> <20161007132634.GA20654@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbcJGN6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2016 09:58:32 -0400
In-Reply-To: <20161007132634.GA20654@x4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Fri, 7 Oct 2016, Markus Trippelsdorf wrote:
> On 2016.10.06 at 13:52 +0200, Markus Trippelsdorf wrote:
> > On 2016.10.06 at 12:48 +0100, One Thousand Gnomes wrote:
> > > On Thu, 6 Oct 2016 13:27:37 +0200
> > > Markus Trippelsdorf <markus@trippelsdorf.de> wrote:
> > > 
> > > > On current trunk I get during boot:
> > > > 
> > > > [    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 4/0x84 ignored.
> > > > [    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 5/0x85 ignored.
> > > > 
> > > > I don't think these messages make much sense on a 4-core machine.
> > > > 
> > > 
> > > Four cores with or without hyperthreading ?
> > 
> > Without. This is a rather old AMD machine (AMD Phenom II X4 955).

That's due to the recent cpuid -> nodeid changes. The patch below should
fix it.

Thanks,

	tglx

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f266b8a92a9e..88c657b057e2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2128,9 +2128,11 @@ int __generic_processor_info(int apicid, int version, bool enabled)
 	if (num_processors >= nr_cpu_ids) {
 		int thiscpu = max + disabled_cpus;
 
-		pr_warning(
-			"APIC: NR_CPUS/possible_cpus limit of %i reached."
-			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
+		if (enabled) {
+			pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
+				   "reached. Processor %d/0x%x ignored.\n",
+				   max, thiscpu, apicid);
+		}
 
 		disabled_cpus++;
 		return -EINVAL;
