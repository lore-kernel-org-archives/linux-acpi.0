From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Mon, 23 Mar 2009 21:22:46 +0100
Message-ID: <200903232122.46939.rjw@sisk.pl>
References: <49C484B7.20100@goop.org> <200903231920.12991.rjw@sisk.pl> <20090323195227.GB30693@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32982 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbZCWUWw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Mar 2009 16:22:52 -0400
In-Reply-To: <20090323195227.GB30693@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, 'Jeremy Fitzhardinge' <jeremy@goop.org>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

On Monday 23 March 2009, Matthew Garrett wrote:
> On Mon, Mar 23, 2009 at 07:20:12PM +0100, Rafael J. Wysocki wrote:
> > On Monday 23 March 2009, Tian, Kevin wrote:
> > > And then Xen jumps in to finish remaining steps. From this angle,
> > > Xen is not a completely new platform and, well, S3 is more like a
> > > 'S1' type from dom0's p.o.v with a different trigger method. Then is
> > > it overkilled to introduce a new set of ops with 99% content 
> > > duplicated?
> > 
> > IMO, no, it isn't.
> 
> I'd disagree. Duplicating the code means remembering to apply bugfixes 
> to both parts.

What code are you referring to exactly?  The callbacks that are literally the
same can be pointed to by the new set of operations just fine.

Thanks,
Rafael
