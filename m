From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: new fixes for sony-acpi
Date: Sat, 28 Mar 2009 12:19:54 +0000
Message-ID: <20090328121954.GA24289@srcf.ucam.org>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0903272132400.26419@localhost.localdomain> <20090328013832.GA4778@srcf.ucam.org> <200903280941.12955.matze@welwarsky.de> <358f4d650903280511r1c7ba88an14226c2f8f1438d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38669 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbZC1MT7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 08:19:59 -0400
Content-Disposition: inline
In-Reply-To: <358f4d650903280511r1c7ba88an14226c2f8f1438d8@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Albert Vilella <avilella@gmail.com>
Cc: Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Sat, Mar 28, 2009 at 12:11:51PM +0000, Albert Vilella wrote:

> I am right in thinking that reading the DSDT tables for hybrid
> graphics laptops is sufficient to infer their workings?

Yes, though nvidia and AMD use quite different approaches to this. The 
nvidia chips all appear to have a _DSM with the same UUID.

> I've been compiling a list of hybrid graphics laptops and been asking
> people to provide their DSDT tables
> in this bug report:
> https://bugs.launchpad.net/bugs/312756

Ah, convenient, thanks! I'd only had the Thinkpad DSDT to look at so 
far, so this gives me a chance to work out if there's any 
standardisation of the AMD approach.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
