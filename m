From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [Acpi4asus-user] [patch 7/7] asus-laptop: add light =?iso-8859-1?q?sensor=09support?=
Date: Sat, 27 Jan 2007 09:46:18 +0100
Message-ID: <200701270946.19039.corentincj@iksaif.net>
References: <200701251254.59337.corentincj@iksaif.net> <200701261404.58597.corentincj@iksaif.net> <45BA865E.4040706@gmx.de>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50953 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbXA0IqV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Jan 2007 03:46:21 -0500
In-Reply-To: <45BA865E.4040706@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Engel <j-engel@gmx.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Le vendredi 26 janvier 2007 23:53, Johannes Engel a =E9crit=A0:
> Hi, Corentin!
>
> Some remarks on your patch which upto now works great for me!
>
> 1.) configuration seems to have a "circle": Warning! Found recursive
> dependency: ACPI_ASUS ASUS_LAPTOP ACPI_ASUS
Yep I know, I already fixed that in the new patch (posted as an answer =
of the=20
first).

> 2.) The dependency X86 makes it necessary to enable generic
> X86-optimizations. Is that intended?
Is that a problem ?

> 3.) With recent BIOS versions the implementation of the value for the
> Touchpad LED has switched. So an "echo 0 > .../led" results in the le=
d
> to light. Maybe there is a way to deal with that in kernel space. But=
 I
> think we already had that discussion some months ago.
I think we should make it work in most of the case, but it's not really=
 a=20
problem if the led doesn't work exactly as excepted ^^

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
