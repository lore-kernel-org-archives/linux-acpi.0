From: Tomasz Kojm <tkojm-Vl9ZkupcxcOsTnJN9+BGXg@public.gmane.org>
Subject: Re: Suspend2ram on Toshiba Tecra A3 OR problem with S3 on new 915PM
 chipset system appears to be with SATA/IDE
Date: Fri, 29 Apr 2005 02:38:42 +0200
Message-ID: <20050429023842.4d927bdf@Wierszokleta.pl>
References: <200504272244.j3RMibEf032018@fnapcf.fnal.gov>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Fri__29_Apr_2005_02_38_42_+0200_0Y=vWrneUpCn6s1Q";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504272244.j3RMibEf032018-vjLZTnyA75mSFZzDrWHoTA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ron_-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ron-vjLZTnyA75mSFZzDrWHoTA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ron-13hema8v3vg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Signature_Fri__29_Apr_2005_02_38_42_+0200_0Y=vWrneUpCn6s1Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Apr 2005 17:44:37 -0500
Ron Rechenmacher <ron-vjLZTnyA75mSFZzDrWHoTA@public.gmane.org> wrote:

> Hi,
>=20
> I'm wondering if I'm having the same problem.
> I was using a Dell M60 w/ 2.6.10 and 2.6.11.7 with no problems.
> The M60 has 855PM chipset with integrated (ICH4) ATA IDE and the disk
> is a parallel IDE disk.
>=20
> The M70 is 915PM based with integrated SATA controller which somehow
> (experts know?) can work with the IDE driver, but slow, but with the
> SATA driver + SCSI works better. Anyway, the disk is still a parallel
> IDE disk, so I suppose there must be some serial <-> parallel magic=20
> going on.
> Anywho, when I suspend, all seems well, but when I try to wake, the
> disk doesn't come back and if I wait long enough, I get some:
>      journal commit I/O error
> and sometimes some other disk timeout errors.
> Sometimes the video screen comes pack and the mouse works and I can
> type, but, b/c the disk isn't working, I can't do anything. Sometimes
> the video doesn't come back, but the caps lock still works.

In my case the video (integrated Intel 915GM graphic chipset) never=20
resumes correctly. However, I've noticed very similar issues with the
disk. Sometimes the hdd led is always on after resume, sometimes not.
With the old SATA/IDE driver the disk seems to perform some operations
but at the end the system crashes totally and even the caps lock doesn't
work.

As an open-source developer I know from autopsy how much such e-mail are
frustrating to the developers. However it's impossible to me to prepare
a valuable bug report on bugzilla - at the moment I see no way to
reenable the LCD after resume (no acpi_sleep flag works on this system)
and the system crashes every time eliminating remote access to a
console.

Thanks,

--=20
   oo    .....         Tomasz Kojm <tkojm-Vl9ZkupcxcOsTnJN9+BGXg@public.gmane.org>
  (\/)\.........         http://www.ClamAV.net/gpg/tkojm.gpg
     \..........._         0DCA5A08407D5288279DB43454822DC8985A444B
       //\   /\              Fri Apr 29 02:37:01 CEST 2005

--Signature_Fri__29_Apr_2005_02_38_42_+0200_0Y=vWrneUpCn6s1Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCcYISVIItyJhaREsRArZQAJ0S4pqVViajzpV6DcLKilbQyFElMwCfbpsP
zqfIuhet4FovSFZFm8NquRI=
=fHXs
-----END PGP SIGNATURE-----

--Signature_Fri__29_Apr_2005_02_38_42_+0200_0Y=vWrneUpCn6s1Q--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
