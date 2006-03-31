From: Klaus-Martin Scheuer <k-mscheuer@visio-net.de>
Subject: Hotkeys do not work after Suspend-to-RAM (Kernel 2.6.16 + Samsung P35)
Date: Fri, 31 Mar 2006 09:24:58 +0200
Message-ID: <200603310924.58970.k-mscheuer@visio-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3555697.xOOUuzUO8z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ad96e004e.dsl.de.colt.net ([217.110.0.78]:36564 "EHLO
	hostingserver.dmz.labffm.de") by vger.kernel.org with ESMTP
	id S1751242AbWCaHZA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Mar 2006 02:25:00 -0500
Received: from bart (p54A8C49F.dip0.t-ipconnect.de [84.168.196.159])
	by hostingserver.dmz.labffm.de (Postfix) with ESMTP id 98E544850B
	for <linux-acpi@vger.kernel.org>; Fri, 31 Mar 2006 09:24:59 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart3555697.xOOUuzUO8z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I just upgraded my notebook to the kernel version 2.6.16 and encountered th=
at=20
after a suspend-to-ram cycle (suspend-to-disk makes no problems) the hotkey=
s=20
did not work. I tried to rmmod asus_acpi before suspending and modprobe it=
=20
after resuming with no success. Then I tried to rmmod and modprobe it only=
=20
after resuming. Again no sccess.
I can state that there are no hotkey events in /var/log/messages after=20
resuming, it works before suspending.

Almost the same configuration worked with kernel 2.6.14.

Any suggestions?

Regards
Klaus-Martin Scheuer

--nextPart3555697.xOOUuzUO8z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBELNlKCmkDofDxVpkRAuqAAJ9MGVgTtbUMQyHSaVGa/ArWcE25IACggKYY
opZgZHXGQt9SyeXczZQ55bY=
=NUyz
-----END PGP SIGNATURE-----

--nextPart3555697.xOOUuzUO8z--
