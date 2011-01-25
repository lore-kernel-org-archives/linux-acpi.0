From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Tue, 25 Jan 2011 20:38:24 +0100
Message-ID: <201101252038.25113.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <4D3DDDA4.2080202@yahoo.fr> <201101250822.48287.ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38422 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab1AYTjN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jan 2011 14:39:13 -0500
In-Reply-To: <201101250822.48287.ozan@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com

On Tuesday, January 25, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> Pazartesi 24 Ocak 2011 g=C3=BCn=C3=BC (saat 22:14:28) Lionel Debroux =
=C5=9Funlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1:
> > On 24.01.2011 10:47, Lionel Debroux wrote:
>=20
> > None of nolapic, acpi=3Doff, nolapic acpi=3Doff enables 2.6.35.8 to=
 boot
> > on my ASUS F3Jv-AS022P.
> > The kernel line is
> > kernel /boot/vmlinuz root=3D/dev/sda9 nomce vga=3D791 nomodeset
> > I've attached the 2.6.35.6 config.
>=20
> Yes one of my reporters also tells that on 2.6.35 the problem can't b=
e cured with nolapic
> but on 2.6.37 it helps.

Does
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3Dec30f343d61391ab23705e50a525da1d55395780
generally help?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
