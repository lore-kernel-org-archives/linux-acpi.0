From: =?iso-8859-2?Q?Zden=ECk?= OGAR =?iso-8859-2?Q?Skal=E1k?=
	<skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Subject: Re: Armada 110
Date: Thu, 14 Nov 2002 08:01:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DD34A64.57D3AC9C@monetplus.cz>
References: <20021113205208.GA30683@apollo.bingo-ev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: FrAnKenstEin <fake-3RXyrymLNR0b1SvskN2V4Q@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

FrAnKenstEin wrote:
> =

> Hi,
> =

> On Tue, Nov 12, 2002 at 12:48:45PM -0800, Grover, Andrew wrote:
> ...
> > If you've been having problems with reading battery or other informat=
ion
> > being very slow, please try this release and report if problems persi=
st.
> =

> they do. i wrote a mail regarding my compaq armada 110's battery state =
2
> days ago, and gathered further information since then.
> =

> wether i override my dsdt with a fixed one does no longer seem to have =
an
> influence on this (which i found out after compiling 2.5.47 vanilla and=

> seeing BAT1 without changes) problem. I fixed the things mentioned on t=
he
> cpqlinux-page... maybe there's more wrong code in there.

	I have Armada 110 too & had the same problem. After fiddling with DSDT, =
I found
solution (at least it's working for me :-)
	Try this: =

		a) dissasemble DSDT
		b) patch according to cpqlinux-page
		c) patch the method _BST in device BAT1 =

                   (should be in about 11% of file):
                         Else
                         {
				\_SB.Z000(0x8A)
				SEBS /* \_SB.BAT1.SEBS */()
+				UPBS /* \_SB.BAT1.UPBS */()
			 }
		d) assemble & try

	My own opinion is, that =

	a) SEBS is SetBateryStatus <-- store "static status" information about b=
atery		=

	b) UPBS is UpdateBatteryStatus <-- update according to "current state"

	Hope it help :-) By

		Zdenek OGAR Skalak
-- =

Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
