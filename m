From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v1 3/5] ipmi: remove unused PCI probe coded
Date: Wed, 2 Dec 2009 14:42:55 -0700
Message-ID: <200912021442.56255.bjorn.helgaas@hp.com>
References: <20091118000427.14214.14043.stgit@bob.kio> <200912021253.00726.bjorn.helgaas@hp.com> <E0AA796A7E3F4C4E8F1065D15FE478618CE8B806@EXCH-MBX-4.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:28706 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbZLBVs1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2009 16:48:27 -0500
In-Reply-To: <E0AA796A7E3F4C4E8F1065D15FE478618CE8B806@EXCH-MBX-4.vmware.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bela Lubkin <blubkin@vmware.com>
Cc: "minyard@acm.org" <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Len Brown <lenb@kernel.org>

On Wednesday 02 December 2009 02:04:09 pm Bela Lubkin wrote:
> Bjorn Helgaas wrote:
> 
> > The original 5-patch series leaves the PCI base address alone.  That's
> > the same as the old behavior for HP devices, and we verified that it
> > works on an HP DL380G6 by disabling SMBIOS/SMPI/PNP detection.  (We
> > also verified that, as you would expect, it did NOT work if we increment
> > the base address).
> ...
> > So the question is what to do about non-HP PCI IPMI interfaces.  The
> > pre-b0defcdbd2b7d code increments the base address, but that's been
> > gone for several years.  Since we've had no complaints, and we don't
> > know about any non-HP PCI interfaces, I propose that we just remove
> > that HP-specific adjustment completely, i.e., use this series as-is.
> 
> Much older HP systems had a PCI SMIC interface.  Are you
> sure those haven't been broken somewhere along the way?
> 
> (Please don't say "we don't care about things that old".)

I want to make all machines, including old ones, work :-)

Restoring the behavior of incrementing the base address for HP
interfaces *might* fix an old machine that has been broken since
mid 2006 (when b0defcdbd2b7d went in), but we *know* it would
break current machines.

At this point, I think the only real option is to preserve the
behavior we've had since mid 2006 and fix old machines if and
when we discover them.

Bjorn
