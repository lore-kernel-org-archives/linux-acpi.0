From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: s2ram broken for a docked ThinkPad T400 since kernel 2.6.32-rcX
Date: Tue, 21 Dec 2010 17:45:19 +0100
Message-ID: <201012211745.19725.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:35328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750874Ab0LUQp1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Dec 2010 11:45:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Bjorn Helgaas <bjorn.helgaas@hp.com>

Hello,

the details are in https://bugzilla.kernel.org/show_bug.cgi?id=3D15100#=
c39=20

I'd like to point you to this via email b/c I'm unsure whether this but=
 report=20
is on your radar or not currently.

There's one important correction to the last paragraph in that comment.
I wasn't able to revert that commit on current kernel, only on kernel 2=
=2E6.33 I=20
could revert it and cerify that this version could waked up.

--=20
MfG/Kind regards
Toralf F=C3=B6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
