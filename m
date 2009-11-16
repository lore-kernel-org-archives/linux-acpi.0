From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: multiple APIC/MADT found
Date: Mon, 16 Nov 2009 19:53:17 +0000
Message-ID: <20091116195317.GA28570@srcf.ucam.org>
References: <200911131338.38528.ffl@aber.ac.uk> <200911160940.24046.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39482 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbZKPTxV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2009 14:53:21 -0500
Content-Disposition: inline
In-Reply-To: <200911160940.24046.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Fred Labrosse <ffl@aber.ac.uk>, linux-acpi@vger.kernel.org

On Mon, Nov 16, 2009 at 10:40:18AM -0600, Bjorn Helgaas wrote:
> On Friday 13 November 2009 06:38:38 am Fred Labrosse wrote:
> > So I did that (acpi_apic_instance=2) and that did give me 2 processors.  
> > Which is definitely better, hence my email to the suggested address.
> 
> I think we need a DMI or similar mechanism to do this automatically,
> so you don't need to use "acpi_apic_instance=2" every time you boot.
> Can you open a bug report at http://bugzilla.kernel.org, attach the
> output of dmidecode, and post the bug URL here?

Ugh. Can we at least take a look at the differences and try to work out 
why one works? I hate to keep making this point, but Windows doesn't 
use whitelisting or blacklisting to any significant extent on modern 
hardware. If it's booting properly and we're not, then it's because 
we're doing something wrong.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
