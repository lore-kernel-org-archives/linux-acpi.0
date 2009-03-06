From: Daniel Silverstone <dsilvers@simtec.co.uk>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 06 Mar 2009 09:47:23 +0000
Message-ID: <1236332843.19146.4.camel@petitemort>
References: <20090306003941.GA32403@srcf.ucam.org>
	 <20090306005234.GA32539@srcf.ucam.org>
	 <1236330536.12838.2.camel@hughsie-work.lan>
Reply-To: dsilvers@simtec.co.uk
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from batfish.pepperfish.net ([87.237.62.180]:54039 "EHLO
	flounder.pepperfish.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750865AbZCFJr2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2009 04:47:28 -0500
In-Reply-To: <1236330536.12838.2.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Fri, 2009-03-06 at 09:08 +0000, Richard Hughes wrote:
> On Fri, 2009-03-06 at 00:52 +0000, Matthew Garrett wrote:
> > Calling the ENAB method on Toshiba laptops results in notifications 
> > being sent when laptop hotkeys are pressed. This patch simply calls that 
> > method and sets up an input device if it's successful.
> Great news - no polling!

No polling is definitely a good thing.

> Definitely +1 from me.

I'll be a touch less gung-ho than Richard though.

Have you looked at whether or not this method functions on more than the
one laptop? Toshiba are notoriously good at getting their own interfaces
wrong from one laptop to another. In addition, the fn+whatever keymaps
are often different between laptops, especially for things like the WWW
or MAIL buttons. Presumably if the hotkeys fail to activate then the
normal /proc/acpi/toshiba/keys thing will continue?

How will it interact with software stacks like HAL when the lock button
is pressed?

The patch itself looks clean and nice, I'm just concerned about its
behaviour from laptop-to-laptop. Particularly the key-map thing.

D.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895


