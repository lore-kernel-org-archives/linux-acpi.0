From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/11] ACPI: update debug parameter documentation
Date: Thu, 06 Nov 2008 17:15:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811061705450.3106@localhost.localdomain>
References: <20081105231710.26131.3110.stgit@bob.kio>
 <20081105231737.26131.62046.stgit@bob.kio>
 <alpine.LFD.2.00.0811061502100.3106@localhost.localdomain>
 <200811061422.39997.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:47236 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYKFWW3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 17:22:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9X00JFKN5QCEC0@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 16:15:28 -0600 (CST)
In-reply-to: <200811061422.39997.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Renninger <trenn@suse.de>



> > $ cat /sys/module/acpi/parameters/debug_layer

> I don't really like having the whole list in the doc either.
> One problem with using only a pointer to the sysfs file is
> that you have to have a booted machine with ACPI_DEBUG=y.

Good point.
Maybe in kernel-parameters.txt we should point to
a Documedntation/acpi/debug.txt file with this stuff in it?

> We could use a pointer to acoutput.h, especially if we moved
> the driver definitions there.  It's still a minor irritation
> that the source code says "ACPI_DEBUG_PRINT((ACPI_DB_INFO ..."
> and you have to work back to the ACPI_LV_INFO definition before
> you have a mask value.  But the benefit of having only a single
> copy of the list is probably worth that irritation.

agreed.

> If you're willing to see the component definitions in acoutput.h,
> would you also want to change acpi/debug.c so it prints the
> driver bits individually?

re: acoutput.h
on second thought, putting them in acpi_drivers.h would be better,
b/c that is linux and acouput is ACPICA.
I think having them together is better than having them spread
around, but for readability and easy to verify by inspection
that we don't have any conflicting definitions.

re: acpi/debug.c
Honestly, greg hates for us to print stuff in sysfs files,
but we decided it was worth his wrath for this case b/c
we had it in /proc and this documentation was so poorly documented.
Making the print-out longer will not make him happier,
but we're already going to burn in sysfs hell for our sins:-)

> > > +	  When no parameters are supplied, the default settings cause AML
> > > +	  stores to the "Debug" object to produce console output.
> > 
> > I think Thomas may have changed this at SuSE b/c they ship
> > with CONFIG_ACPI_DEBUG=y, if so, maybe upstream should also?
> 
> Yeah, I don't really like the default mask being non-zero.
> I seem to have a bunch of machines that spew lots of debug
> output.  Possibly these are protos with old firmware, but I
> suspect we shipped firmware that uses Debug.
> 
> I didn't change it because the default is currently set in
> the CA somewhere.  I guess we could override it early in
> acpi_init() or something.

I'd apply a patch to change the default -- as long as we document it.

thanks,
-Len

