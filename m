From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Reading /proc/acpi/battery/BAT0/info causes high latency on Dell Lattitude D800
Date: Sat, 26 Mar 2005 22:59:54 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC15F@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
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
To: Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Do you have this kind of problem before? Or just this kernel.

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Neil Brown
>Sent: 2005=C4=EA3=D4=C226=C8=D5 20:04
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Reading /proc/acpi/battery/BAT0/info causes=20
>high latency on Dell Lattitude D800
>
>
>Hi,
> I have (another) problem with ACPI on my D800.
>I have an applet (xacpi) which reports my battery status etc, and
>every time it reads /proc/acpi/battery/BAT0/info (or .../BAT1/info),
>any music that I am listening to 'skips'.
>Below is an strace that shows nearly a 900ms pause in reading /info.
>There is also a smaller pause while reading /state. This=20
>doesn't seem to
>cause problems when playing music.
>
>What can I do to try to get to the bottom of this problem and
>(hopefully) fix it.
>
>I am using=20
>	2.6.12-rc1-mm3
>which includes
>        ACPI: Subsystem revision 20050309
>
>though this is not a new problem.
>
>Thanks,
>NeilBrown
>
>1111838175.178580 open("/proc/acpi/battery/BAT0/info", O_RDONLY) =3D 5
>1111838175.179059 fstat64(5, {st_mode=3DS_IFREG|0444, st_size=3D0,=20
>...}) =3D 0
>1111838175.179552 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,=20
>MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb7f81000
>1111838175.180195 read(5, "present:                =20
>yes\ndes"..., 1024) =3D 432
>1111838176.041591 read(5, "", 1024)     =3D 0
>1111838176.042034 close(5)              =3D 0
>1111838176.042468 munmap(0xb7f81000, 4096) =3D 0
>1111838176.043018 open("/proc/acpi/battery/BAT0/state", O_RDONLY) =3D 5
>1111838176.043506 fstat64(5, {st_mode=3DS_IFREG|0444, st_size=3D0,=20
>...}) =3D 0
>1111838176.043998 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,=20
>MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb7f81000
>1111838176.044595 read(5, "present:                =20
>yes\ncap"..., 1024) =3D 192
>1111838176.227703 read(5, "", 1024)     =3D 0
>1111838176.228149 close(5)              =3D 0
>1111838176.228580 munmap(0xb7f81000, 4096) =3D 0
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
