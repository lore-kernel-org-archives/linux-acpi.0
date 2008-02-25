From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Mon, 25 Feb 2008 21:49:51 +0100
Message-ID: <20080225204951.GB4432@ics.muni.cz>
References: <20080225093914.GB4375@ics.muni.cz> <200802251247.30605.rjw@sisk.pl> <20080225200354.GE16513@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:38394 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbYBYUuQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 15:50:16 -0500
Content-Disposition: inline
In-Reply-To: <20080225200354.GE16513@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, Feb 25, 2008 at 05:03:54PM -0300, Henrique de Moraes Holschuh w=
rote:
> This commit is indeed broken, and I have a tentative fix for it.  But=
 I'd
> like to have a better description of just "how" the thinkpad keys do =
not
> work anymore, to make sure I fix the entire breakage in one go.  I wi=
ll
> stare at the code and the fix a bit more before sending in any patche=
s,
> though.

Well, keys generate ACPI interrupt but acpid never receives any event.

I would be happy to test fixes to see whether things go well.

--=20
Luk=E1=B9 Hejtm=E1nek
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
