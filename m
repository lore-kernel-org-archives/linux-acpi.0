From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: [PATCH] ACPI/Processor: C1/C3 states promotion and demotion
Date: Tue, 10 Feb 2004 11:21:20 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA03F9E5A8@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org [mailto:eric.piel@tremplin-utc.net]
> Sent: Monday, February 09, 2004 10:07 PM
> To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] [PATCH] ACPI/Processor: C1/C3 states promotion and

> Some processors seems to support only C1 and C3 states, for=20
> instance... mine ;-)
> (Pentium III Coppermine). The problem is that, in this case,=20
> no promotion or
> demotion are linking those two states, therefore the=20
> preocessor never goes to C3!

Hmmm so.. your processor only has C1 and C3 and no C2 right??
and you're saying since there's no C2, it will never go to c3


>=20
> The attached patch (against kernel 2.6.1) should do the=20
> trick, that's mainly a
> copy-paste of the C2/C3 code. It works fine on my computer=20
> (and the temperature
> really goes down :-) ).

Any idea what is 'threshold_count' and 'latency_ticks'
and what it does? My Processor Pentium M doen't go to C3 much.

=20


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
