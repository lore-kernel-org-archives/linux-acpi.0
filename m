From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: Regression in thinkpad-acpi events
Date: Mon, 14 Nov 2011 21:18:46 +0100
Message-ID: <201111142118.47256.maciej.rutecki@gmail.com>
References: <4EBAC3B5.5060405@gmail.com> <201111142031.06663.maciej.rutecki@gmail.com> <4EC16F8E.7060601@gmail.com>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37270 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab1KNUSx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2011 15:18:53 -0500
In-Reply-To: <4EC16F8E.7060601@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Natanji <natanji@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

(add more CCs)

On poniedzia=C5=82ek, 14 listopada 2011 o 20:44:14 Natanji wrote:
> With 3.0 it was still fine, that much is for sure. The problem came
> with the upgrade to 3.1. I've never even compiled my own kernel so I
> cannot bisect. Sorry...
>=20
> Regards,
> Natanji
>=20
> On Mon 14 Nov 2011 08:31:06 PM CET, Maciej Rutecki wrote:
> > On =C5=9Broda, 9 listopada 2011 o 19:17:25 Natanji wrote:
> >> Hello everyone,
> >> first time posting on this last, and I'm not subscribed, so please=
 CC
> >> any replies to me. ;)
> >>=20
> >> I'm running Kernel version 3.1-4 using Arch Linux (32 Bit) on a Th=
inkpad
> >> X60 Tablet. Since upgrading from a pre-3.1 kernel to a post-3.1 ke=
rnel,
> >> the Thinkpad-specific ACPI events (from thinkpad-acpi) are complet=
ely
> >> gone.
> >>=20
> >> This can be observed by using the acpi_listen command. For instanc=
e, no
> >> ACPI events happen when swiveling the display, and the sleep butto=
n
> >> returns
> >>=20
> >> 	button/sleep SBTN 00000080 00000000
> >>=20
> >> instead of the previous
> >>=20
> >> 	ibm/hotkey HKEY 00000080 00001004
> >>=20
> >> The bug was reported in the Arch Linux bugtracker [1] and it was
> >> suggested to report this upstream, so this is what I did now. Sadl=
y I
> >> have no idea how I could find out if this is indeed a kernel bug o=
r not;
> >> I have never compiled my own kernel so what I can give you is prob=
ably
> >> limited. But I suppose quite a few members of this list use a Thin=
kpad.
> >> If there is anything else I can help out with, just tell me.
> >>=20
> >> [1] https://bugs.archlinux.org/index.php?do=3Ddetails&task_id=3D26=
658
> >=20
> > Can you check that 3.1 works or not? Or try bisection that it is
> > regression after 3.0 or 3.1 kernel.
> >=20
> > Regards

--=20
Maciej Rutecki
http://www.mrutecki.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
