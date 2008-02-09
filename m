From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/5] Laptop driver documentation changes for 2.6.25
Date: Sat, 9 Feb 2008 16:22:17 -0200
Message-ID: <20080209182217.GA23736@khazad-dum.debian.net>
References: <20080209013157.4895.70128.stgit@pacifica> <200802090149.30282.carlos@strangeworlds.co.uk> <200802090412.57945.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:32946 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752607AbYBISWX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Feb 2008 13:22:23 -0500
Content-Disposition: inline
In-Reply-To: <200802090412.57945.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>, Mattia Dongili <malattia@linux.it>

On Sat, 09 Feb 2008, Len Brown wrote:
> On Friday 08 February 2008 20:49, Carlos Corbacho wrote:
> > On Saturday 09 February 2008 01:31:57 Carlos Corbacho wrote:
> > >       thinkpad-acpi - Move thinkpad-acpi.txt to Documentation/laptops
> > 
> > This patch [2/5] doesn't seem to have made it to the list. If it doesn't 
> > appear by the end of Saturday, I'll try resending it.
> 
> it was 110K, which exceeded the 100K message size of the list.
> 
> i'm fine with these changes if everybody else is.

As I said before, I am OK with them.

BTW Carlos, sending a git diff would have resulted in much smaller diffs
(since git diff can do renames instead of add/delete) :)  I believe all of
us can deal just fine with git diffs, so it makes sense to use them in these
cases.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
