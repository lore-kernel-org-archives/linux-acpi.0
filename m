From: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: Re: Several problems on a toshiba S3000-X11
Date: Mon, 30 Sep 2002 17:50:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020930155044.GA21015@lps.ens.fr>
References: <20020927142320.GB2821@lps.ens.fr> <20020927154542.GH7904@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020927154542.GH7904-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 27, 2002 at 05:45:42PM +0200, Ducrot Bruno wrote:
> > When I read the battery state for the first couple of times, the
> > /proc/acpi files claim that I have two batteries present, and that bo=
th
> > batteries have a charge of 2040 mAh (capacity is 4000 mAh). After a
> > couple of readings, I have the truth (only one battery and whatever
> > capacity I have left.) That's annoying, and it didn't happen with my
> > previous kernel. I don't now if it comes from the patched DSDT or fro=
m
> > the new version of the acpi patch.
>=20
> This is a trouble with the original AML, and I have not corrected it.
>=20
Are you sure ? Bob McElrath and I never had this problem with the
original DSDT; it appeared when I used your hand-tuned version. It looks
that the problem lies into your correction...
>=20
> Only the restore should be made.  Actually, the
It is noted, I will try that. But I hope that it will go mainstream in a
future version.
>=20
> > So the computer shuts down, without warning, while it is not particul=
ary
> > hot, with nothing written in the logs, while the user was just using =
vim
> > in a xterm, at irregular times, and it can happen two or three times =
in
> > an afternoon.
> >=20
>=20
> Yes, I have this trouble with some version of ACPI now.  I think that I=
 need
> to incorporate now more smoothly with ACPI (that is, I need to use
> the function acpi_ec_read() etc. instead of providing them in the modul=
e,
> and so I avoid some possible races..)

So you confirm that it is ACPI related ? Do you think I can get rid of
that problem by disabling parts of ACPI ? (I guess I could boot with no
acpi at all, but that means no battery readings, no software shutdown and
no S1. That would be a sad world...)

=C9ric Brunet


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
