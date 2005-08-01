From: Bram Vandoren <brambi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Acer Travelmate 4651lci: freeze 10-20s after resume (S3)
Date: Mon, 1 Aug 2005 21:34:05 +0200
Message-ID: <3d64b7f405080112344201642d@mail.gmail.com>
Reply-To: Bram Vandoren <brambi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14050_30139973.1122924845969"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------=_Part_14050_30139973.1122924845969
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,=20
I try to configure suspend to ram on my new Acer TravelMate 4651lci. I adde=
d=20
the option acpi_sleep=3Ds3_bios to my boot loader.=20

I can correctly suspend the laptop (echo -n mem > /sys/power/state). When I=
=20
enter a key the laptop resumes also. Unfortunately the laptop freezes=20
approximately 20 seconds later. The system doesn't react any more. I also d=
o=20
not get any error message on the screen.=20

I uploaded lspci, dmidecode, acpidmp and lspci -vv and interrupts to my=20
website:=20
http://bram.be/lspci.txt=20
http://bram.be/dmidecode.txt=20
http://bram.be/acpidump.txt=20
http://bram.be/interrupts.txt=20

I tried it with several kernels (ubuntu 2.6.10 and the latest
2.6.12.3<http://2.6.12.3>(with and without acpi patch)). They all give
the same result.

Any ideas on how to fix this?=20

Thanks,=20
Bram.

------=_Part_14050_30139973.1122924845969
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
<br>
I try to configure suspend to ram on my new Acer TravelMate 4651lci. I=20
added the option acpi_sleep=3Ds3_bios to my boot loader.
<br>

<br>
I can correctly suspend the laptop (echo -n mem &gt; /sys/power/state).
When I enter a key the laptop resumes also. Unfortunately the laptop
freezes approximately 20 seconds later. The system doesn't react any
more. I also do not get any error message on the screen.
<br>

<br>
I uploaded lspci, dmidecode, acpidmp and lspci -vv and interrupts to my=20
website:
<br>
<a class=3D"moz-txt-link-freetext" href=3D"http://bram.be/lspci.txt">http:/=
/bram.be/lspci.txt</a>
<br>
<a class=3D"moz-txt-link-freetext" href=3D"http://bram.be/dmidecode.txt">ht=
tp://bram.be/dmidecode.txt</a>
<br>
<a class=3D"moz-txt-link-freetext" href=3D"http://bram.be/acpidump.txt">htt=
p://bram.be/acpidump.txt</a>
<br>
<a class=3D"moz-txt-link-freetext" href=3D"http://bram.be/interrupts.txt">h=
ttp://bram.be/interrupts.txt</a>
<br>

<br>
I tried it with several kernels (ubuntu 2.6.10 and the latest <a href=3D"ht=
tp://2.6.12.3">2.6.12.3</a>=20
(with and without acpi patch)). They all give the same result.
<br>

<br>
Any ideas on how to fix this?
<br>

<br>
Thanks,
<br>
Bram.

------=_Part_14050_30139973.1122924845969--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
