From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: new fixes for sony-acpi
Date: Sat, 28 Mar 2009 14:44:26 +0000
Message-ID: <20090328144426.GA27812@srcf.ucam.org>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at> <200903280941.12955.matze@welwarsky.de> <20090328122213.GB24289@srcf.ucam.org> <200903281519.22250.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37232 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbZC1Oob (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 10:44:31 -0400
Content-Disposition: inline
In-Reply-To: <200903281519.22250.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 28, 2009 at 03:19:21PM +0100, Matthias Welwarsky wrote:
> On Saturday 28 March 2009 13:22:13 Matthew Garrett wrote:
> > The Dell XPS 13 has an identical _DSM despite having dual nvidia/nvidia
> > graphics. The _DSM code in the Vaio DSDT is also very stylistically
> > different to the rest of it, heavily supporting the idea that it's
> > nvidia-derived code.
> 
> Since it's not covered by any standard, I guess switching methods will deviate 
> over time as more hybrid graphics laptops are released. It could be 
> interesting to add generic functions to access _DSM methods, which is part of 
> the ACPI spec.

_DSM is only specced in the loosest of senses - it's just a standardised 
namespace and calling convention, with the method being able to do 
whatever it wants. Given that nvidia support the hybrid switching in 
their Windows drivers without needing third party support, I think it's 
pretty likely that they'll just extend the current interface rather than 
change it completely. Of course, Apple's solution is implemented 
differently.

> But first and foremost I'm interested in how to initialize it the secondary 
> adapter to the point where an X driver would be able to work with it. 
> Obviously _DSM is not enough. What could I try additionally?

You need to work out how to reinitialise the chip from cold. This is 
non-trivial. Start with nouveau - you'll need to extend the BIOS parsing 
and script execution to cover G80, but then it "should" just be a matter 
of calling the init script and letting the BIOS do the rest of the work.

> Oh, and no need to Cc me, I've subscribed to the list meanwhile.

It's normal practice on kernel lists. Set an appropriate header if you 
don't want them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
