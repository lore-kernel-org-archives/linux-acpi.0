From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Dell laptop problem with acpid
Date: Wed, 17 Nov 2004 19:09:17 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC092@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>Thus wrote Cederik de Leon:
>>    I want to check if ACPID reports the actions (like LID switch, PW
>> Button etc), the daemon is up and running on my DEBIAN system, when i
>> close the computer i spect a message into acpid log, but nothing's
>> happend... some times the actions was logged, (LID SW) -for example,
>> but it's erratic and unpredictable- I'm running 2.6.9 Kernel. And the
>> acpitool reports the general status of the computer.

Usually, Notify op in AML method can cause event generated through
/proc/acpi/event

>
>There is a regression in event handling visible on some=20
>hardware (Maxdata
>pro8000x here, but there's been other reports, even on this ml).
>Basically, the ACPI SCI seems to be raised correctly according to
>/proc/interrupts, but the events are reported erratically or=20
>not reported
>at all. As a sidenote: kacpid doesn't spin when that happens.=20
>Any hints=20
>on how to debug this further?

First, check Notify op is existed in AML method,=20
then, verify acpi_*_notify are installed.
Intuitively,  Notify op was executed conditionally.

Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
