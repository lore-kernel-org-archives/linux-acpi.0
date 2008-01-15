From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: sata_nv does not function in kernel > 2.6.20.21... possible ACPI or PCI involvement?
Date: Tue, 15 Jan 2008 09:47:07 -0700
Message-ID: <200801150947.07998.bjorn.helgaas@hp.com>
References: <20080112205939.GA5291@mhcomputing.net> <200801141702.26914.bjorn.helgaas@hp.com> <20080115043804.GA17040@mhcomputing.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:14925 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbYAOQqs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jan 2008 11:46:48 -0500
In-Reply-To: <20080115043804.GA17040@mhcomputing.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Matthew Hall <mhall@mhcomputing.net>, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Monday 14 January 2008 09:38:04 pm Matthew Hall wrote:
> On Mon, Jan 14, 2008 at 05:02:26PM -0700, Bjorn Helgaas wrote:
> > I think this is a bug in the BIOS description of the motherboard
> > device.  In 2.6.20, the PNP system driver reserved ioport resources
> > but ignored mmio resources.  In 2.6.23, the system driver reserves
> > both ioport and mmio resources, which I think is more correct, but
> > exposes this bug.
> 
> Bjorn,
> 
> I complained to Supermicro and mentioned that the beta BIOS they 
> provided to one of the customers in the Redhat Bugzilla threads did not 
> solve the issue at all. I also included links to both Bugzilla threads 
> as well as a link to the mail you sent back to me as snipped above which 
> contained your excellent analysis of the problem.

My patch is based on the assumption that a PCI resource (like the
SATA BAR here) is completely discoverable and configurable through
the standard PCI mechanisms, and it therefore should not also be
described as a resource of an ACPI device.

If Supermicro went to the trouble of providing a beta BIOS, maybe
they're interested enough to shed some light on why their BIOS does
it this way.  It's possible that my assumption is wrong, and Linux
is just not doing the right thing.  If you have a Supermicro contact,
you might pass this by them.

> > I posted the attached test patch to the redhat bugzilla above, but
> > nobody's tested it yet.  Can you try it?
> 
> The patch applied, booted, ran, and solved the problem perfectly. Do you 
> want any output or configuration files to verify anything? Let me know 
> if there is anything I can do to help. Other than that if you think it 
> is safe to apply this, I am in favor of adding it to the mainline or 
> other appropriate tree.

I'll clean up the patch and post it.  With luck, it might show up in
the -mm tree soon and then in 2.6.25.

Bjorn
