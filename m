From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: lenovo ultrabay docking station: if power button pressed 1x it
 creates 2x the same ACPI event
Date: Thu, 25 Dec 2014 22:45:58 -0200
Message-ID: <20141226004558.GH18822@khazad-dum.debian.net>
References: <5497ED42.2050003@gmx.de>
 <1712969.2BqpevJf26@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55462 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708AbaLZAqM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Dec 2014 19:46:12 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 76275207D4
	for <linux-acpi@vger.kernel.org>; Thu, 25 Dec 2014 19:46:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1712969.2BqpevJf26@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, linux-acpi@vger.kernel.org

On Mon, 22 Dec 2014, Rafael J. Wysocki wrote:
> On Monday, December 22, 2014 11:06:58 AM Toralf F=F6rster wrote:
> > This happens at a Lenovo T440s (took me some time to realize why my=
 suspend/resume script runs twice).
> >=20
> > Is this a known issue ?
>=20
> Well, not in general.
>=20
> What kernel is this?
>=20
> Anyway, please file a bug entry at bugzilla.kernel.org for this sight=
ing
> so that we don't lose it from our radar.

And add me to its CC.  Thinkpad-acpi might be involved.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
