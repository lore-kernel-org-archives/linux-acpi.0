From: Frederic Dernbach <fredatwork-GANU6spQydw@public.gmane.org>
Subject: Re: Failed compile kernel with apci patch applied
Date: 23 Oct 2003 13:18:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1066907937.1880.11.camel@localhost.localdomain>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC87C5@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC87C5-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI dlevel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len,

I followed the steps you recommended.

I restarted the whole process from scratch. I installed the 2.4.22
baseline kernel source files as well as the 2.4.22 acpi patch
(acpi-20031002-2.4.22.diff.gz).

"make bzImage" went fine. "make modules" went fine I presume (I did not
spot any error in the std output or std error that I kept).

However "make modules_install" terminated with :
depmod:*** Unresolved symbols in
/lib/modules/2.4.22-22-acpi/kernel/crypto/autoload.o
depmod:		crypto_alg_lookup
depmod:*** Unresolved symbols in
/lib/modules/2.4.22-22-acpi/kernel/crypto/proc.o
depmod:		crypto_alg_sem
depmod:		crypto_alg_list

Is there anythting wrong that I dod ? Can I continue installing the
newly compiles kernel ? (I'm a newbee with linux kernel).

For your information that my .config file include the option
"Cryptographic API" in the "Cyptographic" options of the kernel config
menu (I use "make menuconfig"). It is checked. Maybe it has something to
do with.

Fred

Le mer 22/10/2003 =C3=A0 19:20, Brown, Len a =C3=A9crit :
> The ACPI patches are against the baseline kernel.
> If they applies to a distro (Red Hat) kernel, then that is mostly luck.
>=20
> But even if they did, you probably would not want to run that one because
> 20021212 is over 10 months old.
>=20
> [Indeed, your note tells me that I should delete the old files
>  On sourceforge so that nobody else makes the same mistake.]
>=20
> The oldest baseline kernel we maintain a current ACPI patch against is 2.=
4.22
>=20
> Get your 2.4.22 baseline kernel source here:
> http://kernel.org/
>=20
> And get your ACPI patch against it here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2=
.4.22/
>=20
> Other alternatives include replacing RH9 with a pre-release of Red Hat Fe=
dora Core 1, which includes pretty recent ACPI code.  http://fedora.redhat.=
com/  or run SuSE Linux 9.0, which is shipping with very recent ACPI code. =
Etc.
>=20
> Cheers,
> -Len
>=20
>=20
>=20
>=20
> > -----Original Message-----
> > From: acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> > [mailto:acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf=20
> > Of Frederic Dernbach
> > Sent: Wednesday, October 22, 2003 11:52 AM
> > To: acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI-bugzilla] Failed compile RH 9.0 kernel with=20
> > apci patch applied
> >=20
> >=20
> > Hello,
> >=20
> > I cannot compile RH 9.=C3=A0 kernel after applying the acpi patch.
> >=20
> > "make bzImage" returns the following error :
> > make[2]: Entering directory `/usr/src/linux-2.4.20-8/net'
> > cc  -D__KERNEL__ -I/usr/src/linux-2.4.20-8/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing=20
> > -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di386=
 =20
> > -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dsocket  -c=20
> > -o socket.o
> > socket.c
> > In file included from
> > /usr/src/linux-2.4.20-8/include/net/tcp.h:1041,       =20
> > from /usr/src/linux-2.4.20-8/include/net/tux.h:38,
> > from socket.c:86:
> > /usr/src/linux-2.4.20-8/include/net/tcp_ecn.h: In function
> > `TCP_ECN_send':
> >=20
> > /usr/src/linux-2.4.20-8/include/net/tcp_ecn.h:54: union has no
> > member named `af_inet'
> > /usr/src/linux-2.4.20-8/include/net/tcp_ecn.h:61: union has no member
> > named
> > `af_inet'
> > make[2]: *** [socket.o] Error 1
> > make[2]: Leaving directory `/usr/src/linux-2.4.20-8/net'
> > make[1]: *** [first_rule] Error 2
> > make[1]: Leaving directory `/usr/src/linux-2.4.20-8/net'
> > make: *** [_dir_net] Error 2
> >=20
> >=20
> >=20
> > Here is what I do :
> > - I'm not an experimented Linux administrator. I love RedHat and I use
> > it on a desktop computer (private stuff, not professional).
> > - I bought a brand new HP Pavillion ze 5400 and I struggle install RH
> > 9.0 on it. Therefore I follow the instructions given on this Web page:
> > http://home.elp.rr.com/mcghees/ze5470us.htm
> > - I installed RH 9.0 (all packages from the 3 CDs of binary
> > distribution). Therefore, I have the sources of kernel 2.4.20-8 on the
> > machine. I have kudzu and pcmcia not started (as instructed by the
> > WebPage)
> > - I installed the acpi patch (acpi-20021212-2.4.20.diff.gz) as
> > requested.
> > - I configured the kernel compilation options as requested in the Web
> > page ("make xconfig"):
> > a/ I chose "Pentium II / Celeron / Pentium Pro" under the=20
> > processor type
> > and features button (I have an Intel Celeron 2.2 GHz on the labtop).I
> > selected 'n' n for Toshiba and Dell Laptop support.  I made sure Local
> > APIC support on uniprocessors is set to n.=20
> > b/ Under the General setup button,  I selected the ACPI=20
> > Support button,
> > selected y for everything except Toshiba Laptop Extras.=20
> > c/ under the FileSystems button, I selected m for NTFS system support
> > - I started compile the kernel. "Make dep" went OK. But "make bzImage"
> > went wrong and produced the compilation error.
> >=20
> > What is the patch I should usr with a 2.4.20-8 kernel source rpm ?
> > =20
> > Hope you can help me because this goes beyond my capabilities.
> >=20
> > Fred
> >=20
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by OSDN developer relations
> > Here's your chance to show off your extensive product knowledge
> > We want to know what you know. Tell us and you have a chance=20
> > to win $100
> > http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
> > _______________________________________________
> > acpi-bugzilla mailing list
> > acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-bugzilla
> >=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by OSDN developer relations
> Here's your chance to show off your extensive product knowledge
> We want to know what you know. Tell us and you have a chance to win $100
> http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
