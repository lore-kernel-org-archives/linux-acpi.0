From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: 2.6.9 battery status  regression ? [was RE: Battery status wrong from 2.6.7 when running on batteries]
Date: Tue, 16 Nov 2004 17:20:24 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC079@pdsmsx403>
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
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I just find out the changes that could affect this area. And has =
attached=20
at bug 3678. I hope you guys can verify if it is a regression.=20

Not sure reboot or Lid issue.=20

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Karol Kozimor
>Sent: 2004=C4=EA11=D4=C27=C8=D5 8:13
>To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
>Cc: Fred Labrosse; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Battery status wrong from 2.6.7 when=20
>running on batteries
>
>Thus wrote hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org:
>> There is a bad workaround for our laptops: If you close the=20
>lid, it will=20
>> not restart. That is a protective rule in the BIOS that=20
>should prevent the=20
>> laptop to start while in it's covered in its bag (I suppose).
>
>That, or there's some sort of PM (APM stand-by?) going on when=20
>the lid is
>closed _and_ ACPI is off. Try booting with acpi=3Doff and close=20
>the lid --
>see particularly if the NIC responds or if the timer interrupts go off.
>Best regards,
>
>--=20
>Karol 'sziwan' Kozimor
>sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Sybase ASE Linux Express Edition - download now for FREE
>LinuxWorld Reader's Choice Award Winner for best database on Linux.
>http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
