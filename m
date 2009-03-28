From: Len Brown <lenb@kernel.org>
Subject: Re: new fixes for sony-acpi
Date: Fri, 27 Mar 2009 21:34:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903272132400.26419@localhost.localdomain>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:23227 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZC1Beb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 21:34:31 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7003T20DFR9DH@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 20:34:29 -0500 (CDT)
In-reply-to: <20090323163459.GB5463@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: sony-vaio-z-series@lists.launchpad.net, Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org



--
Len Brown, Intel Open Source Technology Center

On Mon, 23 Mar 2009, Norbert Preining wrote:

> Hi Sony Vaio Z list,
> 
> after some discussion Matthew has provided a nice patch that makes the
> Fn-F5 and Fn-F6 keys working, and also S1 and S2.
> 
> I have adapted the speed-stamina patch from Matthias.
> 
> The following patches are only interesting for people running 2.6.29-rc
> kernels (afais)
> 
> So attached are two patches:
> - sony-laptop-matthew-version5.patch
>   latest version from Matthew with some keys creating events
> 
> - sony-laptop.c-speed-stamina-latest.patch
>   patch to add speed-stamina switch based on the 0.7 module of Matthias
> 
> Thanks a lot to Matthew and Matthias for working on that.

I assume that Matthew's rfkill patch later sent to me via Mattia replaces
what was in this message.

What about the speed/stamina stuff -- is anybody testing it?

thanks,
-Len

