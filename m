From: =?iso-8859-1?Q?=D8ystein_Gisn=E5s?= <oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org>
Subject: Re: Why nobody help me?
Date: Wed, 14 Jul 2004 11:04:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040714090418.GA26992@ozelot.stud.ntnu.no>
References: <000901c468ec$a4425e40$0800a8c0@SQUADRA>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000901c468ec$a4425e40$0800a8c0-RCveC9f1ksc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 13, 2004 at 05:18:24PM +0200, Gaetano Sferra wrote:
> ACPI errors on my AMILO D laptop still here, I'm waiting
> support from you. In last post of mine there is all details on
> AE_NOT_EXISTS boot errors and the dsdt attachment for my
> laptop. There isn't a valid or patched dsdt in your database at
> http://acpi.sourceforge.net so I still waiting for instructions.
> I'm using a 2.4.26 acpi-patched kernel and in the /proc/acpi directory
> all reports seems to be freezed, temperature 75C, trip points 85C,
> polling frequency is disabled and the cooling mode isn't supported at a=
ll.
> May be it is a config problem, I've readed all howtos in your site
> but... nothing... can someone help me please?
> =20
>  See my previous postings for more details.... or ask to me...

I've got an Amilo D 7830 myself, but I only have 2.6.7 vanilla without
any further patches. The DSDT should be unaware of kernel version and
all in all the DSDT of my Amilo D works well. The only workaround I
need is having OS to report bewing Windows NT instead of Linux to get
the interrupts working . I don't know why /proc/acpi won't be mounted
with your configuration, but it might be as a cause of the error you
get.

Thermal Zone basically give the same characteristics on my systems as
yours - it's not supported. How you managed to read out the values you
refered to without /proc/acpi is a mystery.. It would certainly be
helpful to know what kind of CPU your system is equipped with.

--=20
=D8ystein Gisn=E5s <oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org>
NTNU, Department of Telematics
Mob: (+47) 98861515 - MSN: oysteing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
