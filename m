From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: kacpid problems
Date: Tue, 16 Nov 2004 11:29:41 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC075@pdsmsx403>
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
To: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The big slowdown you saw shouldn't be caused by that code change, which
just means issuing poll at  5s frequency. I think it's self-effacing =
enough. :-)

Thanks
Luming=20

>-----Original Message-----
>From: Laszlo 'GCS' Boszormenyi [mailto:gcs-gKC9iF2I70U@public.gmane.org]=20
>Sent: 2004=C4=EA11=D4=C216=C8=D5 8:36
>To: Yu, Luming
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] kacpid problems
>
>* Yu, Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [2004-11-09 16:23:13 +0800]:
>
>> I suspect we need a sane check against sleep_time.
>> Please testing the following debug patch.
> Tried. The bug still exists, but now kacpid does not stuck in a D
>state and I can power off the machine, it does not fail with
>acpi_power_off called as a last message.
>
>> Also, please sent the output of the activity in /proc/acpi/event .
> I need to stop acpid, but doing a cat after it, I do not see any
>output. How am I supposed to get an output?
>
>>=20
>> +       sleep_time =3D 5000; /* 5 seconds */
>> +
>>         /*
> It just slows down the polling on /proc/acpi/event , right? It helps,
>as see above, but if I run a CPU intense application, mozilla loading a
>big page, or trying to watch a movie, then I see a big slowdown.
>
>Hope this helps,
>Laszlo
>
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
