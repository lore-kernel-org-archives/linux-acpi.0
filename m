From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Subject: Re: [ACPI] Re: [BKPATCH] LAPIC fix for 2.6
Date: Sun, 10 Oct 2004 22:19:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1097443183.26647.31.camel@darkstar>
References: <1097429707.30734.21.camel@d845pe>
	 <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
	 <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
Reply-To: sergiomb@netcabo.pt
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268497AbUJJVTt@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-10-10 at 20:04, Maciej W. Rozycki wrote:
> On Sun, 10 Oct 2004, Linus Torvalds wrote:
>=20
> > > Hi Linus, please do a=20
> > >=20
> > > 	bk pull bk://linux-acpi.bkbits.net/26-latest-release
> >=20
> > Ok, this version of the patch suddenly looks like a real bug-fix in=
 that
> > it now makes the command line options "lapic"/"nolapic" a lot more
> > logical.
>=20
>  Hmm, any particular reason to keep the local APIC disabled by defaul=
t? =20
> Most BIOS vendors keep it disabled just because it's easier to get st=
uff
> set up this way -- with the APIC enabled you need to do the same step=
s to
> program the 8259As as with the APIC disabled, plus program the APIC=20
> itself, which provides no gain to BIOS itself or to DOS, so why bothe=
r?
>=20
>   Maciej
>=20

The problem is: trying enable some local apic's (for example on via
mother boards on my laptop), cause many problem, like hang on boot (wit=
h
ACPI), hang on Fn-F3 (video switch), power-off fails, etc. and no one
knows how resolved the problem. =20
So keep it disable if BIOS vendors say so, can be reasonable idea.

--=20
S=E9rgio M. B.
