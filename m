From: "Georg C. F. Greve" <greve@gnu.org>
Subject: status update for current development on ASUS M2N
Date: Mon, 27 Sep 2004 10:47:23 +0200
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <m3lleww12c.fsf@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="20040927104723+0200-64811042-41730217126890533";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
Errors-To: softwaresuspend-devel-admin@berlios.de
List-Help: <mailto:softwaresuspend-devel-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-devel@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-devel/>
To: acpi-devel@lists.sourceforge.net
Cc: SoftwareSuspend-devel@lists.berlios.de
List-Id: linux-acpi@vger.kernel.org

--20040927104723+0200-64811042-41730217126890533
Content-Type: multipart/mixed; boundary="20040927104723+020085475089-793012495181543"

--20040927104723+020085475089-793012495181543

Hi all,

FYI:

My latest kernel, which looks like

--20040927104723+020085475089-793012495181543
Content-Disposition: attachment; filename=patch-2.6.9-rc2-plus_4.txt
Content-Description: Patch description for 2.6.9-rc2-plus_4

Patches contained:

linux-2.6.8
patch-2.6.9-rc2

software-suspend-108-for-2.6.9-rc2 (without kdb)
software-suspend-108-fixes (from http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-2.6-software-suspend-fixes.patch?rev=1.3)

2.6.9-rc2-mm3/bk-acpi.patch
	./acpi-compile-fix.patch
	./acpi-x86_64-build-fix.patch
	./bk-agpgart.patch
	./bk-alsa.patch
	./bk-cpufreq.patch

ipw2100-0.54

arch/i386/kernel/i8259.c: 

  * changed device_initcall(i8259A_init_sysfs);
         to late_initcall(i8259A_init_sysfs);
    (needed for suspend to RAM)

Makefile:

  * added -plus version


--20040927104723+020085475089-793012495181543
Content-Transfer-Encoding: quoted-printable



seems not so bad.

Both suspend to ram and suspend to disk via swsusp2 (108) appear to
work fine. I completed a few cycles without problems.

However: If I suspend to ram once and then suspend to disk, resume
From=20disk works fine, but about 20 seconds to 1 minute later, the
load suddenly jumps to 100% and stays there.

The kacpid process seems to run wild and eat all available time, it
looks like some kind of wild loop, but there is no output. I can
normally shut the machine down -- although it takes a while.

I've tried compiling ACPI as modules and unloading the modules as well
as restarting the acpid before/after suspend to disk. Upon reloading
the modules things hang with "thermal" -- but that seems arbitrary,
the effect still shows up even if no thermal is loaded.

Not sure this helps anyone improve things, still wanted to give you
the feedback, though.

Regards,
Georg

=2D-=20
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20040927104723+020085475089-793012495181543--

--20040927104723+0200-64811042-41730217126890533
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBV9ObbvivwoZXSsoRAr11AJ9qnCAmCU6wNQqhQzZiHPqEN0ZgKwCdGbEY
mZaPcB/3wVzBIBkovQ/ELqE=
=Zz46
-----END PGP SIGNATURE-----
--20040927104723+0200-64811042-41730217126890533--
