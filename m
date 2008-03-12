From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Wed, 12 Mar 2008 19:52:41 +0100
Message-ID: <200803121952.42666.arekm@maven.pl>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080312133529.GB21290@khazad-dum.debian.net> <20080312135521.GE8141@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.carme.maven.pl ([193.239.45.138]:25667 "EHLO
	main.carme.maven.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbYCLTNX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Mar 2008 15:13:23 -0400
In-Reply-To: <20080312135521.GE8141@ics.muni.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>


> On Wed, Mar 12, 2008 at 10:35:29AM -0300, Henrique de Moraes Holschuh=
 wrote:
> > You shouldn't need to do anything other than teach userspace to res=
pond
> > to them, as they generate the proper KEY_* events.  If you are givi=
ng the
> > AML _OSI(Linux), at least...

I'm also seeing regression on my thinkpad z60m where with git tree (tes=
ted=20
again with 2 days old git) "thinkvantage" button stopped working (press=
ing it=20
was previously seen by some userspace kde which run konsole).

On 2.6.24 presses are seen.

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
