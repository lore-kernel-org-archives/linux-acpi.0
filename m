From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [PATCH 01/10] ACPI: support acpi_device_ops .notify methods
Date: Sat, 04 Apr 2009 07:43:51 +0900
Message-ID: <20090404074212.B9C4.E1E9C6FF@jp.fujitsu.com>
References: <20090403090717.B9BE.E1E9C6FF@jp.fujitsu.com> <200904030909.56982.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:49617 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937028AbZDCWr2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 18:47:28 -0400
In-Reply-To: <200904030909.56982.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Thomas Renninger <trenn@suse.de>, kamezawa.hiroyu@jp.fujitsu.com, Len Brown <lenb@kernel.org>, Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

> On Thursday 02 April 2009 06:23:16 pm Yasunori Goto wrote:
> > > On Thursday 02 April 2009 07:56:28 am Thomas Renninger wrote:
> > > > I remember these two guys helped me testing on memory hotplug.
> > > > They only had a simulator, but might want to give the latest kernel a try if
> > > > you come to clean up acpi_memhotplug.c:
> > > > kamezawa.hiroyu@jp.fujitsu.com
> > > > Yasunori Goto <y-goto@jp.fujitsu.com>
> > 
> > I can use real machine which can memory hotplug.
> > In our case, notify method is called for container device (NUMA node),
> > and memory and processor devices are added under acpi_bus_scan().
> > 
> > I'll book it to test this patch in next week.
> > It must be good test. :-)
> 
> Thomas is right; I don't think it's worth your time to do much testing
> right now.  These patches only affect device notifications, and I think
> the container/memory/processor stuff you're referring to depends on the
> system notifications.  So this series should not affect the hotplug
> path.

Ah, OK. I misunderstood something.
Sorry for noise.

> 
> I am working on some changes to the hotplug path, but that looks much
> more difficult, so it'll probably be a while before anything comes of
> it.  Thanks for the tip; I'll make sure to CC: you when I post patches.




-- 
Yasunori Goto 


