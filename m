From: Dave Jones <davej@redhat.com>
Subject: Re: [2.6 patch] the overdue removal of X86_SPEEDSTEP_CENTRINO_ACPI
Date: Mon, 2 Jul 2007 21:13:54 -0400
Message-ID: <20070703011354.GB31035@redhat.com>
References: <20070701202037.GC10869@stusta.de> <20070702232255.GH6403@redhat.com> <20070702234313.GB3492@stusta.de> <20070703003648.GA31035@redhat.com> <20070703010611.GD3492@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37741 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756808AbXGCBPh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Jul 2007 21:15:37 -0400
Content-Disposition: inline
In-Reply-To: <20070703010611.GD3492@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, Jul 03, 2007 at 03:06:11AM +0200, Adrian Bunk wrote:

 > >  > @@ -65,1 +60,1 @@
 > >  > -	depends on X86_ACPI_CPUFREQ || X86_SPEEDSTEP_CENTRINO_ACPI || X86_POWERNOW_K8_ACPI
 > >  > +	depends on X86_ACPI_CPUFREQ || X86_POWERNOW_K8_ACPI
 > >  > --- linux-2.6.20-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.old	2007-02-17 23:29:53.000000000 +0100
 > >  > +++ linux-2.6.20-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2007-02-17 23:30:44.000000000 +0100
 > > 
 > > This won't apply either.
 > 
 >   git-apply --unidiff-zero

git-apply isn't the same thing as git-applymbox. (which doesn't know that option)
The former involves a lot more hassle to get the changelog & comments
pasted in, along with it getting attribution correct automatically.

	Dave

-- 
http://www.codemonkey.org.uk
