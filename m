From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: Tablet PC + 2.4.18 + acpi 20020726 + swsup11 working !
Date: Tue, 6 Aug 2002 07:24:10 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33L2.0208060721141.10089-100000@dragon.pdx.osdl.net>
References: <20020806140043.GB16571@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020806140043.GB16571-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: =?iso-8859-1?Q?J=F6rg?= Sonnenberger <joerg.sonnenberger-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 6 Aug 2002, Ducrot Bruno wrote:

| On Tue, Aug 06, 2002 at 03:28:27PM +0200, J=F6rg Sonnenberger wrote:
| > Am Dienstag, 6. August 2002 14:04 schrieb Robert W=F6rle:
| > > So what is this pci1 and pic2 thing ??? and why is it residing at my
| > > wanted IO ???
| >
| > Let me guess: PIC =3D Programmable Interrupt Controller,
| > so I think you don't wanna mess with it! The interesting question is, w=
hy is
| > your device in this range? This ports are reserved since the days of IB=
M's
| > good old AT.
| >
|
| Well, not all those ports are used by the original 8259A.  And the PIC 2,=
 is
| 'only' at range A0-AF, according to Ralf Brown list.  Linux extend it a l=
ittle,
| but I don't know why.

I guess it depends on which chipset is used or checked then.
I just checked the 82801BA-ICH2 (Intel).
It says that PIC2 is in about 1/2 of the IO addresses between
0xa0 and 0xbd inclusive, with 0xb2-0xb3 used for Power Management.

--=20
~Randy



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
