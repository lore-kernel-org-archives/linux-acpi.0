From: Gandalf Kristensen <gandkri@yahoo.no>
Subject: Buggy BIOS on the HP TX2500-series
Date: Wed, 8 Oct 2008 19:39:46 +0200 (CEST)
Message-ID: <331496.52627.qm@web23007.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web23007.mail.ird.yahoo.com ([217.146.189.32]:40861 "HELO
	web23007.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754416AbYJHRq1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 13:46:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Hi.

The HP tx2500-series has a funny "feature" of
trip-point set to -273C.=20
(I.e. see:
http://ubuntu-virginia.ubuntuforums.org/showpost.php?p=3D5660089&postco=
unt=3D187
)

In the latest kernel I noticed that we (the
tx2500-users) are not the only ones struggling with
this feature. (Wee! Thank you HP!)

So now I would like to find out of what I can do to
help get some patch in to the kernel for this BIOS?

Any help is very much appriciated.


--Gandalf A. Kristensen


      _________________________________________________________
Alt i ett. F=E5 Yahoo! Mail med adressekartotek, kalender og
notisblokk. http://no.mail.yahoo.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
