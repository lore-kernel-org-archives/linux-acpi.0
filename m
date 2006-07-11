From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: Please help: ACPI not working on DELL Inspiron 1150
Date: Tue, 11 Jul 2006 17:15:13 +0200
Message-ID: <44B3C081.6060104@tzi.de>
References: <BAY116-F990288CF0C74028ADFE5FC86B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:22516 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S1750990AbWGKPPA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Jul 2006 11:15:00 -0400
In-Reply-To: <BAY116-F990288CF0C74028ADFE5FC86B0@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?= <ruslanledesmag@hotmail.com>
Cc: linux-acpi@vger.kernel.org



Rusl=E1n Ledesma Garza wrote:
>=20
> There is no mailloop. I thought the mail hadn't reached the mailing l=
ist
> because no one had answered me anything.
This is a maillist, pleas do not expect, that you get an answer within
hours... I would say if you didn't get an answer within 2 days it's ok,
to ask again... But if you ask again, please do not just resend your ol=
d
email. Think about why nobody answered...
>=20
> I thought I could get some little help but it seems as if I'm not in =
the
> right place or no one seems interested in making ACPI work on some De=
ll
> laptops. From what I've researched, I've discovered this is not an
> isolated malfunction.
>=20
> What I ask is some feedback. What should I do first in order to get t=
his
> thing fixed?
>=20
> Besides I've been asking a few questions which I feel have not been
> answered very well.
> -Is the DSDT a firmware?
Sort of (for more information go to www.acpi.info)
> -If it is so where does it reside?
In the bios
> -I found a tutorial on how to "fix" the DSDT. They talked about loadi=
ng
> the DSDT on startup through an image file. What does this mean?

The DSDT can be be replaced by the host OS a patch for this purpose can
be found at :
http://gaugusch.at/kernel.shtml.
In general it is not the right way to replace the DSDT. Linux should
work on any box without replacing the DSDT...

Greetings
   Janosch
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
