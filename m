From: =?ISO-8859-1?Q?Fran=E7ois?= Boisson
	<user.anti-spam@maison.homelinux.net>
Subject: Re: shutdown with toshiba portege
Date: Fri, 28 Sep 2012 23:14:58 +0200
Message-ID: <20120928231458.40a6f95eeac645d713647776@maison.homelinux.net>
References: <20120920204234.0fb035a89f88a2e1f468aa54@maison.homelinux.net>
	<20120921165753.7a5701fc6a0e1445daa92500@maison.homelinux.net>
	<20120928132354.GG28937@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fbsmtp.dnsalias.org ([82.66.248.156]:36625 "EHLO
	fbsmtp.dnsalias.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031786Ab2I1ViZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Sep 2012 17:38:25 -0400
In-Reply-To: <20120928132354.GG28937@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>

Le Fri, 28 Sep 2012 16:23:55 +0300
Dan Carpenter <dan.carpenter@oracle.com> a =E9crit:

>=20
> So your Toshiba is going into suspend instead of power off...
>=20
> There are several ways that computers shutdown but modern systems
> use ACPI.  It could be that the 2.6.37-486-PAE was using a
> different method.  I've CC'd the ACPI list.
>=20

Thinks, first I have open a bug=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D47811
the I have compiled a 3.5.4 with some printk around the halt/poweroff. =
(FIles
arch/x86/kernel/reboot.c
arch/x86/kernel/apm32.c ) trying to trace call BIOS but nothing printk,=
 either
I do not understand the power off mechanism, or the computer is in a st=
ate
where printk do not appear on screen.
In fact I don't know what I can do to find an issue to this bug.

Thanks for your answer

=46ran=E7ois Boisson
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
