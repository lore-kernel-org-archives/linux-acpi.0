From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Subject: Re: [patch 06/11] misc,acpi,backlight: compal Laptop Extras
Date: Tue, 10 Jun 2008 23:51:36 +0200
Message-ID: <20080610235136.7cda6369@debian>
References: <200806092322.m59NMNs9013970@imap1.linux-foundation.org>
	<alpine.LFD.1.10.0806101253390.14381@localhost.localdomain>
	<1213133339.5013.56.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:27666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbYFJVvm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jun 2008 17:51:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1926238fgg.17
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2008 14:51:40 -0700 (PDT)
In-Reply-To: <1213133339.5013.56.camel@dax.rpnet.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, aystarik@gmail.com, hmh@hmh.eng.br

Dnia 2008-06-10, o godz. 22:28:59
Richard Purdie <rpurdie@rpsys.net> napisa=B3(a):

> On Tue, 2008-06-10 at 12:55 -0400, Len Brown wrote:
> >=20
> > On Mon, 9 Jun 2008, akpm@linux-foundation.org wrote:
> >=20
> > > From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> > >=20
> > > This is driver for Compal Laptop: FL90/IFL90, based on MSI driver=
=2E
> > >=20
> > > This driver exports a few files in /sys/devices/platform/compal-l=
aptop/:
> > >  lcd_level - screen brightness: contains a single integer in the =
range 0..7 (rw)
> >=20
> > why is it a good idea to implement this platform specific lcd_level=
 API
> > and at the same time implement the generic backlight API?
>=20
> I've asked about this before and suggested the lcd_level attribute be
> removed since the backlight API does everything that attribute does i=
n a
> standardised way. I never did get a response.
>=20

Driver was rewritten from original msi driver, so this attribute was al=
so
copied. I can remove it in a future version and use only standard backl=
ight API.

--=20
 Cezary
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
