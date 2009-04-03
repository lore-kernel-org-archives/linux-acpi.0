From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 01/10] ACPI: support acpi_device_ops .notify methods
Date: Fri, 3 Apr 2009 09:09:55 -0600
Message-ID: <200904030909.56982.bjorn.helgaas@hp.com>
References: <200904021556.32810.trenn@suse.de> <200904020903.21140.bjorn.helgaas@hp.com> <20090403090717.B9BE.E1E9C6FF@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:9436 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbZDCPKN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 11:10:13 -0400
In-Reply-To: <20090403090717.B9BE.E1E9C6FF@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Thomas Renninger <trenn@suse.de>, kamezawa.hiroyu@jp.fujitsu.com, Len Brown <lenb@kernel.org>, Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Thursday 02 April 2009 06:23:16 pm Yasunori Goto wrote:
> > On Thursday 02 April 2009 07:56:28 am Thomas Renninger wrote:
> > > I remember these two guys helped me testing on memory hotplug.
> > > They only had a simulator, but might want to give the latest kernel a try if
> > > you come to clean up acpi_memhotplug.c:
> > > kamezawa.hiroyu@jp.fujitsu.com
> > > Yasunori Goto <y-goto@jp.fujitsu.com>
> 
> I can use real machine which can memory hotplug.
> In our case, notify method is called for container device (NUMA node),
> and memory and processor devices are added under acpi_bus_scan().
> 
> I'll book it to test this patch in next week.
> It must be good test. :-)

Thomas is right; I don't think it's worth your time to do much testing
right now.  These patches only affect device notifications, and I think
the container/memory/processor stuff you're referring to depends on the
system notifications.  So this series should not affect the hotplug
path.

I am working on some changes to the hotplug path, but that looks much
more difficult, so it'll probably be a while before anything comes of
it.  Thanks for the tip; I'll make sure to CC: you when I post patches.

Bjorn
