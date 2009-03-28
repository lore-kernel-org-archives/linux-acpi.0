From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: new fixes for sony-acpi
Date: Sat, 28 Mar 2009 09:41:12 +0100
Message-ID: <200903280941.12955.matze@welwarsky.de>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0903272132400.26419@localhost.localdomain> <20090328013832.GA4778@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:28184
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZC1IlT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 04:41:19 -0400
Received: from wind.localnet (p54A7F3F8.dip.t-dialin.net [84.167.243.248])
	by basyskom.de (Postfix) with ESMTP id B7AF639C725
	for <linux-acpi@vger.kernel.org>; Sat, 28 Mar 2009 09:41:14 +0100 (CET)
In-Reply-To: <20090328013832.GA4778@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Saturday 28 March 2009 02:38:32 Matthew Garrett wrote:
> On Fri, Mar 27, 2009 at 09:34:23PM -0400, Len Brown wrote:
> > I assume that Matthew's rfkill patch later sent to me via Mattia replaces
> > what was in this message.
>
> Yes.
>
> > What about the speed/stamina stuff -- is anybody testing it?

The current code only powers down the Nvidia graphics adapter, it seems to 
work well for a number of people. However, its not really useful. For example, 
it doesn't allow to use the Nvidia card as the primary display adapter. 
Apparently it takes more then just calling the DSDT methods to enable the 
power supply, the card likely needs some PCI treatment as well so that its 
fully functional after switching it on. 

> The speed/stamina stuff isn't Sony specific. I'm working on an external
> module to handle that.

Looking at the somewhat twisted way the Sony DSDT code handles power 
management for the graphics adapters, I have my doubts that there will be a 
generic way. Of course a framework like for the rf kill switch could be 
useful, but the vendor and model specific code would end up in sony-laptop 
anyway.

regards,
matthias
