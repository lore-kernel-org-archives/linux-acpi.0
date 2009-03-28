From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: new fixes for sony-acpi
Date: Sat, 28 Mar 2009 15:19:21 +0100
Message-ID: <200903281519.22250.matze@welwarsky.de>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at> <200903280941.12955.matze@welwarsky.de> <20090328122213.GB24289@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:1875
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbZC1OT2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 10:19:28 -0400
Received: from wind.localnet (p54A7F3F8.dip.t-dialin.net [84.167.243.248])
	by basyskom.de (Postfix) with ESMTP id 6C55138EDB4
	for <linux-acpi@vger.kernel.org>; Sat, 28 Mar 2009 15:19:24 +0100 (CET)
In-Reply-To: <20090328122213.GB24289@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Saturday 28 March 2009 13:22:13 Matthew Garrett wrote:
> On Sat, Mar 28, 2009 at 09:41:12AM +0100, Matthias Welwarsky wrote:
> > Looking at the somewhat twisted way the Sony DSDT code handles power
> > management for the graphics adapters, I have my doubts that there will be
> > a generic way. Of course a framework like for the rf kill switch could be
> > useful, but the vendor and model specific code would end up in
> > sony-laptop anyway.
>
> The Dell XPS 13 has an identical _DSM despite having dual nvidia/nvidia
> graphics. The _DSM code in the Vaio DSDT is also very stylistically
> different to the rest of it, heavily supporting the idea that it's
> nvidia-derived code.

Since it's not covered by any standard, I guess switching methods will deviate 
over time as more hybrid graphics laptops are released. It could be 
interesting to add generic functions to access _DSM methods, which is part of 
the ACPI spec.

But first and foremost I'm interested in how to initialize it the secondary 
adapter to the point where an X driver would be able to work with it. 
Obviously _DSM is not enough. What could I try additionally?

Oh, and no need to Cc me, I've subscribed to the list meanwhile.

regards,
	matthias

