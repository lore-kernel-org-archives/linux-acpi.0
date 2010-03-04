From: Myron Stowe <myron.stowe@hp.com>
Subject: RE: [Openipmi-developer] [PATCH 2/4] ipmi: Remove SPMI table based
 device discovery method
Date: Thu, 04 Mar 2010 11:47:00 -0700
Message-ID: <1267728420.2437.162.camel@zim>
References: <20100304033146.30205.68689.stgit@bob.kio>
	 <20100304034415.30205.59685.stgit@bob.kio>
	 <E0AA796A7E3F4C4E8F1065D15FE478610176ABB89F@EXCH-MBX-4.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:16960 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab0CDSrB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2010 13:47:01 -0500
In-Reply-To: <E0AA796A7E3F4C4E8F1065D15FE478610176ABB89F@EXCH-MBX-4.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bela Lubkin <blubkin@vmware.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, 2010-03-03 at 23:56 -0800, Bela Lubkin wrote:
> Myron Stowe wrote:
> 
> > Remove optional ACPI static Service Processor Management Interface
> > (SPMI) table based IPMI device discovery mechanism.
> 
> Myron,
> 
> The other patches look reasonable.  This one, I'm not so sure.
> 
> My concern is based on these thoughts:
> 
> During early hardware bring-up, both ACPI and IPMI subsystems
> of a new system design tend to be a total mess.  The static
> table parts of ACPI are likely to be usable much earlier than
> the parts that require a fully functional ACPI subsystem.

Hi Bela:

ACPI in new systems does tend to present a lot of challenges.  My job is
new platform enablement focused which more often than not translates to
"helping discover and fix BIOS/ACPI issues" so I definitely understand.

You also astutely point out that ACPI's static tables are available for
use by an OS - or OSPM in ACPI speak - much earlier than its namespace.
This is true but it is also our belief that no one uses it except HP.

> 
> For the people developing and testing the new system's IPMI
> subsystem, losing the SPMI discovery method could be a
> significant pain point.
> 
> A new IPMI subsystem may also be "bolted on" to an existing
> system for early development before the new system is mature
> enough to even power on.  In such a situation it may be easier
> to supply a fake table than fake live ACPI information.  The
> hardware at that point may not be in PCI space, yet may also
> not be at static addresses that would be easy to supply as
> module load parameters.

The point that in such a situation providing static addresses as module
load parameters is not a tenable approach seems to be a stretch but that
is tangential to the main discussion so lets not muddy the discussion
with such unless you feel there is more to say.

I see how one's life could be easier relying on the BIOS setting up
static tables such as either the SMBIOS or SPMI.  That way the BIOS is
taking the dynamic aspects into account relieving the OS, or OS/platform
bring up engineer, from such.  In such a case, what benefits does the
SPMI table provide as opposed to the SMBIOS table?
> 
> I would be more comfortable if you kept this code, perhaps
> suppressed under a "CONFIG_IPMI_SPMI" config option.

I just don't see enough remaining value in keeping the SPMI table
capability.  It seems to be redundant, and if truly so, just adds
unnecessary code, complexity, and maintenance aspects to the driver.  We
typically don't keep code in the kernel just for bring up efforts.


Thanks very much for expressing your concerns here.  I fully expected,
and still expect, the SPMI removal patch to be the contentious component
of this series.  Fostering a healthy discussion in these regards should
eventually help us understand that removing such is in fact tenable or,
that there really are valid technical reasons why it is not.

Myron
> 
> >Bela<


-- 
Myron Stowe                             HP Open Source Linux Lab (OSLL)

