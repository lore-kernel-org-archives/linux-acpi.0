From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Fri, 10 Jul 2009 15:31:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907101525560.9103@localhost.localdomain>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
 <1245825558.19816.1861.camel@twins>
 <20090624074703.GA28458@sli10-desk.sh.intel.com>
 <1245830585.31755.11.camel@twins>
 <20090624082112.GA20844@sli10-desk.sh.intel.com>
 <20090626181623.GF7717@dirshya.in.ibm.com>
 <20090629025455.GA20614@sli10-desk.sh.intel.com>
 <20090706180312.GC26831@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:44641 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbZGJTb0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jul 2009 15:31:26 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KMK009Y5ZJT1Z07@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Jul 2009 14:31:11 -0500 (CDT)
In-reply-to: <20090706180312.GC26831@dirshya.in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>


> Do you have some indicative data to show that arbitrary force-idling
> of hardware threads reduce power and heat?  It will be very good if
> this works without coordination among siblings.  Basically what you
> are saying is that running one or two of the force-idle threads in
> a 16-thread system provides significant reduction in power even
> without explicit methods to ensure that they idle sibling threads
> belonging to same core.

Re: siblings

Idling one HT sibling w/o idling the other saves almost very little power.
(On the flip side, the good news is that enabling HT consumes
 very little power:-)

So to save the most power possible,
the latest patch will attempt to idle 
threads in pairs of siblings.

But again, the driver is simply the messenger.  If the user
asks us to idle an odd number of threads, then one of them
will idle without idling its sibling.

cheers,
-Len Brown, Intel Open Source Technology Center


