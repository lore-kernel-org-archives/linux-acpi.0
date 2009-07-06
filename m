From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Tue, 7 Jul 2009 01:43:46 +0200
Message-ID: <20090706234346.GA8072@basil.fritz.box>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com> <1245825558.19816.1861.camel@twins> <20090624074703.GA28458@sli10-desk.sh.intel.com> <1245830585.31755.11.camel@twins> <20090624082112.GA20844@sli10-desk.sh.intel.com> <20090626181623.GF7717@dirshya.in.ibm.com> <20090629025455.GA20614@sli10-desk.sh.intel.com> <20090706180312.GC26831@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:39151 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbZGFXns (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2009 19:43:48 -0400
Content-Disposition: inline
In-Reply-To: <20090706180312.GC26831@dirshya.in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "lenb@kernel.org" <lenb@kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

On Mon, Jul 06, 2009 at 11:33:12PM +0530, Vaidyanathan Srinivasan wrote:
> > > 
> > > How do we handle interrupts and timers during this interval?  You seem
> > > to disable interrupts and hold the cpu at idle for 0.95 sec.  It may
> > > cause timeouts and overflows for network interrupts right?
> > The x86 mwait/monitor instruction can detect interrupt and complete execution
> > even interrupt is disabled, so this isn't an issue.
> 
> Cool, this will save a lot of trouble :)

This is only available in newer Intel CPUs. 

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
