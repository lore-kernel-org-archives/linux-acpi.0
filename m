From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic
 allocation
Date: Fri, 25 Aug 2006 16:27:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0608251622430.29284@twin.jikos.cz>
References: <200608150537.k7F5bTu8011560@shell0.pdx.osdl.net>
 <200608161902.02221.len.brown@intel.com> <Pine.LNX.4.58.0608171104390.28168@twin.jikos.cz>
 <200608240243.12218.len.brown@intel.com> <Pine.LNX.4.58.0608251057310.29284@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:64488 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750907AbWHYO1l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Aug 2006 10:27:41 -0400
In-Reply-To: <Pine.LNX.4.58.0608251057310.29284@twin.jikos.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 25 Aug 2006, Jiri Kosina wrote:

> > to address this on boot, Linux uses system-state. I suggested doing the
> > same for resume, but Andrew didn't like it, so here we are chasing a
> > bunch of spurious warning messages. Got any random examples that are
> > still valid in greg's tree, my tree, or the latest mm?
> Actually I just pulled from the acpi git tree, and with this kernel my IBM 
> T42p hangs approximately 10s after the kernel is started (hard lockup, no 
> caps/numlock). Will investigate.

Bisection shows that it is caused by commit 
f62d31ee2f2f453b07107465fea54540cab418eb ACPI: Support Processor Native 
C-state using Intel "mwait" instruction. 

I guess that the detection whether current CPU supports mwait insn does 
not work, but I am not too familiar with this.

cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 13
model name	: Intel(R) Pentium(R) M processor 1.80GHz
stepping	: 6
cpu MHz		: 1800.000
cache size	: 2048 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
bogomips	: 3590.77

-- 
JiKos.
