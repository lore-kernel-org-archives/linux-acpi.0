From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH - 2.6.19 -0/2] Backport of psmouse suspend/shutdown cleanups
Date: Wed, 21 Feb 2007 18:59:06 -0200
Message-ID: <20070221205906.GA31788@khazad-dum.debian.net>
References: <1172077685.10619.101.camel@d36.suse.de> <20070221195203.GF3732@elf.ucw.cz> <45DCAA21.4030900@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50806 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423110AbXBUU7X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Feb 2007 15:59:23 -0500
Content-Disposition: inline
In-Reply-To: <45DCAA21.4030900@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Thomas Renninger <trenn@suse.de>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 21 Feb 2007, Alexey Starikovskiy wrote:
> Pavel Machek wrote:
> >2) Fix is very disconnected from the problem. "Deinitialize mouse so
> >that fans work after reboot". WTF?
> >  
> ACPI spec implies that EC controller and PS/2 mouse/keyboards controller
> are one entity.  So if mouse screws up "its" controller, it screws up EC
> as well, meaning fans will not work.

I would be *far* more worried about it screwing up the battery charging
control loop.  ECs often handle far more dangerous stuff than fans.  I don't
know if that's the case with the HP models, but it *is* the case for all
ThinkPads for example: messing with the EC is messing with the stuff that
controls the incendiary bomb in your lap.

If it can't be fixed, the machines should be blacklisted.  Slowly killing
the machine by shutting down its fans is bad enough to warrant that, anyway.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
