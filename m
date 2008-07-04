From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Fri, 4 Jul 2008 17:18:18 -0300
Message-ID: <20080704201818.GC27898@khazad-dum.debian.net>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080704034419.GG4381@prithivi.gnumonks.org> <20080704091031.GA8905@srcf.ucam.org> <20080704120754.GC7435@khazad-dum.debian.net> <20080704121116.GA11510@srcf.ucam.org> <20080704122247.GF7435@khazad-dum.debian.net> <20080704123312.GA11829@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43236 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752118AbYGDU2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 16:28:16 -0400
Content-Disposition: inline
In-Reply-To: <20080704123312.GA11829@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

On Fri, 04 Jul 2008, Matthew Garrett wrote:
> On Fri, Jul 04, 2008 at 09:22:47AM -0300, Henrique de Moraes Holschuh wrote:
> > On Fri, 04 Jul 2008, Matthew Garrett wrote:
> > > hal has bound to input devices for years. It won't run code directly, 
> > > since that's a policy decision, but lshal -m should show events come 
> > > from input devices.
> > 
> > Is there an easy way to duplicate what acpid does (i.e. give HAL some config
> > file that tells it to run an extrenal script when it gets a certain event)?
> > If there is not, it is no wonder people don't want to go away from acpid and
> > we have to keep proc_generate_event around...
> 
> Right, that's why I'm not encouraging its removal from any existing 
> drivers at the moment. I was under the impression that there was an 
> acpid that could listen for input devices somewhere, but I'm having 
> trouble finding that now. Hm.

Can't we add that to HAL?  It is not ACPI specific, and it IS useful as all
heck for 'system-wide' behaviour (otherwise one could use whatever the
desktop environment's default "special key mapping" utility is).

Another major extreme annoyance is the X.org evdev driver.  Besides the
(very unfortunate) fact that it simply doesn't work right, that thing
insists on doing an exclusive grab of any input device you give it (for
security reasons, I suppose), which actually means you need to handle the
special input events inside X as well.

Things like that make me wonder if I shouldn't be issuing the thinkpad-acpi
events that are mapped to input events also over netlink.  Well, I will wait
until we get a proper replacement for proc-based acpid, first.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
