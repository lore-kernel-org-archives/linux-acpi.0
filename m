From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
Date: Fri, 26 May 2006 09:15:18 +0200
Message-ID: <20060526071518.GC1699@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com> <1148583675.3070.41.camel@whizzy> <20060525221222.GA1608@elf.ucw.cz> <20060525221744.GA1671@elf.ucw.cz> <1148601858.3070.62.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6121 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751339AbWEZHQB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 May 2006 03:16:01 -0400
Content-Disposition: inline
In-Reply-To: <1148601858.3070.62.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On =C4=8Ct 25-05-06 17:04:18, Kristen Accardi wrote:
> On Fri, 2006-05-26 at 00:17 +0200, Pavel Machek wrote:
> > On P=C3=A1 26-05-06 00:12:22, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > > Does the panic go away with CONFIG_ACPI_DOCK=3Dn?
> > >=20
> > > > Can either Pavel or Andreas please try this little debugging pa=
tch and
> > > > send me the dmesg output?  Please enable the CONFIG_DEBUG_KERNE=
L option
> > > > in your .config as well so that I can get additional info.
> > >=20
> > > Yep, you were right... this debugging patch helps.
> >=20
> > ...and docking +/- works, but it does not look like PCI in docking
> > station is properly connected:
> >=20
>=20
> No, I would not expect PCI to work properly with the debug patch -
> basically all I did was prevent the oops and confirm that this is the
> issue, I did not actually solve the problem.
>=20
> I need some way to prevent acpiphp from loading before dock is comple=
ted
> it's init.
>=20
> I guess I will think about this some more.

Using different _init levels? Like putting dock at subsys_initcall()
while acpiphp at late_initcall()?
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
