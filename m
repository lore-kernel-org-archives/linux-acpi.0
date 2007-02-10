From: Stelian Pop <stelian@popies.net>
Subject: Re: sony-laptop vs sonypi (Re: [PATCH 1/2] Add new sony laptop
	drivers maintainer)
Date: Sat, 10 Feb 2007 22:59:43 +0100
Message-ID: <1171144783.5026.14.camel@localhost.localdomain>
References: <11709622011964-git-send-email-malattia@linux.it>
	 <1171028098.6387.15.camel@localhost.localdomain>
	 <56393.85.47.20.193.1171029689.squirrel@picard.linux.it>
	 <200702091158.18909.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:4234 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbXBJV7v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Feb 2007 16:59:51 -0500
In-Reply-To: <200702091158.18909.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

Le vendredi 09 f=E9vrier 2007 =E0 11:58 -0500, Len Brown a =E9crit :

> sonypi is an interesting beast, and I do mean beast.
> It pre-dates Linux ACPI support by several years
> and is chock-full of reverse engineered magic numbers.

Yep. It was Andrew Trigdell (with friends) who reverse engineered some
of those magic numbers in the first place, and even I never knew what
were they good for.

[...]

> I think one of the major decisions you need to make going forward
> is if it makes sense to maintain the parts of sonypi
> that are reverse engineered AML -- rather than simply
> running in ACPI mode and invoking the AML in the BIOS.

Personaly I think that running without ACPI today is no longer an
option, especially on laptops. So I would indeed go in this direction.

[...]

> Personally, I think that invoking machine specific AML
> has its risks, but invoking C-ized machine specific AML
> sucked into a platform specific driver borders on the insane.
> (but Linux didn't have ACPI in 2000, so maybe "determined"
> would be a more appropriate word:-)

I'll take that as a compliment then :)

> Stelian,
> I think if you can list what you know actually works on what models,
> and what may not work, and what you think about the code needs to
> be changed, that would help Mattia enormously.

Unfortunately, this is something I always wanted to do and never get
around to. I don't have such a list, I only have a rather big mail
folder containing sony related mail.

I don't remember if I already said this, but I think it would be a good
idea to start a wiki to create some sort of documentation.

> I suggest that the goal might be to have a single consolidated
> sony-laptop driver.  Ie. port the working features one by one
> from sonypi into sony-laptop, and when sony-laptop can do everything
> that sonypi can do (though maybe not with the same ioctl interface et=
c)
> the schedule sonypi for deletion.  But in the mean time, on the
> assumption the people actually use sonypi to make their vaio's
> dance in useful ways, I would leave it alone for their benefit.

It seems a reasonable way to pursue.

Thanks,

--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
