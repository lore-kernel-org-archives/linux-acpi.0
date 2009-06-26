From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Fri, 26 Jun 2009 20:49:08 +0100
Message-ID: <20090626194908.GA11492@srcf.ucam.org>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com> <1245825558.19816.1861.camel@twins> <20090624074703.GA28458@sli10-desk.sh.intel.com> <1245830585.31755.11.camel@twins> <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain> <1246002370.31755.187.camel@twins> <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47444 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708AbZFZTtP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 15:49:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Shaohua Li <shaohua.li@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

On Fri, Jun 26, 2009 at 12:46:53PM -0400, Len Brown wrote:

> Low Frequency Mode (LFM), aka Pn - the deepest P-state,
> is the lowest energy/instruction because it is this highest
> frequency available at the lowest voltage that can still
> retire instructions.
> 
> That is why it is the first method used -- it returns the
> highest power_savings/performance_impact.

For a straightforward workload on a dual package system, do you get more 
performance from two packages running at their lowest P state or from 
one package at its highest P state and a forced-idle package? Which 
consumes more power?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
