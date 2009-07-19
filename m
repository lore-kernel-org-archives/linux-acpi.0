From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [RFT] hp-wmi: improved rfkill support for wifi
Date: Sun, 19 Jul 2009 21:08:29 +0200
Message-ID: <8db1092f0907191208i6fcdf519r8204be542e95bbe4@mail.gmail.com>
References: <4A61FE7D.9080409@tuffmail.co.uk>
	 <8db1092f0907181155h3d603a17q11815b9f174ac333@mail.gmail.com>
	 <4A623490.50305@tuffmail.co.uk>
	 <8db1092f0907190028o334371d7g798c1e8cb9a5744b@mail.gmail.com>
	 <4A635618.3070507@tuffmail.co.uk>
	 <8db1092f0907191110p2d3c2c45je61bda6365ed1468@mail.gmail.com>
	 <4A6364DF.3040303@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:51850 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZGSTIb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Jul 2009 15:08:31 -0400
In-Reply-To: <4A6364DF.3040303@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>, Frans Pop <elendil@planet.nl>, Larry Finger <Larry.Finger@lwfinger.net>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

2009/7/19 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:

>
> Sorry, that was a dumb copy+paste error. =C2=A0Here's a fixed version=
=2E
>

No errors during boot, but still bluetooth is disabled:
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
0: phy0: Wireless LAN
        Soft blocked: yes
        Hard blocked: yes
1: hp-wifi: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill unblock 0
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: yes
1: hp-wifi: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill unblock 1
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: hp-wifi: Wireless LAN
        Soft blocked: no
        Hard blocked: no

In /sys/class/rfkill I see only 2 "rfkill?" directory (compare to my
first e-mail):

root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ls /sys/class/rfkill/
rfkill0  rfkill1
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# cat
/sys/class/rfkill/rfkill0/state
1
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# cat
/sys/class/rfkill/rfkill1/state
1
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# /etc/init.d/bluetooth
force-reload
Restarting bluetooth: hcid.
root@gumis:/home/maciek/zrodelka/rfkill/rfkill# hciconfig -a hci0
Can't get device info: No such device

Wireless works OK.

Regards
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
