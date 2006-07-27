From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: Re: non functionable snd-ad1816a in Kernel 2.6.18-rc2
Date: Thu, 27 Jul 2006 15:45:55 +0200
Message-ID: <20060727134555.235500@gmx.net>
References: <20060718093434.60450@gmx.net>
 <200607241340.56353.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.21]:63965 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161075AbWG0Np4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 09:45:56 -0400
In-Reply-To: <200607241340.56353.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ambx1@neo.rr.com, len.brown@intel.com, linux-acpi@vger.kernel.org, castet.matthieu@free.fr, akpm@osdl.org


-------- Original-Nachricht --------
Datum: Mon, 24 Jul 2006 13:40:56 -0600
Von: Bjorn Helgaas <bjorn.helgaas@hp.com>
An: "Uwe Bugla" <uwe.bugla@gmx.de>
Betreff: Re: non functionable snd-ad1816a in Kernel 2.6.18-rc2

> On Tuesday 18 July 2006 03:34, Uwe Bugla wrote:
> > Just a reminder for everybody listening:
> > My soundcard (snd-ad1816a) does not work in Kernel 2.6.18-rc2.
> > I guess the reason for this is that Matthieu=B4s material is still
> residing in the mm-branch. Can I please have a constructive feedback =
where things
> are hanging after all that immense amount of time I spent to forward =
this
> issue?
> > A thousands of thanks for Matthieu=B4s work one more time!
> > The bug ID is 6292, and the ACPI_PRODUCER reject patch is still mis=
sing
> in the main vanilla tree.
>=20
> Yup, the patch is in the -mm tree, and should make its way to
> the mainline vanilla kernel eventually.  It does take a while,
> because we want to make sure it doesn't break somebody else's
> system while fixing yours.
>=20
> Bjorn
>=20
>=20
OK so far.
But how can we make sure that it does not break somebody else=B4s syste=
m while fixing mine when anything deriving from the two Intel guys is N=
AK?
If they would be a bit more cooperative things would go forward much fa=
ster I think.
I see this patchwork getting rusty in the mm-tree, and that can=B4t be =
it, can it?

Regards
Uwe

--=20


Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*. Nur noch kurze Zeit!
"Feel free" mit GMX DSL: http://www.gmx.net/de/go/dsl
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
