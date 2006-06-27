From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Tue, 27 Jun 2006 16:19:06 +0200
Message-ID: <20060627141906.6140@gmx.net>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com>
  <20060627000324.b9457fb4.akpm@osdl.org>  <20060627073704.GD3438@neo.rr.com>
 <1151393390.21189.59.camel@sli10-desk.sh.intel.com>
 <1151409746.44a11e52e7002@imp8-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.21]:9355 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932364AbWF0OTH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 10:19:07 -0400
In-Reply-To: <1151409746.44a11e52e7002@imp8-g19.free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: castet.matthieu@free.fr, shaohua.li@intel.com
Cc: bjorn.helgaas@hp.com, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, ambx1@neo.rr.com


-------- Original-Nachricht --------
Datum: Tue, 27 Jun 2006 14:02:26 +0200
Von: castet.matthieu@free.fr
An: Shaohua Li <shaohua.li@intel.com>
Betreff: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources

> Selon Shaohua Li <shaohua.li@intel.com>:
>=20
> >
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.gi=
t;a=3Dcommit;h=3Dc4bb6f5ad968540d7f9619565bacd18d7419b85f
> > Thanks and sorry I didn't find the issue before. We'd better blackl=
ist
> > root bridge. I saw at lest one BIOS (IA64 box) didn't assign correc=
t
> > producer/consumer flag to root bridge resources. Blacklist it is mu=
ch
> > safer.
>=20
> Is only PNP0A03 is producer type in __all__ ACPI possible devices ?
> If not we will have the same problem with others devices...
>=20
> I don't think blacklist is the solution : pnpacpi should be able to h=
andle
> all
> ressources types : we should complete the implementation instead of
> blacklist
> devices our implementation doesn't support.
>=20
> If there are broken ACPI bios, there should be firmware update, a pat=
ched
> dsdt
> or a quirk, but no "quirk and no generic solution".
>=20
> To be honest I am bored about this acpi stuff : there are no reply wh=
en
> you ask
> questions or propose things, it takes months to have a patch, there a=
re
> lot's
> of broken ACPI bios, ...
>=20
> For example http://bugzilla.kernel.org/show_bug.cgi?id=3D3358 I submi=
ted 1,5
> years
> ago is still present in the kernel...
>=20
>=20
> Matthieu CASTET
>=20
> --------
>=20
> "The fact that ACPI was designed by a group of monkeys high on LSD, a=
nd is
> some
> of the worst designs in the industry obviously makes running it at _a=
ny_
> point
> pretty damn ugly. " (July 31, 2005) Linus Torvalds

Salut Matthieu, hi everybody else wanting to listen,
A thousand Thanks for:
a. your excellent work in doing this patch. I did not test mm3 right no=
w, but I swear I will do that as soosn as possible.
b. this very good citation from Linus hitting it to the point very exac=
tly (Is the Microsoft team meant by those acid trip monkeys??? I simply=
 do not know who the fuck invented this rubbish!).
"To be honest I am bored about this acpi stuff : there are no reply whe=
n
you ask questions or propose things, it takes months to have a patch, t=
here are lot's of broken ACPI bios, ..."
But you do not mean me personally, do you? I spent couples of days on t=
his sucking shit NOT to "fight down" anything or anybody (like Bjorn st=
ated), but to help finding a solution in this very sucking issue.
As a cross-platform solution is appreciated I understand your exhaust a=
nd frustration very well. Blacklisting is NO good solution at all, is i=
t?

=46urthermore I really dislike those abbreviations like "NAK", "IMHO" e=
tc.
And I=C2=B4d like to repeat my proposal:
This stuff should NOT be in the mm-branch, but in a RC-candidate of the=
 main vanilla: There would be much more traffic on this issue and a sig=
nificant higher motivation for resolving that so that everyone is satis=
fied. But Andrew will never agree on this, will he ever?

Cheers everybody, just smile now

Uwe

--=20


"Feel free" =E2=80=93 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
