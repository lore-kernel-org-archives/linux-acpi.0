From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: broken s2disk for ThinkPad T420 in current kernels
Date: Tue, 29 Oct 2013 17:41:33 +0100
Message-ID: <526FE53D.4040001@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:63462 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904Ab3J2Qlf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Oct 2013 12:41:35 -0400
Received: from [85.177.119.89] ([85.177.119.89]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lm6IP-1W9z0p1TTF-00Zh06 for
 <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2013 17:41:34 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Since 3.10 (at least) I cannot longer trust that a ThinkPad T420 with a
stable 32 bit Gentoo Linux wakeups fine from s2disk (using an external
USB 2.0 drive).

Currently it looks to me that I must not plug off the power cable durin=
g
s2disk. Otherwise a wakeup later just shows the X11 screen like it was
frozen during s2disk, but no cursor is blinking nor any keyboard is
accepted except sys-rq, those keys works.

I'm wondering if plug off the power cable could have such an effect or
if this is just mind crap of me.

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
