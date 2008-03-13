From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Thu, 13 Mar 2008 13:23:44 +0100
Message-ID: <20080313122344.GD27873@ics.muni.cz>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080312133529.GB21290@khazad-dum.debian.net> <20080312135521.GE8141@ics.muni.cz> <200803121952.42666.arekm@maven.pl> <20080312193637.GA27873@ics.muni.cz> <20080312211306.GD30864@khazad-dum.debian.net> <20080313120514.GH17940@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:38481 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbYCMMYJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 08:24:09 -0400
Content-Disposition: inline
In-Reply-To: <20080313120514.GH17940@kernel.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Arkadiusz Miskiewicz <arekm@maven.pl>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, Mar 13, 2008 at 01:05:14PM +0100, Jens Axboe wrote:
> And lets now get back to reality - the reality that now breaks the
> previously working setup of lots of users. So you are telling me that=
 in
> order to get my volume key functionality back I have to get rid of HA=
L
> and X?
>=20
> Lets turn back time a bit. Why was this change made? IOW, what was th=
e
> reason for breaking a working setup for lots of users? It better be a
> damn good reason, or I would heavily argue for reverting this change =
so
> that 2.6.25 actually WORKS as expected for thinkpad users.

so, you are telling that xev does not show keycodes of volume buttons f=
or you,
right? Because for me, it works. Thinkvantage does not work.

--=20
Luk=E1=B9 Hejtm=E1nek
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
