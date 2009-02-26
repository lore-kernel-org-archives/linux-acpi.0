From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/3] ACPI: pci: make new pci.h header local to driver
Date: Thu, 26 Feb 2009 12:45:22 -0700
Message-ID: <200902261245.22991.bjorn.helgaas@hp.com>
References: <20090219195009.20619.20334.stgit@bob.kio> <alpine.LFD.2.00.0902212322310.5009@localhost.localdomain> <200902241206.08528.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:5443 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbZBZTp0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 14:45:26 -0500
In-Reply-To: <200902241206.08528.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tuesday 24 February 2009 12:06:07 pm Bjorn Helgaas wrote:
> On Saturday 21 February 2009 09:28:31 pm Len Brown wrote:
> > I like this patch, but not wild about the name "pci.h"
> > 
> > there are already about 20 pci.h files in the tree.
> > sure, they are context specific, but still i don't like it.
> > 
> > (and I don't like having 11 acpi.h files in the tree either...)
> > 
> > how about acpi_pci.h?
> > 
> > yeah, i know it would be redundant, as it lives in drivers/acpi/ 
> > but as basically everything it the file starts with "acpi_pci..."
> > maybe a little redundancy can be seen as consistent?
> 
> Personally, I *like* the fact that we have a hierarchy where the
> context provides useful information.

P.S.  My opinion here might be influenced by the fact that I always use
"cscope -p4".  Cscope users who use the default (show only one path
component) would benefit a lot more from having redundant information
in the filename.

Bjorn
