From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [patch 5/7] asus-laptop: add display switching support
Date: Fri, 26 Jan 2007 10:49:32 +0100
Message-ID: <200701261049.32572.corentincj@iksaif.net>
References: <200701251254.56798.corentincj@iksaif.net> <200701260304.32068.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:57495 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161018AbXAZJte convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jan 2007 04:49:34 -0500
In-Reply-To: <200701260304.32068.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Le vendredi 26 janvier 2007 09:04, Len Brown a =E9crit=A0:
> On Thursday 25 January 2007 06:54, Corentin CHARY wrote:
> > /sys/.../asus-laptop/display can now be used to switch displays lik=
e the
> > old /proc/acpi/asus/disp does
> >
> > Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> >  asus-laptop.c |   82
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file
> > changed, 82 insertions(+)
>
> Tried to apply this series on top of 2.6.20-rc6 and it stopped applyi=
ng
> here. Late here, maybe operator error...
Ok, not very hard to do, and the first patch was bugged :/ (ASUS_ACPI i=
nstead=20
of ACPI_ASUS in Kconfig, bad Makefile patch, etc ...). I will send a ne=
w=20
series which apply on top of 2.6.20-rc6, and without any bug, in the ne=
xt=20
hours.


--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
