From: Stelian Pop <stelian@popies.net>
Subject: Re: sony-laptop vs sonypi (Re: [PATCH 1/2] Add new sony laptop
	drivers maintainer)
Date: Sat, 10 Feb 2007 23:07:59 +0100
Message-ID: <1171145280.5026.23.camel@localhost.localdomain>
References: <11709622011964-git-send-email-malattia@linux.it>
	 <1171028098.6387.15.camel@localhost.localdomain>
	 <56393.85.47.20.193.1171029689.squirrel@picard.linux.it>
	 <200702091158.18909.lenb@kernel.org>
	 <20070209192513.GA4612@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:4930 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbXBJWID (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Feb 2007 17:08:03 -0500
In-Reply-To: <20070209192513.GA4612@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Le vendredi 09 f=E9vrier 2007 =E0 20:25 +0100, Mattia Dongili a =E9crit=
 :

> > Presumably there is some application that talks to those ioctls.
>=20
> Yep, sonypid spicctrl sjog sonykeyd just to name a few.

Don't forget also kde and hal...

[...]

> Fortunately I own a type2 and a couple of type3 laptops but none of
> which has a motion eye camera.

Leave the motion eye camera alone, the Linux support for the motion eye
camera is only for a very old specific model of the motion eye camera
(the PCI one made by Kawasaki). All the recent (last 5 years) Vaio
laptops with "Motion Eye" cameras are completly different hardware.

[...]

> At one point sonypi could just implement the ioctls and device file
> needed for backward compatibility.
> But I need to start playing seriously with sonypi's code before getti=
ng
> a clear idea if this is really doable or not.
>=20
> Stelian: thoughts?
> I remember an (very?) old discussion where you've been asked to
> implement sonypi using acpi functions and the answer was something li=
ke
> "if acpi will allow that..."

Hmm, this was probably from a time when the ACPI layer had zero externa=
l
APIs. Things have changed since then and should be much easier now,
especially since you have Len's support :)

--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
