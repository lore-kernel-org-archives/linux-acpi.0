From: Dave Jones <davej@redhat.com>
Subject: Re: [2.6 patch] the overdue removal of X86_SPEEDSTEP_CENTRINO_ACPI
Date: Mon, 2 Jul 2007 20:36:48 -0400
Message-ID: <20070703003648.GA31035@redhat.com>
References: <20070701202037.GC10869@stusta.de> <20070702232255.GH6403@redhat.com> <20070702234313.GB3492@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758659AbXGCAiV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070702234313.GB3492@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 03, 2007 at 01:43:13AM +0200, Adrian Bunk wrote:
 > > Applying '[CPUFREQ] the overdue removal of X86_SPEEDSTEP_CENTRINO_ACPI'
 > > 
 > > error: patch failed: arch/x86_64/kernel/cpufreq/Kconfig:65
 > > error: arch/x86_64/kernel/cpufreq/Kconfig: patch does not apply
 > 
 > I made the patch against 2.6.22-rc6-mm1 (based on an older version of 
 > this patch)  but I missed the fuzz (and GNU patch defaults to accept
 > patches with a fuzz of 2).
 > 
 > Below is a version of the patch with the fuzz edited out.

It also has the context edited out :)

 > @@ -65,1 +60,1 @@
 > -	depends on X86_ACPI_CPUFREQ || X86_SPEEDSTEP_CENTRINO_ACPI || X86_POWERNOW_K8_ACPI
 > +	depends on X86_ACPI_CPUFREQ || X86_POWERNOW_K8_ACPI
 > --- linux-2.6.20-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.old	2007-02-17 23:29:53.000000000 +0100
 > +++ linux-2.6.20-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2007-02-17 23:30:44.000000000 +0100

This won't apply either.

	Dave

-- 
http://www.codemonkey.org.uk
