From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [RFT] hp-wmi: improved rfkill support for wifi
Date: Sat, 18 Jul 2009 20:55:02 +0200
Message-ID: <8db1092f0907181155h3d603a17q11815b9f174ac333@mail.gmail.com>
References: <4A61FE7D.9080409@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:38644 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZGRSzE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Jul 2009 14:55:04 -0400
In-Reply-To: <4A61FE7D.9080409@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>, Frans Pop <elendil@planet.nl>, Larry Finger <Larry.Finger@lwfinger.net>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

2009/7/18 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:
> I borrowed a HP G7000 last week. =C2=A0The hp-wmi driver seemed a bit
> confused about hard v.s. soft blocks on the wifi, so I fixed it based=
 on
> acpidump output [1]. =C2=A0I hope this will work on other HP model nu=
mbers,
> but it would benefit from testing. =C2=A0Any volunteers?

HP/Compaq nx6310
2.6.31-rc3+patch

When is enabled by button:
root@gumis:/sys/class/rfkill# ls
rfkill0  rfkill1  rfkill2  rfkill3
root@gumis:/sys/class/rfkill# cat rfkill*/name
phy0
hci0
hp-wifi
hp-bluetooth
root@gumis:/sys/class/rfkill# cat rfkill*/state
1
1
1
1

When disabled by button:
root@gumis:/sys/class/rfkill# ls
rfkill0  rfkill2  rfkill3
root@gumis:/sys/class/rfkill# cat rfkill*/name
phy0
hp-wifi
hp-bluetooth
root@gumis:/sys/class/rfkill# cat rfkill*/state
2
1
0

I enable again by button:
root@gumis:/sys/class/rfkill# ls
rfkill0  rfkill2  rfkill3  rfkill4
root@gumis:/sys/class/rfkill# cat rfkill*/name
phy0
hp-wifi
hp-bluetooth
hci0
root@gumis:/sys/class/rfkill# cat rfkill*/state
1
1
1
1

I disable "by software" in Windows XP (bluetooth and wireless):
root@gumis:/sys/class/rfkill# ls
rfkill0  rfkill1  rfkill2  rfkill3
root@gumis:/sys/class/rfkill# cat rfkill*/name
phy0
hp-wifi
hp-bluetooth
hci0
root@gumis:/sys/class/rfkill# cat rfkill*/state
2
0
1
1

Bluetooth works fine when I back to Linux, it seems be enabled during
boot. Wireless is disabled. I cannot connect to network. So I
re-enable it in Windows:
root@gumis:/sys/class/rfkill# ls
rfkill0  rfkill1  rfkill2  rfkill3
root@gumis:/sys/class/rfkill# cat rfkill*/name
phy0
hci0
hp-wifi
hp-bluetooth
root@gumis:/sys/class/rfkill# cat rfkill*/state
1
1
1
1

Regards
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
