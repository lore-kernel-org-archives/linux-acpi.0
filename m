From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch
 for 0.54 (version 3)
Date: Mon, 27 Sep 2004 13:54:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4157FF69.7040204@pca.it>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403> <413EE1EA.2070307@pca.it> <413F02E7.3060005@pca.it> <20040914222905.GA17380@elf.ucw.cz> <4147870C.9090003@pca.it> <20040917085110.GA22859@elf.ucw.cz>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040208020500000401070901"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040917085110.GA22859-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040208020500000401070901
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 09/17/04 10:51, Pavel Machek wrote:
>>On the other hand, using the /sys call the machine power off correctly
>>in suspending, while using the /proc call actually I should press 4-sec
>>the power button after 15-20sec the latest suspending screen.
>>
>>BTW, I'm on 2.6.9-rc2 with no other patches.
> Go to -mm kernel. Vanilla has *very* old version of the patch.
it seems that the mail I sent last Friday never reached the
mailing-list. Here it is.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBV/9nVAp7Xm10JmkRAi93AKCEOn7+S31Lsu+l9iCpEUsSuKVUJACgjunD
2SnhVjwvXbyTej1m9loRFsg=
=4MSb
-----END PGP SIGNATURE-----

--------------040208020500000401070901
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Date: Fri, 24 Sep 2004 13:42:24 +0200
From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [ACPI] Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch for 0.54 (version 3)
Message-ID: <20040924114224.GA5596@localhost>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403> <413EE1EA.2070307-wlebWZzHoyE@public.gmane.org> <413F02E7.3060005-wlebWZzHoyE@public.gmane.org> <20040914222905.GA17380-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org> <4147870C.9090003-wlebWZzHoyE@public.gmane.org> <20040917085110.GA22859-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20040917085110.GA22859-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
User-Agent: Mutt/1.5.6+20040818i


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 17, 2004 at 10:51:10AM +0200, Pavel Machek wrote:
> > On the other hand, using the /sys call the machine power off correctly
> > in suspending, while using the /proc call actually I should press 4-sec
> > the power button after 15-20sec the latest suspending screen.
> >=20
> > BTW, I'm on 2.6.9-rc2 with no other patches.
> Go to -mm kernel. Vanilla has *very* old version of the patch.
I tried 2.6.9-rc2-mm2 and here the results:

- echo 4 > /proc/acpi/sleep
after 10m the suspend process is still going on and the data written
to the swap partition are only 1% (and so I stopped the process ;-) )

- echo disk > /sys/power/state
the suspend process seems ok, but the resume arrives suddenly after the
suspend is finished (I mean, the computer doesn't power off)

Anyway, I saw that in the kernel there's no more the choice for pmdisk:
is this normal?

BTW, as I counted the time for -mm2, I did the same for a vanilla 2.6.9
+ latest ACPI patch:

- echo 4 > /proc/acpi/sleep
40s and now the computer automatically power off (AFAIR the only
driver upgrade is the 'ipw2100', where I used the latest patch posted in
this list, too)

- echo disk > /sys/power/state
30s to the power off

Now, Pavel, I ask you the same question Karol already answered: as I've
the choice between swsusp and pmdisk, Karol suggested to use pmdisk. And
you?

Thx, bye,
Gismo / Luca

PS all the test were performed as root and from GNOME/XFree86-4.3.0
(Debian, 'radeon' driver included)

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBVAggVAp7Xm10JmkRAtIQAKCH+zlpP1l4QcT10YYDf087nDhkUgCfeJKh
xUM7WNF4E8CzhbZOQ6TbJ7I=
=CJEh
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--


--------------040208020500000401070901--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
