From: Daniel Silverstone <dsilvers@simtec.co.uk>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 06 Mar 2009 10:04:21 +0000
Message-ID: <1236333861.19146.9.camel@petitemort>
References: <20090306003941.GA32403@srcf.ucam.org>
	 <20090306005234.GA32539@srcf.ucam.org>
	 <1236330536.12838.2.camel@hughsie-work.lan>
	 <1236332843.19146.4.camel@petitemort> <20090306095623.GA6014@srcf.ucam.org>
Reply-To: dsilvers@simtec.co.uk
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from batfish.pepperfish.net ([87.237.62.180]:45321 "EHLO
	flounder.pepperfish.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750960AbZCFKE0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2009 05:04:26 -0500
In-Reply-To: <20090306095623.GA6014@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Fri, 2009-03-06 at 09:56 +0000, Matthew Garrett wrote:
> > Have you looked at whether or not this method functions on more than the
> > one laptop? Toshiba are notoriously good at getting their own interfaces
> > wrong from one laptop to another.
> It's present on every Toshiba DSDT I have that has a VALD/VALZ method.

Nod, I shall have to have a check through the ones here if I can.

> > In addition, the fn+whatever keymaps are often different between 
> > laptops, especially for things like the WWW or MAIL buttons. 
> > Presumably if the hotkeys fail to activate then the normal 
> > /proc/acpi/toshiba/keys thing will continue?
> Yes, it'll be as functional as it was previously. They can be remapped 
> on machines that have a different keymap.

Since I don't understand the input layer well enough yet, can you
confirm if it is possible to add new mappings in without changing the
source? I.E. if laptop <foo> has another hotkey not yet considered, is
it just an FDI for hal, or is it a source change in the kernel?

> > How will it interact with software stacks like HAL when the lock button
> > is pressed?
> I don't really understand the question?

It was more: will events come out of both the notify method *and*
the /proc/acpi/toshiba/keys stuff, or will they only come out of the
notify method if it can be enabled? (I'm just trying to establish that
things polling /proc/acpi/toshiba/keys won't end up causing duplicated
events).

Assuming I'm just being over-paranoid or not understanding the minutae,
then I give this a +1 because the behaviour is certainly desirable since
it'll allow the tosh laptops to not wake up regularly to check for
hotkeys.

D.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895


