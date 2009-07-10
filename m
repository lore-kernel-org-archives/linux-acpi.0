From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Fri, 10 Jul 2009 16:41:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907101630210.9103@localhost.localdomain>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
 <1245825558.19816.1861.camel@twins>
 <20090624074703.GA28458@sli10-desk.sh.intel.com>
 <1245830585.31755.11.camel@twins>
 <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
 <1246002370.31755.187.camel@twins>
 <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
 <1246955094.8143.110.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:60139 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757379AbZGJUmR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jul 2009 16:42:17 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KML00N962U205OA@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Jul 2009 15:42:03 -0500 (CDT)
In-reply-to: <1246955094.8143.110.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Shaohua Li <shaohua.li@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>


> > We'd like to ship the forced-idle thread as a self-contained driver,
> > if possilbe.  Because that would enable us to easily back-port it
> > to some enterprise releases that want the feature.  So if we can
> > implement this such that it is functional with existing scheduler
> > facilities, that would be get us by.  If the scheduler evolves
> > and provides a more optimal mechanism in the future, then that is
> > great, as long as we don't have to wait for that to provide
> > the basic version of the feature.
> 
> I don't think we should ever merge anything because of backports for
> stale kernels.
> 
> If you want it in enterprise stuff all you need is something upstream,
> and that something should be the scheduler driven bits.

Peter,
I'm glad that you agree that the forced-idle goals are worth-while,
and I'm delighted that you offer the scheduler to
implement a solution to this problem.

When will we see a scheduler API that we can call from our
ACPI notification driver to create idle-time on a busy system?

As you've seen in the driver, we are notified simply of the
total number of hardware threads to keep running.  Linux has
full freedom in selecting (and even moving) which processors are 
idled.

thanks,
-Len Brown, Intel Open Source Technology Center




