From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Laptop driver documentation
Date: Fri, 8 Feb 2008 09:28:00 -0800
Message-ID: <20080208092800.832b05d1.randy.dunlap@oracle.com>
References: <200802081324.52405.carlos@strangeworlds.co.uk>
	<20080208151114.GE9485@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:29549 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763761AbYBHR35 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 12:29:57 -0500
In-Reply-To: <20080208151114.GE9485@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, 8 Feb 2008 13:11:14 -0200 Henrique de Moraes Holschuh wrote:

> On Fri, 08 Feb 2008, Carlos Corbacho wrote:
> > I'm currently working on producing some documentation for acer-wmi, but before 
> > submitting it, I'm wondering where the best place in Documentation/ is for it 
> > to live?
> > 
> > The only other laptop driver I've seen so far in Documentation/ is 
> > thinkpad-acpi, which has thinkpad-acpi.txt in the top level directory, but 
> 
> It was already there when I got it from the previous maintainer, so I left
> it there...

sony-laptop.txt
sonypi.txt

> > I'm not sure this is the best place for these to live. Would it be better to 
> > perhaps group all laptop driver documentation in something like 
> > Documentation/laptops/ (or something else along those lines), or should they 
> > just be left in the top-level Documentation?
> 
> I wound't object to moving them to Documentation/laptops at all.

Yes, agreed.

Thanks.
---
~Randy
