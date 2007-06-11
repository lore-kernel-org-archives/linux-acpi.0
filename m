From: Mircea Bardac <dev.list@mircea.bardac.net>
Subject: acpi/sensors temperature on nx6325
Date: Mon, 11 Jun 2007 13:10:23 +0300
Message-ID: <200706111310.25351.dev.list@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bravo.securenet-server.net ([207.210.84.244]:56670 "EHLO
	bravo.securenet-server.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758892AbXFKKNy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2007 06:13:54 -0400
Received: from [86.121.179.56] (helo=mircea.home.bardac.net)
	by bravo.securenet-server.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dev.list@mircea.bardac.net>)
	id 1HxgsP-00020M-La
	for linux-acpi@vger.kernel.org; Mon, 11 Jun 2007 06:11:57 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I'm currently running kernel 2.6.21.3 on a HP nx6325.

I like having in the taskbar information about cpu/mem/temperature/etc.=
 I=20
found a strange behaviour monitoring the ACPI provided temperature. It=20
currently shows for example 48C constantly, for lots of minutes.=20

Doing a: dd if=3D/dev/urandom of=3D/dev/null increases the CPU usage an=
d=20
temperature should increase too. The ACPI temperature stays the same th=
ough.

I have also loaded the lm_sensors modules which, after some monitoring,=
 appear=20
to be working right, meaning "it shows an increasing temperature if the=
 CPU=20
usage increases".

# cat /proc/acpi/thermal_zone/TZ1/temperature && sensors
temperature:             48 C
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +54=B0C
Core1 Temp:
             +53=B0C


The ACPI temperature increases only when the trip-point is reached. I h=
ear the=20
fans starting. When the fans stop, the temperature drops "hard" to the=20
previous value.

I've changed the polling frequency to 1:
# cat /proc/acpi/thermal_zone/TZ1/polling_frequency
polling frequency:       1 seconds

I got the same effect: I can't see the temperature change dynamically, =
degree=20
by degree. Also, in a test, the sensor went up to 60-65C and the trip-p=
oint=20
did't activate. This was with polling set to 1.

If you need any more information, let me know.


Regards,
Mircea
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
