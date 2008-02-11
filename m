From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 0/5] Laptop driver documentation changes for 2.6.25
Date: Mon, 11 Feb 2008 19:29:29 +0000
Message-ID: <200802111929.30877.carlos@strangeworlds.co.uk>
References: <20080209013157.4895.70128.stgit@pacifica> <20080211112339.31ae3a68.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:57876 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760746AbYBKTaa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2008 14:30:30 -0500
In-Reply-To: <20080211112339.31ae3a68.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>, bart@samwel.tk

On Monday 11 February 2008 19:23:39 Randy Dunlap wrote:
> On Sat, 09 Feb 2008 01:31:57 +0000 Carlos Corbacho wrote:
> > The following series implements the proposed creation of
> > Documentation/laptops, and the movement of all the laptop driver
> > documentation to this directory. I've also taken the opportunity to tack
> > on the acer-wmi documentation in the final patch of this series.
> >
> > Because all the drivers in question go through the ACPI tree anyway, it's
> > probably easiest if this change goes through the ACPI tree as well.
> >
> > This should all be 2.6.25 material, since there is no code change here,
> > just rearranging the Documentation files, and updating Kconfig entries
> > where required. I've also tested this series against Linus' latest git
> > tree, with no problems applying it there.
>
> Hi,
> so should we also move Documentation/laptop-mode.txt to laptops/ dir?

[CC'ing Bart Samwel on this, as he wrote Documentation/laptop-mode.txt]

Yes, we probably should.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
