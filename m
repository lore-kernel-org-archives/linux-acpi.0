From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas-IPLA6wC0ETtg9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: [Suspend2-devel] Cause of Suspend2 resume failures on
 Toshiba laptops
Date: Tue, 08 Mar 2005 11:02:42 +0100
Message-ID: <200503081102.46841.sebas@vizZzion.org>
References: <16A54BF5D6E14E4D916CE26C9AD305750155ECAA@pdsmsx402.ccr.corp.intel.com>
 <20050308094711.GC20154@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=nextPart3306182.WcW4gLaKB4
Content-Transfer-Encoding: 7bit
In-reply-to: <20050308094711.GC20154-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: suspend2-devel-g/J2nbn7YhmWn91e4EydUaxOck334EZe@public.gmane.org
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart3306182.WcW4gLaKB4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 08 March 2005 10:47, Bernard Blackham wrote:
> On Tue, Mar 08, 2005 at 02:58:01PM +0800, Li, Shaohua wrote:
> > >Removing the check resolves this issue (patch attached). Is this an
> > >adequate fix?
> >
> > Great analyzing! I guess Both S3, swsusp, and swsusp2 can't suffer from
> > this bug. Sure this patch hasn't any side effect.
>
> At least one user has reported that this patch makes the battery
> status unreadable. -
> http://lists.suspend2.net/lurker/message/20050306.201243.cbbca9ea.en.html
>
> I don't know why this is the case yet, but I'd hesitate to use it
> until this is sorted out.

That's me though, who is prepared to do tests for you to resolve the issue.

Please shoot right away...

Cheers,

sebas
=2D-=20
  http://vizZzion.org   |   GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
I contend that we are both atheists. I just believe in one fewer god than y=
ou=20
do. When you understand why you dismiss all the other possible gods, you wi=
ll=20
understand why I dismiss yours. - Sir Stephen Henry Roberts


--nextPart3306182.WcW4gLaKB4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQEVAwUAQi14RmdNh9WRGQ75AQKgtggAqgNl3oxPh4GybAlINUPsNu25RwEg4MAn
v5toBbepisz6V9GeZSLqPNedrN24ZzUt0h06GfMVjd6DLE3s2beH/8nXMrPGfBHD
9umURkjMD/hUQQTlVGOu7l0wiQEZykuCIwuADNzs7p/fZ4frCfdCKnzDBn6M5CR0
X6abMmcABQPR6O2T7sSmCio5Pf8k7YrvAmhuD/imtSzQ4jeZffNqPpyoNxTwvXYu
ITC2Q2f+gxhwaozgKJ6K7s0EnB79fabYR0GN5Oz0xfCjPC9hHn2TqLB/evYogVEn
8FgWrUoSzS34f/n+jSq9+J5+elmJ848wNMqx+h15aPs3XOfCDJvTIA==
=e7Sf
-----END PGP SIGNATURE-----

--nextPart3306182.WcW4gLaKB4--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
