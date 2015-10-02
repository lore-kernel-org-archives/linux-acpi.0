From: =?iso-8859-1?Q?Niccol=F2_Belli?= <niccolo.belli@linuxsystems.it>
Subject: [Dell XPS 13 9343] Random kernel Oops at boot with =?iso-8859-1?Q?"acpi=3Dht",_disappearing_with_"acpi=3Doff"?=
Date: Fri, 02 Oct 2015 11:59:38 +0200
Message-ID: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxsystems.it ([2.119.245.41]:58964 "EHLO
	mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbJBKI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2015 06:08:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Hi,
This laptop suffers of random kernel hangs at boot: I tested kernel 4.1=
=2E8,=20
4.2.1 and 4.3-rc3 and they are all affected.
Every time I turn on my laptop I have to boot several times to be able =
to=20
reach the sddm login because often I get hangs which prevent the system=
 to=20
boot. Once booted I don't have any problem anymore, until the next boot=
=2E

With "acpi=3Doff" the system boots flawlessly, while with "acpi=3Dht" I=
 still=20
get random hangs, so I guess the problem is in the ACPI table parsing c=
ode=20
itself, or perhaps the SMP code.

I recompiled kernel 4.3-rc3 with CONFIG_ACPI_DEBUG=3Dy and I attached f=
ull=20
log from a serial console, booting with "debug acpi.debug_level=3D0x200=
3"=20
(warn, error and tables debug enabled):=20
https://bugzilla.kernel.org/attachment.cgi?id=3D189041

Distro is Arch Linux. Please let me know if you need further logs.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D105251

Niccol=C3=B2 Belli
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
