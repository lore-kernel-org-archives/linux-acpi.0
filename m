From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: Thinkpad X200s
Date: Mon, 30 Nov 2009 09:50:02 +0000
Message-ID: <4B13954A.9040307@collabora.co.uk>
References: <4B0FB618.7020204@collabora.co.uk> <20091127221134.GC21775@khazad-dum.debian.net> <20091128120711.GA17894@khazad-dum.debian.net> <4B111C58.5050006@collabora.co.uk> <20091128181512.GA32630@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:51228 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbZK3Jug (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2009 04:50:36 -0500
In-Reply-To: <20091128181512.GA32630@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:

>> Cheers - I'll keep an eye on this thread so I can test your patch ASAP! :-)
> 
> And I will _need_ your help.  Here is a tentative patch.  I can use a much
> heavier hand than this, but if the firmware cooperates, this one should do
> it (and it will be faster, to boot).
> 
> Please check if WWAN, bluetooth and if at all possible, UWB are doing the
> right thing:
> 
> remain enabled if you suspend with them enabled.

Yes, and:

> remain disabled if you suspend with they disabled.

Yes   (bluetooth and WWAN)

*BUT* If I toggle the hard RF killswitch, they all forget themselves and
reset to 'on' rather than their last known state. IOW, they are
disabled, then unconditionally re-enabled.

> And in the case of WWAN and bluetooth, whether they retain their state
> (enabled or disabled) across reboots and shutdown.

Yes - although GNOME interferes with that later...

> If you happen to find out that UWB also retains state across
> reboot/shutdown, I'd like to know about it.

I know nothing about the X200s UWB - what module would I need to test?

Hope this helps,

-Ian
