From: valvoline <valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Subject: Re: ACPI and APM
Date: Sun, 25 Aug 2002 12:00:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020825120034.4f3ce5b4.valvoline@tiscalinet.it>
References: <20020824192026.0e4811bf.valvoline@tiscalinet.it>
	<Pine.LNX.4.44.0208241801180.18729-100000@corsa.pop-pr.rnp.br>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.Fd.uRJK)t83+S4"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0208241801180.18729-100000-vpvw8pZwXnYeYW3BdkEXlAh0onu2mTI+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=.Fd.uRJK)t83+S4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2002 18:12:58 -0300 (BRT)
Christian Lyra <lyra-kkgK+NGu78pV51zT55DYLA@public.gmane.org> wrote:



> 	I would sugest that you didnt disable button flags in ACPI, and
> just create a script that on a button event generated from ACPI to just
> call apm -s (I think APM doesnt understand the Lid Button).

It's a great idea! :)...i'll try as soon as possible, and i'll send you
my feedback.

> to test your hack/patch. May you sent me a patch or the guidelines so I
> can test it too?

you can download the patch from this url:

http://www.vrlteam.org/patch-apm_acpi_010.tgz

the patch contain both my "kernel hacking" and the official
20020821-patch.diff, so you have to apply the patch to a clean 2.4.19
kernel tree.

after that you have to configure your kernel. enable both APM and
ACPI features. i've flagged the following:

Under APM Support:

- Enable PM at boot time
- Enable console blanking using APM

"Allow Interrupts during APM BIOS calls" and "Use real mode APM BIOS
call to power off" doesn't work for me (the system become instable during
apm --suspend or apm --standby calls, and a shutdown -h now, command
produce a reboot of the machine...), just try your machine, and give me 
your feedback.

Under ACPI Support:

- Enable ACPI Support
- Button 
- Fan
- Processor
- Thermal Zone


I've disable the "AC Adapter" and "Battery" to avoid conflicts with
APM support, but again, you can try.

After that, recompile your kernel, and get a try on it. you'll notice,
that "sleep" voice under /proc/acpi, will not be available, but
APM --suspend and --standby features, will works fine!


-- 
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]

--=.Fd.uRJK)t83+S4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9aKrFB2olYR1ntN0RAuThAJ44mbsuez3UpJQFg70VQRKwL1zr+QCg34+W
yUVSHZMOw45/4hETICFG+ag=
=UzuH
-----END PGP SIGNATURE-----

--=.Fd.uRJK)t83+S4--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
