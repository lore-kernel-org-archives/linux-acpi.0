From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 14:44:56 +0200
Message-ID: <7120686.9AnYUBdZSM@skinner.arch.suse.de>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org> <1984598.ZdG0izCZul@skinner.arch.suse.de> <20130715123127.GC28266@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39817 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675Ab3GOMpA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 08:45:00 -0400
In-Reply-To: <20130715123127.GC28266@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: oliver@neukum.org, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

On Monday, July 15, 2013 09:31:27 AM Henrique de Moraes Holschuh wrote:
> On Mon, 15 Jul 2013, Thomas Renninger wrote:
> > On Monday, July 15, 2013 01:43:57 PM oliver@neukum.org wrote:
> > > Some BIOSes change hardware based on the state of
> > > a laptop's lid. If the lid is closed, the touchpad is
> > > disabled and the checksum changes. Windows 8 no longer
> > > aborts resume if the checksum has changed.
> > 
> > I expect more machines will show up and ignore s4_hardware_signature
> > if Windows does not check it and we should do the same.
> 
> Windows *8* does not check.   But what about older versions?  Maybe this
> needs to be guarded by verifying the firmware requested windows-8 mode?

I would not make it too complicated.
Sticking to the latest Windows version should be enough for this one.
What bad should happen if we still try to resume and fail...

      Thomas
