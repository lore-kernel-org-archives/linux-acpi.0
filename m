From: "Georg C. F. Greve" <greve@gnu.org>
Subject: Re: status update for current development on ASUS M2N
Date: Mon, 04 Oct 2004 12:05:38 +0200
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <m3is9qx0gd.fsf@reason.gnu-hamburg>
References: <20040930214808.B5D9C3AA515@ws5-8.us4.outblaze.com>
	<m3ekkiqdcy.fsf@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="20041004120538+0200-29538357-35042719-26978459";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
In-Reply-To: <m3ekkiqdcy.fsf@brain.gnuhh.org> (Georg C. F. Greve's message of
	"Sat, 02 Oct 2004 00:31:57 +0200")
Errors-To: softwaresuspend-devel-admin@berlios.de
List-Help: <mailto:softwaresuspend-devel-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-devel@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-devel/>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: ACPI List <acpi-devel@lists.sourceforge.net>, SoftwareSuspend-Devel <softwaresuspend-devel@lists.berlios.de>
List-Id: linux-acpi@vger.kernel.org

--20041004120538+0200-29538357-35042719-26978459
Content-Type: multipart/mixed; boundary="20041004120538+0200127862624-98430044129197691"

--20041004120538+0200127862624-98430044129197691

 || On Sat, 02 Oct 2004 00:31:57 +0200
 || "Georg C. F. Greve" <greve@gnu.org> wrote: 

 nc> If you do a photo, just send it to me, please.

 gg> Just did that. Please confirm that you got it and it did not get
 gg> stuck anywhere on the way.

I hope you got it... in the days of spam I am not so confident about
the reliability of email anymore.

Quick update:

The situation persists for the kernel


--20041004120538+0200127862624-98430044129197691
Content-Disposition: attachment; filename=patch-2.6.9-rc3-plus_1.txt

Patches contained:

linux-2.6.8
patch-2.6.9-rc3

software-suspend-2.1-rc1-for-2.6.9-rc3

2.6.9-rc3-mm1/swsusp-fix-highmem.patch
	bk-acpi.patch
	acpi-compile-fix.patch
	acpi-x86_64-build-fix.patch
	bk-agpart.patch
	bk-alsa.patch
	bk-cpufreq.patch
	cpufreq-ondemand-prevent-various-divide-underflows.patch
	cpufreq-ondemand-account-iowait-as-idle-time.patch

ipw2100-0.55

arch/i386/kernel/i8259.c:

  * changed device_initcall(i8259A_init_sysfs);
         to late_initcall(i8259A_init_sysfs);
    (needed for suspend to RAM)

Makefile:

  * added -plus version


--20041004120538+0200127862624-98430044129197691


in the same way, as far as I can tell.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20041004120538+0200127862624-98430044129197691--

--20041004120538+0200-29538357-35042719-26978459
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBYSBybvivwoZXSsoRAlN+AJ9GA4p5RK+/BARqcCAYWX2trHaSbQCeL017
BeUjp3nEt35bGnv0kkljDeE=
=sig/
-----END PGP SIGNATURE-----
--20041004120538+0200-29538357-35042719-26978459--
