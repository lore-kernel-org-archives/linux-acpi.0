From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: cap off P-state transition latency from buggy BIOSes
Date: Fri, 20 Mar 2009 04:02:00 +0000
Message-ID: <20090320040200.GA29829@srcf.ucam.org>
References: <20090319214140.GA28868@linux-os.sc.intel.com> <20090319214746.GC24898@srcf.ucam.org> <20090320035016.GA28010@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37985 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZCTECJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Mar 2009 00:02:09 -0400
Content-Disposition: inline
In-Reply-To: <20090320035016.GA28010@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, Mar 20, 2009 at 12:50:16AM -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 19 Mar 2009, Matthew Garrett wrote:
> > On Thu, Mar 19, 2009 at 02:41:40PM -0700, Pallipadi, Venkatesh wrote:
> > > Fix it by capping-off the transition latency to 20uS for native MSR based
> > > frequency transitions.
> > > 
> > > Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > 
> > We've confirmed that this also helps on the X31.
> > 
> > Acked-by: Matthew Garrett <mjg@redhat.com>
> 
> Any chance of sending this to -stable after it hits mainline?  It is the
> sort of stuff a huge number of thinkpad users will want in their kernels
> ASAP...

I don't see why not.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
