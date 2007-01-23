From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Idle loop causes speaker whine/buzz (!)
Date: Tue, 23 Jan 2007 19:48:39 -0200
Message-ID: <20070123214839.GA5905@khazad-dum.debian.net>
References: <20070123104010.GB7135@fscked.org> <20070123194509.GA8644@fscked.org> <20070123210042.GE32032@khazad-dum.debian.net> <200701231625.39684.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50049 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965092AbXAWVss (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 16:48:48 -0500
Content-Disposition: inline
In-Reply-To: <200701231625.39684.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Mike Perry <mikepery@fscked.org>, linux-acpi@vger.kernel.org

On Tue, 23 Jan 2007, Len Brown wrote:
> BTW. what model Thinkpad do you have?

I own a ThinkPad T43 with ATI graphics (I wish I had bought one with Intel
graphics, but they only had the crap screens on those), but I don't know if
Mike Perry has a ThinkPad at all.  It's just that whatever his laptop model,
these issues are probably generic ones.

Just FYI, the T43 runs 2.6.20-rc5+acpi-test without any new problems.  I
didn't try the acpi-acpica branch yet, though.

> The USB dependency is probably due to USB bus mastering causing
> the system to "pop" out of C3 to snoop the USB DMA traffic.

EHCI seems to not share the same issue.  OTOH, it draws a noticeable ammount
of power, so I end up rmmod'ing it (and uhci-hcd) when not using anything
USB.

> You can get rid of it by disabling USB.  But it sounds like in the full-on case
> you've got an issue even with USB disabled.  Or sometimes you can
> bias the system to simply not enter C3 if it sees bus master traffic with
> 
> # echo 0xFFFFFFFF > /sys/module/processor/parameters/bm_history

Hmm, this one is neat.  I will add it to the wiki.

> Another thing to try building the kernel with CONFIG_HZ=100 -- which
> is what a kernel for most laptops should be using in the first place.

Well, actually we should be using *tickless* kernels, and start a witch hunt
on userspace braindamage that wakes too often, but we are not there yet.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
