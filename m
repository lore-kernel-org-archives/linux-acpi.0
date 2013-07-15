From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 12:06:11 -0300
Message-ID: <20130715150611.GC1074@khazad-dum.debian.net>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org>
 <1984598.ZdG0izCZul@skinner.arch.suse.de>
 <20130715123127.GC28266@khazad-dum.debian.net>
 <7120686.9AnYUBdZSM@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52224 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756020Ab3GOPGQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 11:06:16 -0400
Content-Disposition: inline
In-Reply-To: <7120686.9AnYUBdZSM@skinner.arch.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: oliver@neukum.org, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

On Mon, 15 Jul 2013, Thomas Renninger wrote:
> On Monday, July 15, 2013 09:31:27 AM Henrique de Moraes Holschuh wrote:
> > On Mon, 15 Jul 2013, Thomas Renninger wrote:
> > > On Monday, July 15, 2013 01:43:57 PM oliver@neukum.org wrote:
> > > > Some BIOSes change hardware based on the state of
> > > > a laptop's lid. If the lid is closed, the touchpad is
> > > > disabled and the checksum changes. Windows 8 no longer
> > > > aborts resume if the checksum has changed.
> > > 
> > > I expect more machines will show up and ignore s4_hardware_signature
> > > if Windows does not check it and we should do the same.
> > 
> > Windows *8* does not check.   But what about older versions?  Maybe this
> > needs to be guarded by verifying the firmware requested windows-8 mode?
> 
> I would not make it too complicated.
> Sticking to the latest Windows version should be enough for this one.
> What bad should happen if we still try to resume and fail...

Hmm, why was that check added in the first place?  If it is useless,
removing it for good is fine.  If it is _not_ useless, we should still do
the checking when not operating in windows-8 firmware mode.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
