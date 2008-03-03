From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 0/5] Laptop driver documentation changes for 2.6.25
Date: Mon, 3 Mar 2008 14:27:02 -0800
Message-ID: <20080303142702.33483f97.randy.dunlap@oracle.com>
References: <20080209013157.4895.70128.stgit@pacifica>
	<20080211112339.31ae3a68.randy.dunlap@oracle.com>
	<200802111929.30877.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:60116 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbYCCW1g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Mar 2008 17:27:36 -0500
In-Reply-To: <200802111929.30877.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>, bart@samwel.tk

On Mon, 11 Feb 2008 19:29:29 +0000 Carlos Corbacho wrote:

> On Monday 11 February 2008 19:23:39 Randy Dunlap wrote:
> > On Sat, 09 Feb 2008 01:31:57 +0000 Carlos Corbacho wrote:
> > > The following series implements the proposed creation of
> > > Documentation/laptops, and the movement of all the laptop driver
> > > documentation to this directory. I've also taken the opportunity to tack
> > > on the acer-wmi documentation in the final patch of this series.
> > >
> > > Because all the drivers in question go through the ACPI tree anyway, it's
> > > probably easiest if this change goes through the ACPI tree as well.
> > >
> > > This should all be 2.6.25 material, since there is no code change here,
> > > just rearranging the Documentation files, and updating Kconfig entries
> > > where required. I've also tested this series against Linus' latest git
> > > tree, with no problems applying it there.
> >
> > Hi,
> > so should we also move Documentation/laptop-mode.txt to laptops/ dir?
> 
> [CC'ing Bart Samwel on this, as he wrote Documentation/laptop-mode.txt]
> 
> Yes, we probably should.

Hi Bart,
Is that OK with you?
if we move laptop-mode.txt to the Documenation/laptops/ sub-directory?


---
~Randy
