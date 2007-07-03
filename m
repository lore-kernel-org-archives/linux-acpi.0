From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] the overdue removal of X86_SPEEDSTEP_CENTRINO_ACPI
Date: Tue, 3 Jul 2007 03:06:11 +0200
Message-ID: <20070703010611.GD3492@stusta.de>
References: <20070701202037.GC10869@stusta.de> <20070702232255.GH6403@redhat.com> <20070702234313.GB3492@stusta.de> <20070703003648.GA31035@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48614 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755629AbXGCBFo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jul 2007 21:05:44 -0400
Content-Disposition: inline
In-Reply-To: <20070703003648.GA31035@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Mon, Jul 02, 2007 at 08:36:48PM -0400, Dave Jones wrote:
> On Tue, Jul 03, 2007 at 01:43:13AM +0200, Adrian Bunk wrote:
>  > > Applying '[CPUFREQ] the overdue removal of X86_SPEEDSTEP_CENTRINO_ACPI'
>  > > 
>  > > error: patch failed: arch/x86_64/kernel/cpufreq/Kconfig:65
>  > > error: arch/x86_64/kernel/cpufreq/Kconfig: patch does not apply
>  > 
>  > I made the patch against 2.6.22-rc6-mm1 (based on an older version of 
>  > this patch)  but I missed the fuzz (and GNU patch defaults to accept
>  > patches with a fuzz of 2).
>  > 
>  > Below is a version of the patch with the fuzz edited out.
> 
> It also has the context edited out :)

That's what I said.

>  > @@ -65,1 +60,1 @@
>  > -	depends on X86_ACPI_CPUFREQ || X86_SPEEDSTEP_CENTRINO_ACPI || X86_POWERNOW_K8_ACPI
>  > +	depends on X86_ACPI_CPUFREQ || X86_POWERNOW_K8_ACPI
>  > --- linux-2.6.20-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.old	2007-02-17 23:29:53.000000000 +0100
>  > +++ linux-2.6.20-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2007-02-17 23:30:44.000000000 +0100
> 
> This won't apply either.

  git-apply --unidiff-zero

git-apply defaulting to reject valid patches that are purposefully 
without context is IMHO plain silly. I'll ask the git maintainers to
change this.

> 	Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

