From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Tue, 24 Mar 2009 10:45:18 -0600
Message-ID: <200903241045.19194.bjorn.helgaas@hp.com>
References: <49C484B7.20100@goop.org> <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com> <49C88647.8080404@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:26738 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761891AbZCXQpY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 12:45:24 -0400
In-Reply-To: <49C88647.8080404@goop.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

On Tuesday 24 March 2009 01:05:43 am Jeremy Fitzhardinge wrote:
> Tian, Kevin wrote:
> > OK, then it's safe to avoid that change. I had thought that dom0's 0-1M
> > is identity-mapped to machine 0-1M... :-)
> 
> No, only the ISA 640k-1M region.

I'm speaking out of turn here because I don't work on Xen or
suspend/resume.  However, I do try to clean up random bits of
ACPI, and I have to say this patch looks like a pain in the
maintenance department.  Having tests for a specific hypervisor
is unpleasant.  We don't want to end up with tests for a collection
of hypervisors.  It looks like suspend becomes a weird hybrid of
ACPI and Xen, which makes it harder to reason about future suspend
changes.  And all this discussion about 640k-1M and dom0 identity
mapping and "there's no special effort to remap it" and whether
there are conflicts makes me nervous.  There's no way all those
assumptions can be remembered or verified five years down the road.

Bjorn
