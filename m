From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Reading /proc/acpi/battery/BAT0/info causes high latency on Dell Lattitude D800
Date: Tue, 29 Mar 2005 10:56:44 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8407923605@pdsmsx403>
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
List-Id: linux-acpi@vger.kernel.org

Maybe this changeset make you think this is a regression.
http://linux-acpi.bkbits.net:8080/26-latest-test/diffs/include/acpi/accon=
fig.h@1.55?nav=3Dindex.html|src/.|src/include|src/include/acpi|hist/inclu=
de/acpi/acconfig.h

But, It just make some methods just run. It should be a totally new =
problem.

Thanks,
Luming

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Stefan Seyfried
>Sent: 2005=C4=EA3=D4=C229=C8=D5 4:46
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Re: Reading /proc/acpi/battery/BAT0/info=20
>causes high latency on Dell Lattitude D800
>
>On Sun, Mar 27, 2005 at 08:01:45AM +1000, Neil Brown wrote:
>> On Saturday March 26, luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
>> > Do you have this kind of problem before? Or just this kernel.
>
>it started being this bad between 2.6.10-rc2-bk9 and 2.6.10-rc2-bk10.
>But only with CONFIG_ACPI_DEBUG
>
>> Yes, I've had it for quite a while.  I don't remember a time when I
>> didn't have it.  It has just slowly become more and more=20
>annoying (not
>> worse, just more annoyig) so that I have decided to do=20
>something about
>> it.
>
>i reported the same on february 4th in a mail with subject
>"Bad battery regression on Dell D600 from 2.6.10-rc2-bk9 to=20
>2.6.10-rc2-bk10"
>
>The "solution" (although a bad one IMO) was to turn=20
>CONFIG_ACPI_DEBUG off.
>--=20
>Stefan Seyfried
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from=20
>real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
