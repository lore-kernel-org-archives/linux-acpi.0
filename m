From: Sam Varshavchik <mrsam@courier-mta.com>
Subject: ACPI keys for backlight control
Date: Sun, 06 Jan 2008 11:51:09 -0500
Message-ID: <cone.1199638269.263939.13495.500@commodore.email-scan.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-commodore.email-scan.com-13495-1199638269-0002";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.courier-mta.com ([216.254.115.190]:33845 "EHLO
	www.courier-mta.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbYAFQ4M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jan 2008 11:56:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-commodore.email-scan.com-13495-1199638269-0002
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Does anyone know anything about ACPI key-based laptop backlight control?

My "white-box" laptop is apparently based on an Asus mainboard. dmidecode 
says:

Handle 0x0001, DMI type 1, 25 bytes.
System Information
        Manufacturer: ASUSTeK Computer Inc.        
        Product Name: M7V       
        Version: 1.0       
        Serial Number: SSN12345678901234567
        UUID: 28CE5D8A-0000-0080-385D-0017312C16F2
        Wake-up Type: Power Switch

Love that serial number.

Anyway, this hardware apparently has an ambient light sensor, and three ACPI 
keys. In Win XP, the first key controls the backlight automatic/manual mode. 
In automatic mode, the ambient light sensor gradually reduces the backlight, 
based on the room light level, in small incremental steps, from about 100% 
brightness to about 30%. In manual mode, the sensor itself is disabled and 
the other two ACPI keys incrementally step up or step down the backlight 
power. Win XP responds to the ACPI keys with small popup indicators.

GRUB's menu comes up with the light sensor in manual mode. As soon as the 
kernel boots, it goes to automatic, and there is no further response to any 
of these three ACPI keys. Booting with "noacpi" keeps the light sensor in 
manual mode.

In neither case can I, apparently, switch between manual and automatic mode 
with the ACPI keys. Except for this, I have ACPI working fine. I have other 
ACPI keys that enable/disable the external VGA port, and they work as 
advertised.

My normal light level appears to be right at the upper sensor range, and the 
nearly-subliminal back-and-forth backlight light level adjustment becomes 
irritating rather quickly. But there's no response to these three ACPI keys, 
nothing in syslog, and the backlight settings in Gnome's power management do 
nothing.

There's nothing else in dmidecode's output, or lspci's output, that refers 
to the sensor.


--=_mimegpg-commodore.email-scan.com-13495-1199638269-0002
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD4DBQBHgQb9x9p3GYHlUOIRAuXJAJ9O0+osJj1FNsZNGzOz+6V6idNApQCYlXS8
NfqSj/ApbhIVwuItTCPIUw==
=fygP
-----END PGP SIGNATURE-----

--=_mimegpg-commodore.email-scan.com-13495-1199638269-0002--
