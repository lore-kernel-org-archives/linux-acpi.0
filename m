From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: [Fwd: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume
 on Centrino notebook (contains agp, lapic, swsusp)]
Date: Wed, 11 Feb 2004 13:50:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3d68l3hmt.fsf@reason.gnu-hamburg>
References: <3ACA40606221794F80A5670F0AF15F8401CBB68D@PDSMSX403.ccr.corp.intel.com>
	<m3smhhakb3.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3smhhakb3.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org> (Georg C. F. Greve's
 message of "Wed, 11 Feb 2004 13:10:24 +0100")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, =?iso-8859-15?q?S=E9rgio_Monteiro_Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

 || On Wed, 11 Feb 2004 11:04:55 +0800
 || "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: 

 yl> To issue of booting hang with APIC &ACPI, please verify
 yl> http://bugzilla.kernel.org/attachment.cgi?id=1257&action=view can
 yl> help. Maybe we need to figure out what's wrong with the SMM &
 yl> APIC timer.


 || On Wed, 11 Feb 2004 13:10:24 +0100
 || "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org> wrote: 

 gg> Just checked this, compiled a 2.6.2 with ACPI 20040116 + the
 gg> patch above. That patch rejects on arch/i386/kernel/apic.c
 gg> because the ACPI patch (I believe) contains a half-fix for the
 gg> issue, so the setup routine looks like

 gg>  ver = GET_APIC_VERSION(apic_read(APIC_LVR));
 gg>  lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
 gg>  if (!APIC_INTEGRATED(ver))
 gg>     lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
 gg>  apic_write_around(APIC_LVTT, lvtt_value);

 gg> the patch applies fine to drivers/acpi/bus.c, which is apparently
 gg> missing in the ACPI 20040116 patch.

Interesting side-effect: the kernel doesn't compile with ACPI but no
APIC enabled. 

Apparently, the patch for drivers/apci/bus.c should have some "ifdefs"
added to make sure these calls only get included when LAPIC is
enabled:

drivers/built-in.o(.init.text+0xf12): In function `acpi_bus_init':
: undefined reference to `disable_APIC_timer'
drivers/built-in.o(.init.text+0xf9c): In function `acpi_bus_init':
: undefined reference to `enable_APIC_timer'
drivers/built-in.o(.init.text+0xff5): In function `acpi_bus_init':
: undefined reference to `enable_APIC_timer'
make: *** [.tmp_vmlinux1] Error 1

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFAKiT6bvivwoZXSsoRAogXAJ47h/T2UMf10eKu9v1WT83ea6NfRgCgti1l
Bx9cjx6Q0AWI/2EbX2YyKx8=
=YRwn
-----END PGP MESSAGE-----
--==-=-=--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
