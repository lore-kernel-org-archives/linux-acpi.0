From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control
	brightness with hotkeys
Date: Sun, 12 Apr 2009 01:58:18 -0300
Message-ID: <20090412045818.GA8211@khazad-dum.debian.net>
References: <49E10684.5090101@gmail.com> <20090411150555.8b13ed18.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40485 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752099AbZDLE6X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2009 00:58:23 -0400
Content-Disposition: inline
In-Reply-To: <20090411150555.8b13ed18.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Niel Lambrechts <niel.lambrechts@gmail.com>, "linux.kernel" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, 11 Apr 2009, Andrew Morton wrote:
> > options thinkpad_acpi experimental=1 hotkey=enable,0xffffff

Someday someone might be able to give me a good reason for why the hell
distros like to do this sort of crap...  but I don't think it will be
anytime soon.

> > Any ideas on how I can regain control over the brightness gas-pedal?

I think what you're experiencing is some sort of breakage in ACPI video...

> > WARNING: at drivers/platform/x86/thinkpad_acpi.c:2954
> > hotkey_enabledisable_warn+0x3e/0x43 [thinkpad_acpi]()
> > thinkpad_acpi: hotkey enable/disable functionality has been removed from
> > the driver. Hotkeys are always enabled.

I will silence the warning for module parameters, thanks for the head's up.
That was indeed an oversight.

But it is a red-herring, it doesn't change the driver behaviour at all in
this case...

> > thinkpad_acpi: Standard ACPI backlight interface available, not loading
> > native one.

And this has always been true for any Lenovo Vista BIOS, it is not new.

I really think we need to get the people dealing with ACPI video in the
loop for this one.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
