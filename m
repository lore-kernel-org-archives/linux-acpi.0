From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Why is it so hard to (get) help on ACPI?
Date: Thu, 17 May 2007 21:44:40 +0100
Message-ID: <20070517204439.GA23599@srcf.ucam.org>
References: <200705172005.47845.matija.suklje@rutka.net> <200705172132.06026.matija.suklje@rutka.net> <8f8ff01d0705171256m39b6e5t8a69f8095f00594b@mail.gmail.com> <200705172210.14815.matija.suklje@rutka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:35356 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbXEQUot (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 May 2007 16:44:49 -0400
Content-Disposition: inline
In-Reply-To: <200705172210.14815.matija.suklje@rutka.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matija =?iso-8859-15?Q?=A6uklje?= <matija.suklje@rutka.net>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org

On Thu, May 17, 2007 at 10:10:11PM +0200, Matija =C5=A0uklje wrote:
> Dne =C4=8Detrtek 17 maj 2007 21:56 ste napisali:
> > acpi.sf.net was near dead for several years already, since the time
> > then there was  a decision that if something works under _other_ OS=
,
> > it should work under Linux too. This made hacks to DSDT, etc obsole=
te.
>=20
> Meaning ugly hacking should be done in the kernel itself?

The kernel's job is to make hardware work. If the hardware works under=20
another OS, then it failing to work in Linux is a bug in Linux. So, yes=
,=20
the correct place to fix this sort of thing is in the kernel rather tha=
n=20
your DSDT.

However, please note that the DSDT is almost entirely irrelevant when i=
t=20
comes to things like suspend/resume. Modifying it is hugely unlikely to=
=20
make things work there.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
