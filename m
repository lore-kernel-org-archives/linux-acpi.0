From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Tablet PC + 2.4.18 + acpi 20020726 + swsup11 working !
Date: Tue, 6 Aug 2002 16:00:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020806140043.GB16571@poup.poupinou.org>
References: <3D4F7B2A.2090602@symplon.com> <20020806091304.GA15963@poup.poupinou.org> <3D4FBB33.8070501@symplon.com> <200208061528.27394.joerg.sonnenberger@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200208061528.27394.joerg.sonnenberger-S0/GAf8tV78@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: =?iso-8859-1?Q?J=F6rg?= Sonnenberger <joerg.sonnenberger-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 06, 2002 at 03:28:27PM +0200, J=F6rg Sonnenberger wrote:
> Am Dienstag, 6. August 2002 14:04 schrieb Robert W=F6rle:
> > So what is this pci1 and pic2 thing ??? and why is it residing at my
> > wanted IO ???
>=20
> Let me guess: PIC =3D Programmable Interrupt Controller,
> so I think you don't wanna mess with it! The interesting question is, w=
hy is=20
> your device in this range? This ports are reserved since the days of IB=
M's=20
> good old AT.
>=20

Well, not all those ports are used by the original 8259A.  And the PIC 2,=
 is
'only' at range A0-AF, according to Ralf Brown list.  Linux extend it a l=
ittle,
but I don't know why.

--=20
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
