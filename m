From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [PATCH] hp-wmi: improve rfkill support
Date: Thu, 23 Jul 2009 17:31:45 +0200
Message-ID: <8db1092f0907230831w1255d0bey951342fb61b67c1e@mail.gmail.com>
References: <4A65A2F9.1060509@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:54938 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbZGWPbq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jul 2009 11:31:46 -0400
In-Reply-To: <4A65A2F9.1060509@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

2009/7/21 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:
> 1) Add support for reading the hardware blocked state. =C2=A0Previous=
ly
> =C2=A0 we read a combination of the hardware and software blocked sta=
tes,
> =C2=A0 reporting it as the software blocked state. =C2=A0This caused =
some
> =C2=A0 confusing behaviour.
>
> 2) The software state is persistent, mark it as such.
>
> 3) Check rfkill in the resume handler. =C2=A0Both the hard and soft
> =C2=A0 blocked states may change over hibernation.
>
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Tested-by: Maciej Rutecki <maciej.rutecki@gmail.com>

It's this patch is added to -rc4? I one case I have strange behaviour.

Before disable by button:
root@gumis:/home/maciek/Desktop# rfkill list
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
16: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
17: phy7: Wireless LAN
        Soft blocked: no
        Hard blocked: no
=09
Disable by button:
root@gumis:/home/maciek/Desktop# rfkill list
2: hp-wifi: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: yes
        Hard blocked: no
17: phy7: Wireless LAN
        Soft blocked: no
        Hard blocked: yes
=09
I do s2disk. After resume from suspend to disk (still disabled by butto=
n):
root@gumis:/home/maciek/Desktop# rfkill list
2: hp-wifi: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: yes
        Hard blocked: no
18: phy8: Wireless LAN
        Soft blocked: no
        Hard blocked: yes
=09
Try enable by button:
root@gumis:/home/maciek/Desktop# rfkill list
2: hp-wifi: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: yes
        Hard blocked: no
18: phy8: Wireless LAN
        Soft blocked: no
        Hard blocked: yes
=09
Nothing change (LED, wireless and bluetooth don't work). To enable it
I use this script rfkill.sh (I must use rfkill program):

#!/bin/sh
PROGRAM=3D/usr/local/sbin/rfkill
WIFI=3D`$PROGRAM list | grep -E 'Wireless|Bluetooth' | cut -d  ':' -f 1=
`

for DEVICE in $WIFI; do
  echo $DEVICE
  $PROGRAM unblock $DEVICE
done

Then works OK:
root@gumis:/home/maciek/Desktop# ./rfkill.sh
2
3
18
root@gumis:/home/maciek/Desktop# rfkill list
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
18: phy8: Wireless LAN
        Soft blocked: no
        Hard blocked: no
19: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
=09
It's normal behaviour?

--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
