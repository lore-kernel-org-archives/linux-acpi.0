From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: kacpid problems
Date: Mon, 8 Nov 2004 09:58:49 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC028@pdsmsx403>
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
To: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Could you verify if killing kacpid can make the thing better?

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of dev_zero
>Sent: 2004=C4=EA11=D4=C26=C8=D5 7:39
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] kacpid problems
>
>Hello,
>
>My trip_points file in /proc/acpi/thermal_zone/THRM looks like this:
>critical (S5):           85 C
>passive:                 70 C: tc1=3D5 tc2=3D3 tsp=3D256 =
devices=3D0xcdde39a8
>active[0]:               45 C: devices=3D0xcdd94c28
>
>The problem comes when I try to compile big programs, like=20
>inkscape(vector drawing program) or when I play games. I think=20
>this is a=20
>bug, but I don't really know, because I'm not a acpi programmer.
>When my processor gets too hot, over 85 C it tries to=20
>shutdown(S5), but=20
>the only thing that happends is that kacpid starts running and runns=20
>with 99% CPU usage.
>(taken from top)
>5 root       7 -10     0    0    0 R  99.0  0.0   0:17.94 kacpid
>
>Is it someone who knows what is wrong? Is it a bug or is it my=20
>hardware=20
>that is the problem?
>
>thanks in advance
>
>Jon Emil
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
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
