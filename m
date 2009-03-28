From: Len Brown <lenb@kernel.org>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Fri, 27 Mar 2009 21:01:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903272049230.26419@localhost.localdomain>
References: <49C484B7.20100@goop.org>
 <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>
 <49C88647.8080404@goop.org> <200903241045.19194.bjorn.helgaas@hp.com>
 <49C91832.8090300@goop.org>
 <4F65016F6CB04E49BFFA15D4F7B798D9944E2524@orsmsx506.amr.corp.intel.com>
 <alpine.LFD.2.00.0903271744340.26419@localhost.localdomain>
 <49CD5F33.7050100@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:57910 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbZC1BBq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 21:01:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH600HT1YUWSOHC@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 20:01:45 -0500 (CDT)
In-reply-to: <49CD5F33.7050100@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Cihula, Joseph" <joseph.cihula@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wang, Shane" <shane.wang@intel.com>


> > Jeremy, I'm not excited about a proposed change to acpixf.h --
> > this is the API to ACPICA...
> >   
> Do you have an issue with the mechanism (using weak function, etc), or just
> the placement of the prototypes in that header?  Would there be a better
> header to put them in?  Or would you prefer some other mechanism?
> 
> It certainly seems like Xen and tboot should be able to share the same hook,
> given that they're doing similar things for similar reasons.
> 
> (I don't really understand the structure of all the acpi stuff; I'm just
> wading in and making a mess of things until I can close the lid of laptop
> successfully.)

Everything in acpi/acpica/ is source code that we share with BSD
via the ACPICA project http://acpica.org/

ACPICA also supplies a couple of the headers outside that directory,
eg. acpixf.h, which is the API between the kernel and ACPICA.

We can, and do, change that API when it makes sense.
However, we want to think carefully before changing it,
for we either cause Linux to diverge, or we have to sell
the same change to several other operating systems.
So ideally we wouuld need to make no Linux-specific, or Xen-specific
changes in that directory.

One possibility is to have this called via
function pointer from ASM and scribble over the default
function pointer for the Xen case.  In that case, the Xen
version of the routine would live someplace other than acpi/acpica/ -
someplace with the word xen in the path.  If using _weak can effectively
do that at link time, then fine, if we can do it w/o changing the API --
a _weak annotation is an easy ACPICA/Linux divergencen to manage.

I don't know if Xen and TXT are exclusive, or if we'd ever need
to handle both cases at the same time.  I guess that will influence
if the TXT and Xen use the same approach or something different.

thanks,
Len Brown, Intel Open Source Technology Center

