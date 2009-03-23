From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Mon, 23 Mar 2009 19:52:27 +0000
Message-ID: <20090323195227.GB30693@srcf.ucam.org>
References: <49C484B7.20100@goop.org> <49C67054.7020603@goop.org> <0A882F4D99BBF6449D58E61AAFD7EDD60E5E8766@pdsmsx502.ccr.corp.intel.com> <200903231920.12991.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41692 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133AbZCWT6t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 15:58:49 -0400
Content-Disposition: inline
In-Reply-To: <200903231920.12991.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, 'Jeremy Fitzhardinge' <jeremy@goop.org>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

On Mon, Mar 23, 2009 at 07:20:12PM +0100, Rafael J. Wysocki wrote:
> On Monday 23 March 2009, Tian, Kevin wrote:
> > And then Xen jumps in to finish remaining steps. From this angle,
> > Xen is not a completely new platform and, well, S3 is more like a
> > 'S1' type from dom0's p.o.v with a different trigger method. Then is
> > it overkilled to introduce a new set of ops with 99% content 
> > duplicated?
> 
> IMO, no, it isn't.

I'd disagree. Duplicating the code means remembering to apply bugfixes 
to both parts.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
