From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] Notification on method execution
Date: Sun, 16 Sep 2007 11:38:24 -0300
Message-ID: <20070916143824.GA4869@khazad-dum.debian.net>
References: <20070915204923.GA27604@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59475 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752707AbXIPPFT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Sep 2007 11:05:19 -0400
Content-Disposition: inline
In-Reply-To: <20070915204923.GA27604@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Sat, 15 Sep 2007, Matthew Garrett wrote:
> For certain drivers (such as the Thinkpad ACPI driver[1]), it would be 
> helpful to be able to get notifications when a method is executed. I'd 
> propose adding a call like acpi_method_notify, extending the method 
> field to contain an extra flag for notifications and a callback, having 
> acpi_aml_execute check this before executing the methods and perhaps 
> checking the return code to decide whether to continue executing the 
> method or not (would potentially allow overriding methods, though I'm 
> not convinced it's a good idea). Does this sound basically sane? If so, 
> I'll do a patch.

Yes, I could certainly use something like this on thinkpad-acpi.  It is also
a great way to hot-fix DSDTs, although I don't think any such a hotfix is
the sort of thing I'd add to a Linux mainline driver.

However, this idea of yours looks like a hook API for the AML interpretor,
so I'd suggest you make it complete, and allow for callbacks that are called
BEFORE, AFTER, and INSTEAD of the AML method.

> [1] Various Thinkpads make predictable method calls when hotkeys are 
> pressed, but make no notifications. Hooking into those methods would 
> allow those keys to be caught without the requirement to repeatedly poll 
> the hardware to see if there's been an update.

I'm afraid the very old ones might lack the embedded controller support you
need, especially those without ACPI (but we don't support them anyway).

The entire T-series since the T40 (as long as you update the BIOS) support
all hotkeys in an event-driven fashion in the T43 style.  I am not sure of
the R5x series, but I'd be surprised if they don't support all hotkeys using
events, either.  The X-series since the X31 also support all hot keys using
events in their latest BIOSes.  The *60 and *61 series might have messes on
the volume and brightness key support due to Vista support changes to the
BIOS.

BUT it is certainly useful to have the such support. I am all for it, and
I'd be curious to know how well your trick works on a broad range of
thinkpads.  We can certainly add it to thinkpad-acpi if it is safe.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
