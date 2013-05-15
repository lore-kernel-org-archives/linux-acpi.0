From: Phillip Susi <psusi@ubuntu.com>
Subject: Disable hibernate -- Live media shouldn't allow it?
Date: Wed, 15 May 2013 18:14:25 -0400
Message-ID: <519408C1.9030706@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:37558 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab3EOWO1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 May 2013 18:14:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When booting from removable media, you may end up mounting a swap
partition on an internal hard disk, thus enabling hibernation.
Inadvertently hibernating ( perhaps in response to ACPI HOT event ) is
silly since the system can not be resumed.  Is there a flag somewhere
to prevent hibernating?  Shouldn't there be and shouldn't it be
disabled by default?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJRlAjBAAoJEJrBOlT6nu75tD4IANMtQGPJfnwOrnwcL+pmxmRW
1Iq7EpwXtkxMbibcIiLIjtqfPXjupHQMQBxMoHvlZuISPv4lMChRqbM+wBEy5GfN
waGcSilqbHurx+L4xSUE9UmZ6iUOWEvZreQRniTlrFbAV+pClYq2D0Ub2msOo1Ka
Rg0zygVJSs0y6VrTZdUIbutiiGo24KFiJyTkErTnFr21QReIPd5Bq4zwVd+1I+UR
oZY0z49ot8c+m2BhBZ8V6+H0do+zpmcvjmik3b6Dm8sFfGiCnjQVHhmc4tHNZfhS
SnmW8dC+haR7kHAAFmIrd2RRbczD2H3XCM0/QvwVQ8ISz0h6Ejy1MTeNlW87XBA=
=5nIU
-----END PGP SIGNATURE-----
