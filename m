From: Frans Pop <elendil@planet.nl>
Subject: Re: Regression from 2.6.28-rc7: Commit 7cd5b08be3 breaks startup on Toshiba Portege R500
Date: Thu, 4 Dec 2008 00:13:32 +0100
Message-ID: <200812040013.34009.elendil@planet.nl>
References: <200812032300.19110.rjw@sisk.pl> <200812032300.19110.rjw@sisk.pl> <alpine.LFD.2.00.0812031412060.3256@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml15.KPNXCHANGE.COM ([213.75.38.115]:35000 "EHLO
	hpsmtp-eml15.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754203AbYLCXNg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Dec 2008 18:13:36 -0500
In-reply-To: <alpine.LFD.2.00.0812031412060.3256@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rjw@sisk.pl, wim@iguana.be, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, lenb@kernel.org, linux-kernel@vger.kernel.org

> Hmm. I wonder if the bug is this one-liner (it really looks like an
> idiotic typo).
>
> Can you test?
>
> =A0drivers/watchdog/iTCO_wdt.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.=
c
> index 26173a2..5b395a4 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -392,7 +392,7 @@ static int iTCO_wdt_stop(void)
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0/* Bit 13: TCO_EN -> 1 =3D Enables the TCO lo=
gic to generate SMI#
> */ val32 =3D inl(SMI_EN);
> -=A0=A0=A0=A0=A0=A0=A0val32 &=3D 0x00002000;
> +=A0=A0=A0=A0=A0=A0=A0val32 |=3D 0x00002000;
> =A0=A0=A0=A0=A0=A0=A0=A0outl(val32, SMI_EN);
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0/* Set the NO_REBOOT bit to prevent later reb=
oots, just for
> sure */

=46ixes my X.Org issue (http://lkml.org/lkml/2008/12/3/178).

Cheers,
=46JP
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
