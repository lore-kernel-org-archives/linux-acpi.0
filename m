From: Matthew Hall <mhall@mhcomputing.net>
Subject: Re: sata_nv does not function in kernel > 2.6.20.21... possible
	ACPI or PCI involvement?
Date: Tue, 15 Jan 2008 04:38:04 +0000
Message-ID: <20080115043804.GA17040@mhcomputing.net>
References: <20080112205939.GA5291@mhcomputing.net> <200801141702.26914.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ip-163-246-113-216.pool.grokthis.net ([216.113.246.163]:3217
	"EHLO mail.mhcomputing.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751453AbYAOEiG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2008 23:38:06 -0500
Content-Disposition: inline
In-Reply-To: <200801141702.26914.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Mon, Jan 14, 2008 at 05:02:26PM -0700, Bjorn Helgaas wrote:
> I think this is a bug in the BIOS description of the motherboard
> device.  In 2.6.20, the PNP system driver reserved ioport resources
> but ignored mmio resources.  In 2.6.23, the system driver reserves
> both ioport and mmio resources, which I think is more correct, but
> exposes this bug.

Bjorn,

I complained to Supermicro and mentioned that the beta BIOS they 
provided to one of the customers in the Redhat Bugzilla threads did not 
solve the issue at all. I also included links to both Bugzilla threads 
as well as a link to the mail you sent back to me as snipped above which 
contained your excellent analysis of the problem.

> I posted the attached test patch to the redhat bugzilla above, but
> nobody's tested it yet.  Can you try it?

The patch applied, booted, ran, and solved the problem perfectly. Do you 
want any output or configuration files to verify anything? Let me know 
if there is anything I can do to help. Other than that if you think it 
is safe to apply this, I am in favor of adding it to the mainline or 
other appropriate tree.

> Bjorn

Thanks,
Matthew Hall
