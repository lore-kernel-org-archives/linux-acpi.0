From: Andi Kleen <ak@suse.de>
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
Date: Tue, 2 May 2006 19:50:17 +0200
Message-ID: <200605021950.17737.ak@suse.de>
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200604301050.22984.ak@suse.de> <445798F6.3050102@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:52166 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964935AbWEBRuW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 May 2006 13:50:22 -0400
In-Reply-To: <445798F6.3050102@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: discuss@x86-64.org
Cc: matthieu castet <castet.matthieu@free.fr>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 02 May 2006 19:37, matthieu castet wrote:
> Hi,
>=20
> Andi Kleen wrote:
> > On Saturday 29 April 2006 23:00, Matthieu CASTET wrote:
> >=20
> >>Hi,
> >>
> >>Le Sat, 29 Apr 2006 20:30:10 +0200, Mikael Pettersson a =C3=A9crit =
:
> >>
> >>
> >>
> >>>Is there a better way to do this? ACPI?
> >>>
> >>
> >>Yes, I believe using PNP layer (that use ACPI with pnpacpi) with PN=
P0800
> >>will be cleaner.
> >=20
> >=20
> > Please do a patch then.
> >=20
> Is something like that is acceptable ?

Does it work?=20

Also I have no idea if all x86 systems report the PC speaker in ACPI - =
a small
survey of that would be probably a good idea. I guess just most of them=
 reporting it would be=20
reasonable.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
