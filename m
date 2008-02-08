From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Laptop driver documentation
Date: Fri, 8 Feb 2008 13:11:14 -0200
Message-ID: <20080208151114.GE9485@khazad-dum.debian.net>
References: <200802081324.52405.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43380 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759752AbYBHPLU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 10:11:20 -0500
Content-Disposition: inline
In-Reply-To: <200802081324.52405.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, 08 Feb 2008, Carlos Corbacho wrote:
> I'm currently working on producing some documentation for acer-wmi, but before 
> submitting it, I'm wondering where the best place in Documentation/ is for it 
> to live?
> 
> The only other laptop driver I've seen so far in Documentation/ is 
> thinkpad-acpi, which has thinkpad-acpi.txt in the top level directory, but 

It was already there when I got it from the previous maintainer, so I left
it there...

> I'm not sure this is the best place for these to live. Would it be better to 
> perhaps group all laptop driver documentation in something like 
> Documentation/laptops/ (or something else along those lines), or should they 
> just be left in the top-level Documentation?

I wound't object to moving them to Documentation/laptops at all.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
