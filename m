From: "Diefenbaugh, Paul S" <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: EC SCI model?
Date: Mon, 30 Jun 2003 14:16:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <59278FC0C48A994BABABD069571E4568017903FB@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> When you done those tests, it was before the fix which forced the
> SCI interrupt to be correctly initialized if not present in firmware
> routing last year?

Our original implementation was done on the BeOS several years ago; then
ported to Linux.  I believe the problem is unrelated to the SCI issue
you've mentioned (an EC hardware bug).

___________________________________________=20
Paul Diefenbaugh=20
Intel Corporation, MPG | MPA | System Software Architecture


-----Original Message-----
From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]=20
Sent: Thursday, June 26, 2003 4:26 AM
To: Diefenbaugh, Paul S
Cc: Grover, Andrew; Nate Lawson; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] EC SCI model?

Hi Paul, pleased to read you again on this list.

On Tue, Jun 24, 2003 at 10:54:59PM -0700, Diefenbaugh, Paul S wrote:
> I'd echo Andy's recommendation to check out the Linux code.  We went
> through quite a bit of wrenching before getting this to work right on
> all of the various ECs - noting that most are incapable of handing
> EC_SCIs in a purely interrupt-driven fashion...

When you done those tests, it was before the fix which forced the
SCI interrupt to be correctly initialized if not present in firmware
routing last year?
If yes, could you re-consider to redo the tests?

Cheers,

--=20
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
