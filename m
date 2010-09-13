From: Thomas Renninger <trenn@suse.de>
Subject: Re: getting new hardware (arbor M1526) buttons to work w/ acpi
Date: Mon, 13 Sep 2010 21:37:43 +0200
Message-ID: <201009132137.44002.trenn@suse.de>
References: <AANLkTinTLAhRL48sP=B86RMEahx2dg_aczuwS+vn78js@mail.gmail.com> <201009131657.48686.trenn@suse.de> <AANLkTinLh6_q3n8WQJ1DWrhepqXdCeNosRZh9ByY8qVh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34271 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989Ab0IMTh6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Sep 2010 15:37:58 -0400
In-Reply-To: <AANLkTinLh6_q3n8WQJ1DWrhepqXdCeNosRZh9ByY8qVh@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yedidia Klein <yedidia@atarplpl.co.il>
Cc: linux-acpi@vger.kernel.org

On Monday 13 September 2010 20:11:55 Yedidia Klein wrote:
> ok, found that wmi is compiled into my kernel and not built as module.
> while the grep for PNP0C32 returned nothing - so I assume that it;s
> not that.
> 
> is there any way to read these addresses directly via C and not via
> ACPI ?
If the button is ACPI driven you have to look at ACPI code sooner or 
later.
Have you tried showkey yet?

Try:
sleep 1;showkey
and
sleep 1;showkey -s
(the sleep is only that you can escape with CTRL-c).
If you get output if you hit the keys, then forget about ACPI and all
I said. There is a lot documentation about this out there.
Best you learn about:
/etc/X11/Xmodmap
the input layer, xev is a nice tool for these, etc.

If you don't see something with showkey, it's likely that it's ACPI 
driven.
Do:
rmmod battery
rmmod thermal
to avoid other ACPI interrupts
Then:
watch -n1 cat /proc/interrupts
Press the buttons, is the ACPI irq (normally 9) increasing when you
hit any of these?
If yes, it's likely ACPI driven.

Next step would to find out which GPE is fired on each press:
VALID="";for x in /sys/firmware/acpi/interrupts/gpe*;do if cat $x|grep 
enabled;then VALID="$VALID $x";fi;done;watch -n1 cat $VALID

modprobe battery
modprobe thermal
afterwards...

          Thomas
