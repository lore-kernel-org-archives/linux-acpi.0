From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Fri, 4 Jul 2008 09:07:54 -0300
Message-ID: <20080704120754.GC7435@khazad-dum.debian.net>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080704034419.GG4381@prithivi.gnumonks.org> <20080704091031.GA8905@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42959 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752950AbYGDMH7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 08:07:59 -0400
Content-Disposition: inline
In-Reply-To: <20080704091031.GA8905@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

On Fri, 04 Jul 2008, Matthew Garrett wrote:
> I'd still have a preference for not including the proc_generate_event 
> stuff, but I'm not sure that there's any real consensus on that so I'm 
> not going to block it.

FWIW, thinkpad-acpi had to keep the proc_generate_event stuff (it is an
established ABI for thinkpad-acpi since 2.6.12 or thereabouts...), but it
does NOT issue those events over netlink at all, so anyone switching to the
new ACPI event infrastructure is forced to also switch to the input-device
infrastructure to get hotkey presses.

And once /proc/acpi is gone, the old way will be gone.

Unless someone posts a recipe here of how to get HAL to connect to an input
device, and how to tell it to run code when a KEY_* event is received (which
you could add to the driver documentation), I'd say proc_generate_event will
have to be tolerated.  It is all most people know how to deal with in
userspace.

So, FW(little)IW...
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
