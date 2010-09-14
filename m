From: Yedidia Klein <yedidia@atarplpl.co.il>
Subject: Re : getting new hardware (arbor M1526) buttons to work w/ acpi
Date: Tue, 14 Sep 2010 09:22:39 +0200
Message-ID: <AANLkTikFWEkh7o+tPOnzr_1x_g7yC1NemxVvzS1yfzrt@mail.gmail.com>
References: <AANLkTinTLAhRL48sP=B86RMEahx2dg_aczuwS+vn78js@mail.gmail.com>
 <201009131657.48686.trenn@suse.de> <AANLkTinLh6_q3n8WQJ1DWrhepqXdCeNosRZh9ByY8qVh@mail.gmail.com>
 <201009132137.44002.trenn@suse.de> <AANLkTik3oruQeYbTJgDXM6-X24X8X+fijJm0_P0_YYeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47087 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab0INHXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Sep 2010 03:23:00 -0400
Received: by vws3 with SMTP id 3so5583059vws.19
        for <linux-acpi@vger.kernel.org>; Tue, 14 Sep 2010 00:22:59 -0700 (PDT)
In-Reply-To: <AANLkTik3oruQeYbTJgDXM6-X24X8X+fijJm0_P0_YYeg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

nothing shows, nothing changes.. not showkey/xev output
and not any change on ACPI interrupts or /proc

seems that these buttons do not exist....

any idea - what can be done=C2=A0 ?

tnx,

--Y


2010/9/13 Thomas Renninger <trenn@suse.de>
>
> On Monday 13 September 2010 20:11:55 Yedidia Klein wrote:
> > ok, found that wmi is compiled into my kernel and not built as modu=
le.
> > while the grep for PNP0C32 returned nothing - so I assume that it;s
> > not that.
> >
> > is there any way to read these addresses directly via C and not via
> > ACPI ?
> If the button is ACPI driven you have to look at ACPI code sooner or
> later.
> Have you tried showkey yet?
>
> Try:
> sleep 1;showkey
> and
> sleep 1;showkey -s
> (the sleep is only that you can escape with CTRL-c).
> If you get output if you hit the keys, then forget about ACPI and all
> I said. There is a lot documentation about this out there.
> Best you learn about:
> /etc/X11/Xmodmap
> the input layer, xev is a nice tool for these, etc.
>
> If you don't see something with showkey, it's likely that it's ACPI
> driven.
> Do:
> rmmod battery
> rmmod thermal
> to avoid other ACPI interrupts
> Then:
> watch -n1 cat /proc/interrupts
> Press the buttons, is the ACPI irq (normally 9) increasing when you
> hit any of these?
> If yes, it's likely ACPI driven.
>
> Next step would to find out which GPE is fired on each press:
> VALID=3D"";for x in /sys/firmware/acpi/interrupts/gpe*;do if cat $x|g=
rep
> enabled;then VALID=3D"$VALID $x";fi;done;watch -n1 cat $VALID
>
> modprobe battery
> modprobe thermal
> afterwards...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
