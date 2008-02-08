From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Laptop driver documentation
Date: Fri, 8 Feb 2008 17:49:47 +0000
Message-ID: <200802081749.48470.carlos@strangeworlds.co.uk>
References: <200802081324.52405.carlos@strangeworlds.co.uk> <20080208151114.GE9485@khazad-dum.debian.net> <20080208092800.832b05d1.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:47539 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760497AbYBHRuP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 12:50:15 -0500
In-Reply-To: <20080208092800.832b05d1.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Friday 08 February 2008 17:28:00 Randy Dunlap wrote:
> sony-laptop.txt
> sonypi.txt

Thanks - I was certain I'd missed a few.

> > > I'm not sure this is the best place for these to live. Would it be
> > > better to perhaps group all laptop driver documentation in something
> > > like Documentation/laptops/ (or something else along those lines), or
> > > should they just be left in the top-level Documentation?
> >
> > I wound't object to moving them to Documentation/laptops at all.
>
> Yes, agreed.

Ok, I'll whip up a patch set to do this.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
