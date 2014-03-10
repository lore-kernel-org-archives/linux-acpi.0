From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/1] ACPI: Fix the incorrect behavior of the disabled
 ASPM on Haswell CPU
Date: Mon, 10 Mar 2014 16:24:10 +0000
Message-ID: <20140310162410.GA30930@srcf.ucam.org>
References: <6366A95FCFBB78419E783DDD020ED2ECB2F134@APMAILMBX03.lenovo.com>
 <20140310154530.GA27699@srcf.ucam.org>
 <6366A95FCFBB78419E783DDD020ED2ECB2F179@APMAILMBX03.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56163 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbaCJQYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2014 12:24:15 -0400
Content-Disposition: inline
In-Reply-To: <6366A95FCFBB78419E783DDD020ED2ECB2F179@APMAILMBX03.lenovo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Huang12 <ahuang12@lenovo.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Mar 10, 2014 at 04:17:05PM +0000, Adrian Huang12 wrote:
> On Mon, 2014-03-10 at 15:45 +0000, Matthew Garrett wrote:
> > On Mon, Mar 10, 2014 at 09:56:25AM +0000, Adrian Huang12 wrote:
> > > +		if (status == AE_NOT_FOUND &&
> > 
> > Why limit it to not found? 
> 
> Just for the undefined _OSC object in order to follow ACPI5.0.
> Looks like another approach should be implemented to address
> this issue. Is this what you were thinking of: we should never
> evaluate the _OSC object if it is the PCI root bridge?

No, I meant we should never set no_aspm because _OSC fails for any 
reason on a non-PCIe root bridge. But thinking about it, I suspect that 
the whole way we handle _OSC in this case is wrong. If a PCI host bridge 
does implement _OSC then there's still a good chance that it'll refuse 
to grant us control over ASPM, and so we may still end up with failure 
cases.

> > I suspect that we should never be basing our 
> > ASPM policy on the behaviour of PCI (rather than PCIe) bridges.
> 
> Yes, agree since the ASPM functionality is supported only for PCIe.
> Do you agree we should never evaluate the _OSC object if it is
> the PCI root bridge? 

Just skipping _OSC entirely in that case would certainly fix the issue, 
but it doesn't sound like the best fix. I think we need to revisit some 
assumptions in this code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
