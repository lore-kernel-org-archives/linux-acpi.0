From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: multiple APIC/MADT found
Date: Mon, 16 Nov 2009 14:12:38 -0600
Message-ID: <200911161312.41923.bjorn.helgaas@hp.com>
References: <200911131338.38528.ffl@aber.ac.uk> <200911160940.24046.bjorn.helgaas@hp.com> <20091116195317.GA28570@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:18174 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbZKPUMo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2009 15:12:44 -0500
In-Reply-To: <20091116195317.GA28570@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Fred Labrosse <ffl@aber.ac.uk>, linux-acpi@vger.kernel.org

On Monday 16 November 2009 12:53:17 pm Matthew Garrett wrote:
> On Mon, Nov 16, 2009 at 10:40:18AM -0600, Bjorn Helgaas wrote:
> > On Friday 13 November 2009 06:38:38 am Fred Labrosse wrote:
> > > So I did that (acpi_apic_instance=2) and that did give me 2 processors.  
> > > Which is definitely better, hence my email to the suggested address.
> > 
> > I think we need a DMI or similar mechanism to do this automatically,
> > so you don't need to use "acpi_apic_instance=2" every time you boot.
> > Can you open a bug report at http://bugzilla.kernel.org, attach the
> > output of dmidecode, and post the bug URL here?
> 
> Ugh. Can we at least take a look at the differences and try to work out 
> why one works? I hate to keep making this point, but Windows doesn't 
> use whitelisting or blacklisting to any significant extent on modern 
> hardware. If it's booting properly and we're not, then it's because 
> we're doing something wrong.

I agree; in fact, my reply included a line like "Why can Windows do
this properly when Linux can't," but I deleted it because it seems
like that's all I ever say :-)

Bottom line from the user's point of view: having to use
"acpi_apic_instance=2" is unacceptable.

Bjorn
