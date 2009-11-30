From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Thinkpad X200s
Date: Mon, 30 Nov 2009 21:47:06 -0200
Message-ID: <20091130234706.GC29580@khazad-dum.debian.net>
References: <4B0FB618.7020204@collabora.co.uk>
 <20091127221134.GC21775@khazad-dum.debian.net>
 <20091128120711.GA17894@khazad-dum.debian.net>
 <4B111C58.5050006@collabora.co.uk>
 <20091128181512.GA32630@khazad-dum.debian.net>
 <4B13954A.9040307@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46309 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753231AbZK3XrE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2009 18:47:04 -0500
Content-Disposition: inline
In-Reply-To: <4B13954A.9040307@collabora.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: linux-acpi@vger.kernel.org

On Mon, 30 Nov 2009, Ian Molton wrote:
> Henrique de Moraes Holschuh wrote:
> > remain disabled if you suspend with they disabled.
> 
> Yes   (bluetooth and WWAN)
> 
> *BUT* If I toggle the hard RF killswitch, they all forget themselves and
> reset to 'on' rather than their last known state. IOW, they are
> disabled, then unconditionally re-enabled.

This might well be userspace or the rfkill core, if the EC queues any
events and deliver them when the thinkad wakes up, they would enable the
radios in the default rfkill config.

Unfortunately, that's not something I can test on my T43.  Still, even
if it is the firmware doing that, I think we could live with it.

That said, please play with the master_switch_mode parameter of the
rfkill module.  I personally cannot tolerate anything but
master_switch_mode=1, and I dare think it might solve your problem :)

I think I can consider this patch approved and add your tested-by?

> > If you happen to find out that UWB also retains state across
> > reboot/shutdown, I'd like to know about it.
> 
> I know nothing about the X200s UWB - what module would I need to test?

I don't know if your x200s has an UWB radio.  Does thinkpad-acpi tells
you it exists?  There is a CONFIG_UWB option which enables UWB and WUSB
support.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
