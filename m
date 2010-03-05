From: Myron Stowe <myron.stowe@hp.com>
Subject: Re: [PATCH 0/4] ipmi: remove SPMI and update core driver with
 dev_printk
Date: Fri, 05 Mar 2010 09:31:09 -0700
Message-ID: <1267806669.2411.73.camel@zim>
References: <20100304033146.30205.68689.stgit@bob.kio>
	 <4B8FBE8F.3030203@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:14896 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab0CEQbL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2010 11:31:11 -0500
In-Reply-To: <4B8FBE8F.3030203@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

On Thu, 2010-03-04 at 08:07 -0600, Corey Minyard wrote: 
> Myron Stowe wrote:
> > These patches remove the SPMI based IPMI device discovery mechanism and
> > update the driver's core to use dev_printk() and its constructs.
> >
> > As part of this patch series I wanted to remove the 'PFX' argument from
> > ipmi_of_probe()'s dev_printk constructs as I believe it produces redundant
> > output but I do not have a PPC platform to test against.
> >   
> I like the dev_printk() stuff.  The order of discovery change is 
> correct, too, I believe.  I don't have a PPC platform (with OF, anyway) 
> with IPMI, so I can't test that, either.

Bummer, I would have liked to clean up 'ipmi_of_probe()' as part of this
series as it is obvious it was not written in the style of the original
author - reading 'ipmi_pci_probe()', 'ipmi_pnp_probe()', and
'ipmi_of_probe()' side-by-side the latter sticks out like a sore thumb.
> 
> > Ultimately, I would like to see if it is possible to also remove IPMI's
> > SMBIOS based device discovery mechanism.
> >   
> Maybe in an ideal world, but I don't know where an ideal world is, so I 
> have to live in the one I'm in.  There's plenty of systems that only 
> document this in SMBIOS tables, there's plenty of systems with broken 
> ACPI, etc.  So SMBIOS and SPMI are going to have to stay.

It was a mistake on my part to make the comment about SMBIOS as the
patch series does not include such action and it unnecessarily creates
confusion with the current intent of removing SPMI as a discovery
method.

It would seem that the most likely situation requiring SPMI would be an
embedded system that does not use ACPI namespace and does not support
running Windows (Windows relies on ACPI namespace and/or PCI; it does
not look for, or use, SMBIOS and/or SPMI).  If anyone reading this
discussion thread knows of an explicit example in which SPMI is truly
required then obviously I would be wrong and could no longer pursue
such.  Its just that I'm not yet convinced of such based on my
experiences.

Myron

> -corey


-- 
Myron Stowe                             HP Open Source Linux Lab (OSLL)


