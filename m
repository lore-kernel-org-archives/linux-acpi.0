From: =?iso-8859-2?Q?Zden=ECk?= OGAR =?iso-8859-2?Q?Skal=E1k?=
	<skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Subject: Re: Intel ACPI
Date: Wed, 05 Feb 2003 07:29:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E40AF32.AA177847@monetplus.cz>
References: <4.3.2.7.2.20030204000748.00b62270@mail.dns-host.com> <20030204094540.GE1205@poup.poupinou.org> <20030204132251.E16744@suse.de> <20030204154359.GH1205@poup.poupinou.org> <20030204164641.A31886@suse.de> <20030204155548.GI1205@poup.poupinou.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Ducrot Bruno wrote:
> =

> On Tue, Feb 04, 2003 at 04:46:42PM +0100, Dave Jones wrote:
> > On Tue, Feb 04, 2003 at 04:43:59PM +0100, Ducrot Bruno wrote:
> >
> >  > > > Nothing, apart that it will not work reliability with Linux or=

> >  > > > any flavour of free *BSD.
> >  > > I wonder if it's worth allowing the user to override \_OS at boo=
ttime.
> >  > In fact, I *always* change my \_OS string.
> >
> > Interesting. For any noticable gain ?
> =

> S1 and S4bios work better, especially in 2.4 series, if \_OS is set as
> 'Microsoft Windows NT", because this OS have the same kind of support
> for suspending/resuming devices as Linux 2.4 in general...
> =

> 2.5 is another story.  I am not sure for now what is 'best'.

	So could we add kernel boot argument to allow changig/overriding the \_O=
S
string? Eg. acpi_os=3D"Microsoft Windows NT" to allow us to play with it =
without
rekompiling the kernel ?

	Zdenek OGAR Skalak

-- =

Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
