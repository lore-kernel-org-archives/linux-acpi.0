From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [patch 0/7] New misc/asus-laptop.c driver
Date: Fri, 26 Jan 2007 14:04:23 +0100
Message-ID: <200701261404.23961.corentincj@iksaif.net>
References: <200701251254.34491.corentincj@iksaif.net> <200701260251.04762.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:36558 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965619AbXAZNE0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jan 2007 08:04:26 -0500
In-Reply-To: <200701260251.04762.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Le vendredi 26 janvier 2007 08:51, Len Brown a =E9crit=A0:
> On Thursday 25 January 2007 06:54, Corentin CHARY wrote:
> > Hi,
> > I've done a lot of work on asus_acpi
>
> Excellent.
>
> A couple of nits on e-mail patch format:
>
> Please fit the comments within 80 lines.
> ie. pipe them through fmt -w 68 or something.
>
> The --- in your e-mail should come before the diffstat, not after.
>
done :) thanks.
I just send the new series, with some cleanups (write_led -> write_stat=
us,=20
etc ..), and some bugfix ... This series is made to apply on top of=20
2.6.20-rc6. This time, my mails are well formatted, I hope :p.

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
