From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [Patch] ACPI IO-APIC IRQ parameter configuration#1
Date: Tue, 15 Jul 2003 00:25:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307150025.26020.adq_dvb@lidskialf.net>
References: <200307132239.06760.adq_dvb@lidskialf.net> <200307140128.14189.adq_dvb@lidskialf.net> <1058214306.1454.5.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1058214306.1454.5.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?q?S=E9rgio=20Monteiro=20Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 14 July 2003 21:25, S=E9rgio Monteiro Basto wrote:
> On Mon, 2003-07-14 at 01:28, Andrew de Quincey wrote:
> > On Monday 14 July 2003 00:04, S=E9rgio Monteiro Basto wrote:
> > > Hi
> > > In attachment  this patch for kernel 2.4.21,
> > > I don't have acknowledgments to know if it is good code, but can be
> > > applied to kernel 2.4.x
> >
> > Cool! Out of interest, does the patch solve or create any problems for
> > you?
>
> Hi
> Don't test it, I am just removing quirks and test my laptop, so far 4
> had gone.
>
> Until now, to work with my laptop I had to disable APIC.
> so the patch doesn't have effect.

Oh right... that might be yet another ACPI IRQ routing problem.... Could yo=
u=20
send me your /proc/acpi/dsdt and /proc/acpi/madt (using my patch)? If=20
possible, a dmesg from an (I assume failing) boot with APIC enabled would b=
e=20
dead handy too.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
