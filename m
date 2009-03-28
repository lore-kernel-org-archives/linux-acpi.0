From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: new fixes for sony-acpi
Date: Sat, 28 Mar 2009 12:22:13 +0000
Message-ID: <20090328122213.GB24289@srcf.ucam.org>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0903272132400.26419@localhost.localdomain> <20090328013832.GA4778@srcf.ucam.org> <200903280941.12955.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59861 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbZC1MWR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 08:22:17 -0400
Content-Disposition: inline
In-Reply-To: <200903280941.12955.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 28, 2009 at 09:41:12AM +0100, Matthias Welwarsky wrote:

> Looking at the somewhat twisted way the Sony DSDT code handles power 
> management for the graphics adapters, I have my doubts that there will be a 
> generic way. Of course a framework like for the rf kill switch could be 
> useful, but the vendor and model specific code would end up in sony-laptop 
> anyway.

The Dell XPS 13 has an identical _DSM despite having dual nvidia/nvidia 
graphics. The _DSM code in the Vaio DSDT is also very stylistically 
different to the rest of it, heavily supporting the idea that it's 
nvidia-derived code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
