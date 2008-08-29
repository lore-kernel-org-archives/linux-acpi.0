From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] Documentation: Provide Documenation/udev.txt
Date: Fri, 29 Aug 2008 17:30:57 +0200
Message-ID: <1220023857.24737.52.camel@lgn.site>
References: <20080205021658.4422.83165.stgit@pacifica>
	 <200808272121.54882.carlos@strangeworlds.co.uk>
	 <20080827204449.GA14925@srcf.ucam.org>  <200808291705.38954.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65150 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbYH2Pb0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Aug 2008 11:31:26 -0400
In-Reply-To: <200808291705.38954.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, 2008-08-29 at 17:05 +0200, Thomas Renninger wrote:
> Subject was:
> Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
> 
> On Wednesday 27 August 2008 22:44:49 Matthew Garrett wrote:
> > On Wed, Aug 27, 2008 at 09:21:54PM +0100, Carlos Corbacho wrote:
> > > Can we abuse uevent and cram all the GUID's into just one MODALIAS line?

How many id's of what size do we have? What would be the maximum string
length?

> > Looking at the udev rules, I suspect we need one event per GUID.
> >
> > > Alternatively, maybe just have the directories numbered 1 to X, and have
> > > a uevent file under each, since we don't care about trying to abuse sysfs
> > > to let userspace talk to WMI anymore.

A "uevent" file? That file is mechanic of the driver-core and created
automatically for every device. It has well defined behaviour, like you
can trigger a uevent action, or read the event environment. Custom
subdirs with custom "uevent" files would not do anything, I guess. You
would need a "struct device" for every directory and uevent file. 

What do you have in mind? Care to paste-in some example strings?

> > Yeah, that'd work for me.
> 
> You should add Kay if you get stuck...
> Based on Kay's recent description on the linux-acpi list I set up
> this documentation. IMO it's worth adding, Andi, Kay?

Oh, that sounds a bit too much like "talking". I guess, it should be
rewritten, before it goes into the Documentation directory. :)

Thanks,
Kay

