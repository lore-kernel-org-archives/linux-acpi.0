From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Backlight device class redesign
Date: Thu, 3 Dec 2009 08:52:23 -0200
Message-ID: <20091203105223.GB32571@khazad-dum.debian.net>
References: <b170af450911271630k63fb857auf8314cecd6219eba@mail.gmail.com>
 <b170af450911291209o33ebfc36n850826e54096f3b4@mail.gmail.com>
 <1259827274.27069.50.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44255 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754518AbZLCKwT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 05:52:19 -0500
Content-Disposition: inline
In-Reply-To: <1259827274.27069.50.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Rafa?? Mi??ecki <zajec5@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>

On Thu, 03 Dec 2009, Zhang Rui wrote:
> For example, device /sys/class/backlight/panel0 is created the first
> time a backlight_ops for this display is registered.
> And create the symbol link from the backlight class device to "physical
> device" (device that invokes backlight_device_register) in the backlight
> class device driver, if we really need it.
> Remove and recreate a link pointing to the new physical device when the
> backlight mode is changed.

FWIW, I agree the above solution is simple enough and quite good enough.

I just have absolutely _NO_ idea whatsoever how a platform driver can ask
the PCI or APCI layer "where is the video device driving the LVDS panel so
that I can bind to it"...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
