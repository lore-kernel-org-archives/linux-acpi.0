From: =?ISO-8859-1?Q?Fran=E7ois?= Boisson
	<user.anti-spam@maison.homelinux.net>
Subject: Re: shutdown with toshiba portege
Date: Wed, 21 Nov 2012 17:52:05 +0100
Message-ID: <20121121175205.e26259e8bd566ab01da344c4@maison.homelinux.net>
References: <20120920204234.0fb035a89f88a2e1f468aa54@maison.homelinux.net>
	<20120921165753.7a5701fc6a0e1445daa92500@maison.homelinux.net>
	<20120928132354.GG28937@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fbsmtp.dnsalias.org ([82.66.248.156]:34747 "EHLO
	fbsmtp.dnsalias.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab2KUQwP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Nov 2012 11:52:15 -0500
In-Reply-To: <20120928132354.GG28937@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>

> Le Fri, 28 Sep 2012 16:23:55 +0300
> Dan Carpenter <dan.carpenter@oracle.com> a =E9crit:
>=20
> >=20
> > So your Toshiba is going into suspend instead of power off...
> >=20
> > There are several ways that computers shutdown but modern systems
> > use ACPI.  It could be that the 2.6.37-486-PAE was using a
> > different method.  I've CC'd the ACPI list.
> >=20
>=20
> Thinks, first I have open a bug=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D47811
> the I have compiled a 3.5.4 with some printk around the halt/poweroff=
=2E (FIles
> arch/x86/kernel/reboot.c
> arch/x86/kernel/apm32.c ) trying to trace call BIOS but nothing print=
k,
> either I do not understand the power off mechanism, or the computer i=
s in a
> state where printk do not appear on screen.
> In fact I don't know what I can do to find an issue to this bug.
>=20
> Thanks for your answer

Just to say that the cause of battery to drain is making

hwclock --systohc=20

just before halt computer. Add=20
HWCLOCKACCESS=3Dno
or remove calls to hwclock --systohc
in /etc/init.d/=ABscripts=BB in =ABstop=BB part removes the bug.

So I think it's not a bug of ACPI but a bug of the RTC standard in the =
kernel
(file arch/x86/kernel/rtc.c). I tried to add a =ABsleep 1=BB just after=
 the
hwclock call but no change.

This is a workaround but not the real solution of this problem.
Thanks for reading.
=46ran=E7ois Boisson
(Please Cc to me, I'm not on linux-acpi list)

=46ran=E7ois Boisson
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
