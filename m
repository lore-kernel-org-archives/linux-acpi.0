From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Mon, 31 Jan 2011 10:50:49 +0100
Message-ID: <201101311050.49722.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101302348.40509.rjw@sisk.pl> <4D467882.9060304@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51340 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755301Ab1AaJvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jan 2011 04:51:14 -0500
In-Reply-To: <4D467882.9060304@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com

On Monday, January 31, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> On 31.01.2011 00:48, Rafael J. Wysocki wrote:
>=20
> > Does booting with "nolapic" help on all of the affected systems?
> >
> > Also, does disabling the CPUidle during boot help?
> >
> > Finally, is the problem reproducible with CONFIG_NO_HZ unset?
>=20
> Well on two machines, nolapic cures the boot hang and on one machine =
it=20
> cures the random shutdown hangs.
>=20
> I'll compile a kernel with CONFIG_NO_HZ to see what happens but how d=
o I=20
> disable cpuidle during boot? I've checked the kernel-parameters.txt b=
ut=20
> there's no cpuidle related boot parameter there.

Booting with intel_idle.max_cstate=3D0 should do the trick.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
