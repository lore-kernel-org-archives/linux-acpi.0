From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [RFT] hp-wmi: improved rfkill support for wifi
Date: Sun, 19 Jul 2009 10:15:32 +0200
Message-ID: <8db1092f0907190115l6c55df77o47ae40c20b04c2a6@mail.gmail.com>
References: <4A61FE7D.9080409@tuffmail.co.uk>
	 <8db1092f0907181155h3d603a17q11815b9f174ac333@mail.gmail.com>
	 <4A623490.50305@tuffmail.co.uk>
	 <71cd59b00907181437l6ef362ejc345818a5197a6c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:61061 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbZGSIPe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Jul 2009 04:15:34 -0400
In-Reply-To: <71cd59b00907181437l6ef362ejc345818a5197a6c4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Garrett <mjg@redhat.com>, Frans Pop <elendil@planet.nl>, Larry Finger <Larry.Finger@lwfinger.net>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

2009/7/18 Corentin Chary <corentin.chary@gmail.com>:
>> Linux can also do enabling "by software". =C2=A0At the moment, you n=
eed to
>> download and compile a utility to poke /dev/rfkill. =C2=A0I wouldn't=
 bother
>> testing it, because I didn't change that bit :-).
>
> Utility is here
> http://git.sipsolutions.net/?p=3Drfkill.git
> And a patch to restore write access to /sys/class/rfkill/*/state file=
 is here
> http://lkml.org/lkml/2009/7/10/339

Great tool.

Block bluetooth:
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill block 3
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: yes
        Hard blocked: no

root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill unblock 3
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
5: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no

Block wireless:
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill block 0
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
0: phy0: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
5: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill unblock 0
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
5: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
=09
Works very nice on my laptop

Thanks!
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
