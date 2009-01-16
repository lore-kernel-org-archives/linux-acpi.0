From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Fan running continuously after kernel switch
Date: Fri, 16 Jan 2009 20:22:22 -0200
Message-ID: <20090116222222.GG5719@khazad-dum.debian.net>
References: <1232008941.24218.6.camel@pancake> <1232011776.3989.25.camel@yakui_zhao.sh.intel.com> <1232011930.24218.13.camel@pancake> <1232088736.4001.6.camel@yakui_zhao.sh.intel.com> <20090116212326.GE5719@khazad-dum.debian.net> <1232143471.15602.24.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38443 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933108AbZAPWW0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Jan 2009 17:22:26 -0500
Content-Disposition: inline
In-Reply-To: <1232143471.15602.24.camel@pancake>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 16 Jan 2009, Florian Echtler wrote:
> cat /proc/acpi/ibm/thermal=20
> temperatures:	43 37 35 45 50 -128 29 -128 37 46 43 -128 -128 -128 -12=
8
> -128

That 45 next to the 50, and the 46 and 43 near the end tail of -128 are
likely going to keep your fan on, yes.

That 50 is a probably a battery pack telling us something that we don't
know, but since the EC does, it doesn't matter (i.e. if it is to be ign=
ored,
the EC will know that and do just that).   I asked Lenovo, and they ref=
used
to explain it.

> However, there's obviously a bit more to this.

Yes.

> a) when I load the coretemp module and try to read the temperature vi=
a
> lm-sensors, I get two values around 60 =B0C, while thinkpad-acpi show=
s the
> above. Same applies to the standard ACPI thermal interface. I have a
> total of 13 different thermal measurements.. :-)

Heh.  The only ones you can somehow figure out without messing with the
hardware are coretemp (they're exactly what they should be), and the AC=
PI TZ
ones (read the AML disassembly dump).

All the others require that you open your thinkpad and make good use of=
 a
can of cold air to locate what sensor changes when you cool each part o=
f the
planar card.

> b) the really weird part: when I remove the power supply and let the
> laptop run on battery, the fan immediately stops! Some minutes later,=
 it

Yes, the EC (or BIOS, who knows.  Much of the thinkpad firmware is SMM =
code)
changes the fan/thermal control profile based on many things.  It also =
tells
ACPI to limit the CPU speed, and other honky things.

It all depends on how you configured your BIOS.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
