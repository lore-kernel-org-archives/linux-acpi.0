From: Magyar =?ISO-8859-1?Q?B=E1lint?= <magyarbalint@indi.hu>
Subject: Clevo M541N and acpi_apic_instance=2
Date: Sat, 20 Mar 2010 13:46:08 +0100
Message-ID: <1269089168.6157.4.camel@amphetamine>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from a.relay.invitel.net ([62.77.203.3]:36813 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0CTM5T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Mar 2010 08:57:19 -0400
Received: from mailgw1.invitel.net (mailgw1.invitel.net [91.82.208.34])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id 1F21411A29A
	for <linux-acpi@vger.kernel.org>; Sat, 20 Mar 2010 13:46:10 +0100 (CET)
Received: from [192.168.0.134] ([91.83.156.240])
 by mail.invitel.hu (Invitel Messaging Server)
 with ESMTPA id <0KZK00I45ZGXQ5E0@invitel.hu> for linux-acpi@vger.kernel.org;
 Sat, 20 Mar 2010 13:46:09 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Greetings!

I found a message in my dmesg that said to notify this address if I fin=
d
the kernel option acpi_apic_instance=3D2 to work better than the defaul=
t
setting. On this Clevo M541N laptop, the difference is apparent because
without that option, I can only suspend once. On the second attempt it
will make some noises with the optical drive, but it doesn't turn the
display off after fading to black, or park the HDD's head. The kernel i=
s
then unresponsive to Magic SysRq keys as well and only the power switch
helps. With the option set to "2" I found that I can suspend and resume
as many times as I want.

This is on Ubuntu 10.04 beta1, kernel version 2.6.32.16.17 on i386.

I can provide more information to you if you need.

--=20
B=C3=A1lint Magyar

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
