From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI-bugzilla] Failed compile RH 9.0 kernel with apci patch applied
Date: Wed, 22 Oct 2003 13:20:50 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC87C5@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frederic Dernbach <fredatwork-GANU6spQydw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The ACPI patches are against the baseline kernel.
If they applies to a distro (Red Hat) kernel, then that is mostly luck.

But even if they did, you probably would not want to run that one =
because
20021212 is over 10 months old.

[Indeed, your note tells me that I should delete the old files
 On sourceforge so that nobody else makes the same mistake.]

The oldest baseline kernel we maintain a current ACPI patch against is =
2.4.22

Get your 2.4.22 baseline kernel source here:
http://kernel.org/

And get your ACPI patch against it here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2=
.4.22/

Other alternatives include replacing RH9 with a pre-release of Red Hat =
Fedora Core 1, which includes pretty recent ACPI code.  =
http://fedora.redhat.com/  or run SuSE Linux 9.0, which is shipping with =
very recent ACPI code. Etc.

Cheers,
-Len




> -----Original Message-----
> From: acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf=20
> Of Frederic Dernbach
> Sent: Wednesday, October 22, 2003 11:52 AM
> To: acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI-bugzilla] Failed compile RH 9.0 kernel with=20
> apci patch applied
>=20
>=20
> Hello,
>=20
> I cannot compile RH 9.=E0 kernel after applying the acpi patch.
>=20
> "make bzImage" returns the following error :
> make[2]: Entering directory `/usr/src/linux-2.4.20-8/net'
> cc  -D__KERNEL__ -I/usr/src/linux-2.4.20-8/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing=20
> -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di386 =20
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dsocket  -c=20
> -o socket.o
> socket.c
> In file included from
> /usr/src/linux-2.4.20-8/include/net/tcp.h:1041,       =20
> from /usr/src/linux-2.4.20-8/include/net/tux.h:38,
> from socket.c:86:
> /usr/src/linux-2.4.20-8/include/net/tcp_ecn.h: In function
> `TCP_ECN_send':
>=20
> /usr/src/linux-2.4.20-8/include/net/tcp_ecn.h:54: union has no
> member named `af_inet'
> /usr/src/linux-2.4.20-8/include/net/tcp_ecn.h:61: union has no member
> named
> `af_inet'
> make[2]: *** [socket.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.20-8/net'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.20-8/net'
> make: *** [_dir_net] Error 2
>=20
>=20
>=20
> Here is what I do :
> - I'm not an experimented Linux administrator. I love RedHat and I use
> it on a desktop computer (private stuff, not professional).
> - I bought a brand new HP Pavillion ze 5400 and I struggle install RH
> 9.0 on it. Therefore I follow the instructions given on this Web page:
> http://home.elp.rr.com/mcghees/ze5470us.htm
> - I installed RH 9.0 (all packages from the 3 CDs of binary
> distribution). Therefore, I have the sources of kernel 2.4.20-8 on the
> machine. I have kudzu and pcmcia not started (as instructed by the
> WebPage)
> - I installed the acpi patch (acpi-20021212-2.4.20.diff.gz) as
> requested.
> - I configured the kernel compilation options as requested in the Web
> page ("make xconfig"):
> a/ I chose "Pentium II / Celeron / Pentium Pro" under the=20
> processor type
> and features button (I have an Intel Celeron 2.2 GHz on the labtop).I
> selected 'n' n for Toshiba and Dell Laptop support.  I made sure Local
> APIC support on uniprocessors is set to n.=20
> b/ Under the General setup button,  I selected the ACPI=20
> Support button,
> selected y for everything except Toshiba Laptop Extras.=20
> c/ under the FileSystems button, I selected m for NTFS system support
> - I started compile the kernel. "Make dep" went OK. But "make bzImage"
> went wrong and produced the compilation error.
>=20
> What is the patch I should usr with a 2.4.20-8 kernel source rpm ?
> =20
> Hope you can help me because this goes beyond my capabilities.
>=20
> Fred
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by OSDN developer relations
> Here's your chance to show off your extensive product knowledge
> We want to know what you know. Tell us and you have a chance=20
> to win $100
> http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
> _______________________________________________
> acpi-bugzilla mailing list
> acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-bugzilla
>=20


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
