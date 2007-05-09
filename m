From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Laptop screen doesn't come on when lid is reopened
Date: Wed, 9 May 2007 19:30:36 -0300
Message-ID: <20070509223036.GA11911@khazad-dum.debian.net>
References: <463E37EE.2060008@gentoo.org> <200705091148.21097.lenb@kernel.org> <20070509220007.GC9055@khazad-dum.debian.net> <20070509220412.GA12440@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44231 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753042AbXEIWam (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 18:30:42 -0400
Content-Disposition: inline
In-Reply-To: <20070509220412.GA12440@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Drake <dsd@gentoo.org>, linux-acpi@vger.kernel.org, luming.yu@intel.com

On Wed, 09 May 2007, Matthew Garrett wrote:
> On Wed, May 09, 2007 at 07:00:07PM -0300, Henrique de Moraes Holschuh wrote:
> > It will break all laptops which don't do anything special on lid events
> > other than report it to the OS, so that we can do whatever we want
> > (typically tell HAL or some script to suspend if the lid is closed).  Like,
> > say, thinkpads.
> 
> Why would it do that? The obvious risk is that calling _DSS would break 

I was not talking about calling _DSS per se, but calling it when you get lid
events.  Nevertheless, it was actually a big thinko.  It probably won't
break anything, as you said.  Sorry about that.

And, if it is actually needed to turn the backlight back on when you press
the lid *without triggering a suspend*, then it is probably going to be
necessary.

> things, but I haven't seen that on Thinkpads. I don't think Len's 
> proposing not passing the lid event through to userspace as well.

Correct.  As I said, it was a thinko on my part.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
