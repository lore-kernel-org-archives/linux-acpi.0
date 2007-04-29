From: Marvin Stark <marv@der-marv.de>
Subject: 2.6.21.1 problems during suspend-to-ram
Date: Sun, 29 Apr 2007 23:48:29 +0200
Message-ID: <200704292348.33869.marv@der-marv.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1750906.fMQ1lzPP3B";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 139-66-107-89.rdns.global-control.de ([89.107.66.139]:44425
	"EHLO mail.der-marv.de" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1161486AbXD2WSL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Apr 2007 18:18:11 -0400
Received: from localhost (mail.der-marv.de [89.107.66.139])
	by mail.der-marv.de (Postfix) with ESMTP id D2B515C0BD
	for <linux-acpi@vger.kernel.org>; Sun, 29 Apr 2007 21:50:04 +0000 (UTC)
Received: from mail.der-marv.de ([89.107.66.139])
	by localhost (mail.der-marv.de [89.107.66.139]) (amavisd-new, port 10024)
	with ESMTP id xL17OMEHG03d for <linux-acpi@vger.kernel.org>;
	Sun, 29 Apr 2007 21:50:03 +0000 (UTC)
Received: from [192.168.23.5] (p54BBCC2C.dip.t-dialin.net [84.187.204.44])
	by mail.der-marv.de (Postfix) with ESMTP id B449A5C0BC
	for <linux-acpi@vger.kernel.org>; Sun, 29 Apr 2007 21:49:53 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart1750906.fMQ1lzPP3B
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm trying to suspend my MacBook2,1 to ram and always get following error=20
during suspend:

ACPI: PCI interrupt for device 0000:00.1f.2 disabled.

I'm suspending the maschine with sysfs (echo mem > /sys/power/state).
Did I forget to set a option?

Here are some additional informations:

http://stuff.der-marv.de/macbook/vger/config.gz
http://stuff.der-marv.de/macbook/vger/dmesg
http://stuff.der-marv.de/macbook/vger/lsmod
http://stuff.der-marv.de/macbook/vger/lspci

Thanks and Regards,
=2D-=20
 .""`.     Marvin Stark <marv@der-marv.de>
: :"  :    Homepage: www.der-marv.de
`. `"`
  `-  Debian - when you have better things to do than fix a system

--nextPart1750906.fMQ1lzPP3B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBGNRKxQV+FW6osnHMRAkDUAJdL57tL/xqVXQc91BqZaPRMdL4OAJ9hr00m
2A1OMFTx09ymqCdWv47DIw==
=Q956
-----END PGP SIGNATURE-----

--nextPart1750906.fMQ1lzPP3B--
