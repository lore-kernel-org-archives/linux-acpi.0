From: Andi Kleen <ak@suse.de>
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
Date: Sun, 30 Apr 2006 10:50:22 +0200
Message-ID: <200604301050.22984.ak@suse.de>
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <pan.2006.04.29.21.00.09.180837@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:13974 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751054AbWD3Iuc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Apr 2006 04:50:32 -0400
In-Reply-To: <pan.2006.04.29.21.00.09.180837@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: discuss@x86-64.org
Cc: Matthieu CASTET <castet.matthieu@free.fr>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Saturday 29 April 2006 23:00, Matthieu CASTET wrote:
> Hi,
>=20
> Le Sat, 29 Apr 2006 20:30:10 +0200, Mikael Pettersson a =E9crit=A0:
>=20
>=20
> >=20
> > Is there a better way to do this? ACPI?
> >=20
> Yes, I believe using PNP layer (that use ACPI with pnpacpi) with PNP0=
800
> will be cleaner.

Please do a patch then.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
