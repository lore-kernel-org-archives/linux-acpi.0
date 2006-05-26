From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
Date: Thu, 25 May 2006 17:04:18 -0700
Message-ID: <1148601858.3070.62.camel@whizzy>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com>
	 <1148583675.3070.41.camel@whizzy> <20060525221222.GA1608@elf.ucw.cz>
	 <20060525221744.GA1671@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51863 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965201AbWEYXw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 May 2006 19:52:56 -0400
In-Reply-To: <20060525221744.GA1671@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 00:17 +0200, Pavel Machek wrote:
> On P=C3=A1 26-05-06 00:12:22, Pavel Machek wrote:
> > Hi!
> >=20
> > > > Does the panic go away with CONFIG_ACPI_DOCK=3Dn?
> >=20
> > > Can either Pavel or Andreas please try this little debugging patc=
h and
> > > send me the dmesg output?  Please enable the CONFIG_DEBUG_KERNEL =
option
> > > in your .config as well so that I can get additional info.
> >=20
> > Yep, you were right... this debugging patch helps.
>=20
> ...and docking +/- works, but it does not look like PCI in docking
> station is properly connected:
>=20

No, I would not expect PCI to work properly with the debug patch -
basically all I did was prevent the oops and confirm that this is the
issue, I did not actually solve the problem.

I need some way to prevent acpiphp from loading before dock is complete=
d
it's init.

I guess I will think about this some more.

Kristen
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
