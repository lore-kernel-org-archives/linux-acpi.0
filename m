From: Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Backlight not working after resume
Date: Sun, 01 Nov 2009 11:05:30 -1000
Message-ID: <4AEDF81A.8070508@sysnux.pf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtps0.mana.pf ([202.3.225.97]:34550 "EHLO smtps0.mana.pf"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447AbZKAVMb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Nov 2009 16:12:31 -0500
Received: from smtps0.mana.pf (localhost [127.0.0.1])
	by smtps0.mana.pf (Postfix) with ESMTP id 70232C7617
	for <linux-acpi@vger.kernel.org>; Sun,  1 Nov 2009 11:05:31 -1000 (TAHT)
Received: from tiare.sysnux.pf (196.244.3.202.dial.dyn.mana.pf [202.3.244.196])
	by smtps0.mana.pf (Postfix) with ESMTP id 38735C62EA
	for <linux-acpi@vger.kernel.org>; Sun,  1 Nov 2009 11:05:31 -1000 (TAHT)
Received: from tiare.sysnux.pf (tiare.sysnux.pf [127.0.0.1])
	by tiare.sysnux.pf (Postfix) with ESMTP id 29DE12EF90
	for <linux-acpi@vger.kernel.org>; Sun,  1 Nov 2009 11:05:31 -1000 (TAHT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi list,

I have a Samsung q30 ultra-portable; ACPI video seems supported by
standard driver. After boot, backlight control works fine with the
dedicated laptop keys, but it no longer works after suspend / resume.
The laptop itself is still working: I can ssh, even X is working. I can
add an external screen and everything is OK, it's just the panel
backlight is off. I have tried several methods found on the Internet
(setpci, xrandr, sysfs) without luck.

I can do:
	echo x >/sys/class/backlight/acpi_video0/brightness
(x=3D0..7) to adjust brightness after boot. After resume, the command
works, but has no effect.

Video is:
~ Intel Corporation 82852/855GM Integrated Graphics Device

I'm using KMS since 2.6.31-rc something (it was not working before).
Before KMS, I used vbetool post to get my screen back on.

I filed a bug at freedesktop.org one month ago, there's more detail
there (acpidump, ...):
	http://bugs.freedesktop.org/show_bug.cgi?id=3D24201

Problem persists with kernel version is 2.6.32-rc5.

I can provide more info, and I'm willing to try corrections / patches t=
o
solve this problem.


Thanks,
- --
Jean-Denis Girard

SysNux                  Syst=C3=A8mes  Linux  en Polyn=C3=A9sie fran=C3=
=A7aise
http://www.sysnux.pf/   T=C3=A9l: +689 50 10 40 / GSM: +689 79 75 27
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAkrt+BoACgkQuu7Rv+oOo/hkdwCdEUD7/TE8ZLpvbrStTchliNus
Z2cAnRsDVUGZFKlqA2klZQDYOsb3NB2n
=3DfaAb
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
