From: john <sorosj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Acer Extensa 3002 WLMi: DSDT fixed but system misses keyboard and mouse events
Date: Thu, 27 Oct 2005 18:42:33 +0200
Message-ID: <200510271842.37571.sorosj@gmail.com>
References: <435D43BB.2080702@rrz.uni-koeln.de> <loom.20051027T072257-534@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8770418.ila5oQMWpC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <loom.20051027T072257-534-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
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
Cc: chyras-foVc9aoM7mKFAqYqPk0RtA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart8770418.ila5oQMWpC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!
i've got the same notebook (tm4001LMI - 512mb ram - ati9600 - ipw2200).
I'm still using acpi-sbs kernel modules to read my battery, but this doesn'=
t=20
enable me to suspend-to-ram. if fixing the DSDT does, can you send your fix=
ed=20
dsdt as attachement? would be great to turn on-off the machine in a snap!
thanx ahead!
john

this hardware manufacturers vs linux users battle is getting on my nerves! =
I=20
had to battle to get my radeon card doing composite... >HAD ENOUGH< can't=20
believe that with this many (and on growing) number of linux users don't=20
matter to hardware manufacturers .


>On Thursday 27 October 2005 07:34, Radoslaw Chyra wrote:
> Hello!
>
> I can confirm the same problems (missing mouse events, and also bad
> keyboard behaviour, ie missing keystrokes and multiplying keys with single
> press when typing even not-so-fast).
>
> I fixed DSDT and patched it with acer-tm4xxx-sbs-cm.diff from the sbs-lin=
ux
> project. I have the same warnings from iasl (20050930) as Berthold Cogel.
>
> I have DSTD compiled right into kernel, and boot it with ec_burst=3D1.
>
> Kernel:
>
> linux-2.6.14-rc5-git6, suspend2
>
> (I've tried also 2.6.14-rc3, 2.6.13.1 witch ec_burst patch)
>
> Hardware:
>
> Acer TravelMate 4001 LMi
> ATI Mobility Radeon 9600
> Intel 802.11 b/g Wlan
>
> Regards
>
> Radoslaw
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--nextPart8770418.ila5oQMWpC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDYQN9gRmtYySq9WARAvFjAJ448fxBImkx7WHpbz/3MLGo1VH0tQCggmE4
6lhRCeJR6NTP1qo4HwjQHPA=
=YCgS
-----END PGP SIGNATURE-----

--nextPart8770418.ila5oQMWpC--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
