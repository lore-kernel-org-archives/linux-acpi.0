From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Dell laptop problem with acpid
Date: Wed, 17 Nov 2004 19:21:30 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC093@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

If nothing changed except AML interpreter,  you can
sue interpreter for this regression.  :-)=20

Can you verify 2.6.8.1 works?

Thanks
Luming=20

>-----Original Message-----
>From: Karol Kozimor [mailto:sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org]=20
>Sent: 2004=C4=EA11=D4=C217=C8=D5 19:19
>To: Yu, Luming
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Fu, Michael
>Subject: Re: [ACPI] Dell laptop problem with acpid
>
>Thus wrote Yu, Luming:
>> >There is a regression in event handling visible on some=20
>> >hardware (Maxdata
>> >pro8000x here, but there's been other reports, even on this ml).
>> >Basically, the ACPI SCI seems to be raised correctly according to
>> >/proc/interrupts, but the events are reported erratically or=20
>> >not reported
>> >at all. As a sidenote: kacpid doesn't spin when that happens.=20
>> >Any hints=20
>> >on how to debug this further?
>> First, check Notify op is existed in AML method,=20
>> then, verify acpi_*_notify are installed.
>> Intuitively,  Notify op was executed conditionally.
>
>Ugh, it's a regression, it worked well with 2.6.7 but works=20
>erratically on
>2.6.9. I doubt the AML code has changed since then.=20
>Additionally, it also
>affects standard features like a FF power button.=20
>Best regards,
>
>--=20
>Karol 'sziwan' Kozimor
>sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
