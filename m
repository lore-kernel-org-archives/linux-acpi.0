From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Re: [PATCH] Don't disable interrupts during EC access
Date: Wed, 17 Nov 2004 20:02:49 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC095@pdsmsx403>
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
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I didn't find DSDT on acpi.sf.net,
could you share it with me?

BTW, When you poll battery info,
please cat /proc/interrupts to me.

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Stefan Seyfried
>Sent: 2004=C4=EA11=D4=C217=C8=D5 19:50
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Re: Re: [PATCH] Don't disable interrupts=20
>during EC access
>
>On Wed, Nov 17, 2004 at 06:56:07PM +0800, Yu, Luming wrote:
>
>> >may this also help the awfully slow battery polling on some machines
>> >(e.g. Dell D600) or is this a completely different case?
>>=20
>> I'm not sure before you clearly describe your specific problem.
>
>Ok, i thought this was a well known problem. (everybody i know=20
>seems to have
>experience with it :-)
>
>On a Dell Latitude D600 (other machines also, but this i have=20
>tested more
>extensively), a "cat /proc/acpi/battery/BAT0/info" takes 180msec with
>CPU at 600MHz. With CPU at 1700MHz it takes 70msec.
>
>e239:~ # time cat /proc/acpi/battery/BAT0/info > /dev/null
>
>real    0m0.182s
>user    0m0.002s
>sys     0m0.178s
>e239:~ # powersave -f
>Speed set to maximum
>e239:~ # time cat /proc/acpi/battery/BAT0/info > /dev/null
>
>real    0m0.068s
>user    0m0.000s
>sys     0m0.067s
>
>this time is 100% kernel time and polling battery makes e.g.=20
>DVD playback
>"stutter" visibly. The machine basically comes to a halt for ~0.2sec.
>--=20
>Stefan Seyfried
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: InterSystems CACHE
>FREE OODBMS DOWNLOAD - A multidimensional database that combines
>robust object and relational technologies, making it a perfect match
>for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
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
