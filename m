From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Fri, 18 Feb 2005 00:19:08 +0100
Message-ID: <87ekfe7p1v.fsf@gismo.pca.it>
References: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
In-Reply-To: <20050214211105.GA12808-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org> (Pavel Machek's message of
 "Mon, 14 Feb 2005 22:11:05 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

Hello Pavel!

On Mon 14 Feb 2005 22:11, Pavel Machek wrote:
> Stefan provided me initial list of machines where S3 works (including
> video). If you have machine that is not on the list, please send me a
> diff. If you have eMachines... I'd like you to try playing with

Sorry, but a diff of what? Of the list?

> Table of known working systems:
>
> Model                           hack (or "how to do it")
> ------------------------------------------------------------------------------
IBM ThinkPad T42p (2373-GTG [1])  acpi_sleep=s3_bios (2)

More info available upon request, but in general:

- Debian unstable
- vanilla kernel 2.6.10
- ACPI patch 20050125
- BlueZ patch -mh4
- IBM trackpoint patch [2]
- radeonfb
- radeon XFree86 4.3.0.dfsg.1-11
- all modules my laptop support installed (and loaded ;-) )
- I used a script that switch to vc1 and stop mysql (this is a known
  problem [3] [4]), then "echo -n [mem|disk] > /sys/power/state"

I've a working S4 with the same configuration, too. But it seems I
still suffer a problem about hwclock I already reported with another
laptop [5] [6]. In this case, the command proposed seems not working
anymore (I should test more deeply, just a question of time ;-) ).

Anyway, this laptop works very well!

I've also a docking station [7], I'll test with it ASAP.

Thx, bye,
Gismo / Luca

[1] http://www5.pc.ibm.com/ch/products.nsf/$wwwPartNumLookup/_UC2GTSE?OpenDocument
[2] http://people.clarkson.edu/~evanchsa/
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=259745
[4] http://bugs.mysql.com/bug.php?id=4596
[5] http://sourceforge.net/mailarchive/message.php?msg_id=9844751
[6] http://sourceforge.net/mailarchive/message.php?msg_id=9864402
[7] http://www5.pc.ibm.com/ch/products.nsf/$wwwPartNumLookup/_74P6733?OpenDocument

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCFSZuVAp7Xm10JmkRAsdJAJ9a7akid+HSKOlG9jbI1JQSDWeGkgCZAdWN
HOQAbgLCYlzk+gFYkoBQux0=
=zCko
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
