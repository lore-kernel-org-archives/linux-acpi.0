From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: S3 broken on a Samsung P30
Date: Fri, 12 Nov 2004 14:11:59 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003569022@scsmsx403.amr.corp.intel.com>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Pavel Machek
>Sent: Friday, November 12, 2004 1:17 PM
>To: Matthias Hentges
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] S3 broken on a Samsung P30
>
>Hi!
>
>> > Okay, oops, do
>> >=20
>> > 1:
>> > 	jmp 1b
>> >=20
>> > instead.
>>=20
>> I hope the following is correct:
>>=20
>> [snip]
>> ENTRY(wakeup_start)
>> wakeup_code:
>> 	wakeup_code_start =3D .
>> 	.code16
>>=20
>> 	BEEP
>> 1:=09
>> 	jmp	1b
>> =09
>>  	movw	$0xb800, %ax
>> 	movw	%ax,%fs
>> [/snip]
>
>Yes, looks ok.
>
>> Tried again with 2.6.10-rc1-bk22 (latest ACPI patches IIRC) and the
>> patched wakeup.S
>> Still no beep :(
>
>Too bad, I do not know how to debug this further. It is possible that
>those patches are not yet merged into mainline, I'm not sure, it was
>something like "correcting wakeup address".
>

Are you referring to virtual v/s physical address patch from Shaohua?
http://bugme.osdl.org/show_bug.cgi?id=3D3390
I think it is already there in latest acpi-test.

Thanks,
-Venki


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
