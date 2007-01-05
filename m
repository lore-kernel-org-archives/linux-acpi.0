From: Stelian Pop <stelian@popies.net>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 05 Jan 2007 10:59:13 +0100
Message-ID: <1167991153.8985.19.camel@localhost.localdomain>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <1167953784.4901.5.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:3970 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161035AbXAEJ7R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 04:59:17 -0500
In-Reply-To: <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

Le vendredi 05 janvier 2007 =E0 01:11 +0100, Jan Engelhardt a =E9crit :
> On Jan 5 2007 00:36, Stelian Pop wrote:
> >@@ -61,6 +61,7 @@ static struct acpi_driver sony_acpi_driv
> >=20
> > static acpi_handle sony_acpi_handle;
> > static struct proc_dir_entry *sony_acpi_dir;
> >+static struct acpi_device *sony_acpi_acpi_device =3D NULL;
>=20
> acpi_acpi?

Yeah, maybe Mattia will have more imagination than I at naming
variables :)

--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
