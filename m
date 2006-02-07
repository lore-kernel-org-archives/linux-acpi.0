From: Sascha Kloss <sascha.kloss@gmx.de>
Subject: No C3 on Pentium M (Dothan)
Date: Tue, 07 Feb 2006 11:44:34 +0000
Message-ID: <43E88822.1070605@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040503090006090205050304"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.21]:14238 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751013AbWBGR2T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2006 12:28:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040503090006090205050304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello acpi-folks,

I have some problem with my new FSC Amilo M6453G equipped with an
Pentium M Dothan 1.6GHz.

As the subject already says, my processor only seems to offer the
C-States one and two.

Kernel log says:
ACPI: CPU0 (power states: C1[C1] C2[C2])

Then I found your Wiki on using the C3 sleep state and looked for
busmastering support. Strangely, my cpu seems not to support it :(

# cat /proc/acpi/processor/CPU1/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        yes
throttling control:      yes
limit interface:         yes

So how could this be? I don't think there pentium m's out there with no
C3 support. Could a errorous DSDT cause wrong reporting of available
C-States?

I've also noticed that my notebook's cpu is warmer when idling in linux
than in windows - could the C3-state cause this?

Thanks in advance to anyone replying.
... and sorry for my bad english ;)

Kind regards
 Sascha Kloﬂ

Kernel: 2.6.15-gentoo-r1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD6IgiSaINjT6N32YRArfpAJ9mhaHjmsQK9WN18VPI9G7hPScJIACfaxnh
/GBojP/6boY36DeM75qKb0U=
=NZ8U
-----END PGP SIGNATURE-----

--------------040503090006090205050304
Content-Type: text/x-vcard; charset=utf-8;
 name="sascha.kloss.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sascha.kloss.vcf"

begin:vcard
fn;quoted-printable:Sascha Klo=C3=9F
n;quoted-printable:Klo=C3=9F;Sascha
email;internet:sascha.kloss@gmx.de
tel;cell:0174 4311303
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------040503090006090205050304--
