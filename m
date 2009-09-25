From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
 management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
 cpuidle to POWER.
Date: Fri, 25 Sep 2009 11:35:56 +0200
Message-ID: <20090925113556.4e1b1c4a@infradead.org>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
	<20090924051238.GA5963@linux.vnet.ibm.com>
	<20090924142228.5a2ddf59@infradead.org>
	<20090925070623.GH8595@dirshya.in.ibm.com>
	<1253868864.10287.3.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34970 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZIYJgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2009 05:36:19 -0400
In-Reply-To: <1253868864.10287.3.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: svaidy@linux.vnet.ibm.com, arun@linux.vnet.ibm.com, Len Brown <lenb@kernel.org>, Joel Schopp <jschopp@austin.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>, Gautham R Shenoy <ego@in.ibm.com>, Shaohua Li <shaohua.li@intel.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org

On Fri, 25 Sep 2009 10:54:24 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Fri, 2009-09-25 at 12:36 +0530, Vaidyanathan Srinivasan wrote:
> > * Arjan van de Ven <arjan@infradead.org> [2009-09-24 14:22:28]:
> > 
> > > On Thu, 24 Sep 2009 10:42:41 +0530
> > > Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:
> > > 
> > > > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-22
> > > > 16:55:27]:
> > > > 
> > > > Hi Len, (or other acpi folks),
> > > > 
> > > > I had a question regarding ACPI-cpuidle interaction in the
> > > > current implementation.
> > > > 
> > > > Currently, every cpu (i.e. acpi_processor) registers to cpuidle
> > > > as a cpuidle_device. So every cpu has to go through the process
> > > > of setting up the idle states and then registering as a cpuidle
> > > > device.
> > > > 
> > > > What exactly is the reason behind this?
> > > > 
> > > 
> > > technically a BIOS can opt to give you C states via ACPI on some
> > > cpus, but not on others.
> > > 
> > > in practice when this happens it tends to be a bug.. but it's
> > > technically a valid configuration
> > 
> > So we will need to keep the per-cpu registration as of now because
> > we may have such buggy BIOS in the field and we don't want the
> > cpuidle framework to malfunction there.
> 
> If the BIOS doesn't mention a certain C state on a cpu, and you try to
> set it anyway, does that go boom?
> 
> This whole per-cpu registration thing is horridly ugly, can't you
> have a per-cpu C state exception mask and leave it at that -- if its
> really needed?

the real solution is to make the acpi code always know about C1, even
if the bios doesn't.... That's one for Len :)

(C1 is just "hlt", what we do in the other idle loop ;-) 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
