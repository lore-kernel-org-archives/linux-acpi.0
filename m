From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [PATCH] hp-wmi: improve rfkill support
Date: Thu, 23 Jul 2009 21:36:14 +0200
Message-ID: <8db1092f0907231236x54972749p9f535f696c9b008f@mail.gmail.com>
References: <4A65A2F9.1060509@tuffmail.co.uk>
	 <8db1092f0907230831w1255d0bey951342fb61b67c1e@mail.gmail.com>
	 <4A68AB8F.9020609@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:37283 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbZGWTgS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jul 2009 15:36:18 -0400
In-Reply-To: <4A68AB8F.9020609@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

2009/7/23 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:

>
> That's a bug. =C2=A0You're saying this is in -rc4, without applying m=
y patch?

Yes

>
> I think I know exactly what is happening. =C2=A0Apply my patch, and i=
t will go
> away :-).

Yes. I add Your patch to -rc4 and rfkill works OK:
Enable by button:
root@gumis:/home/maciek# rfkill list
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no

Disable by button:
root@gumis:/home/maciek# rfkill list
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: yes
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no

After resume from s2disk:
root@gumis:/home/maciek# rfkill list
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
4: phy1: Wireless LAN
        Soft blocked: no
        Hard blocked: yes

(are some differences after and before s2disk)

Enable by button:
root@gumis:/home/maciek# rfkill list
2: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hp-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
4: phy1: Wireless LAN
        Soft blocked: no
        Hard blocked: no
5: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no

And wifi/bluetooth works without manual enable. Thanks.

>
> I'm not sure this is a new bug though. =C2=A0It might be triggered by=
 the big
> rfkill rewrite, but I don't see how that could happen. =C2=A0Can you =
confirm if
> this happens in 2.6.30?

2.6.30 works OK

>
> Thanks
> Alan
>


Regards
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
