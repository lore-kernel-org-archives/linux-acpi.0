From: =?windows-1250?q?Old=F8ich_Jedli=E8ka?= <oldium.pro@seznam.cz>
Subject: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Thu, 10 Mar 2011 19:37:01 +0100
Message-ID: <201103101937.01864.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49605 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab1CJSjP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2011 13:39:15 -0500
Received: by fxm17 with SMTP id 17so243334fxm.19
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2011 10:39:14 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>

Hi all,

This is about Acer WMI driver and bluetooth support. I hope I'm at the =
right=20
place with my question :-)

I tried to use bluetooth again on my Acer TravelMate 5730G and discover=
ed a=20
usability problem. I've checked 2.6.38-rc7:

0. On startup, the bluetooth LED is off, acer-bluetooth SW rfkill is bl=
ocked.
1. I have to enable the HW bluetooth switch to get the bluetooth LED ru=
nning=20
(USB device appears in lsusb). The acer-bluetooth SW rfkill is unblocke=
d, the=20
SW rfkill of hci0 is blocked.
2. Next I have to unblock SW rfkill on hci0 by a call to `rfkill unbloc=
k=20
<number of hci0>`.
3. Last I have to enable the HCI by the call to `hciconfig hci0 up`.

How is this supposed to work? I tried to use "rfkill.default_state=3D1"=
 on=20
kernel command line, but without any success.

When I boot into 2.6.37, the bluetooth LED goes ON automatically and hc=
iconfig=20
shows the hci0 as UP.

Thanks.

Best regards,
Old=F8ich.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
