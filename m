From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Sun, 30 May 2004 21:00:33 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405302100.36915.andre@eisenbach.com>
References: <200405180213.34603.andre@eisenbach.com> <200405280536.50261.andre@eisenbach.com> <20040529114512.GD25121@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_k3quAOJ2PORJbJF";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040529114512.GD25121-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-02=_k3quAOJ2PORJbJF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag Mai 29 2004 04:45 schrieb Pavel Machek:
> Can you get any data out of notebook? Like 8 leds on paralel port, pci
> card decoding port 0x80 etc? [That's where soldering iron might be
> usefull].

Yes, I can hook up the parallel port. Just let me know where we're gonna us=
e=20
it.

> > 7. --> Not even 1/2 second later, all off. Notebook is off. On/Off
> > LED off
>
> Easy. Insert infinite loop at begining of wakeup_start. If it hangs,
> you know it reached wakeup_start, and fix wakeup code. If it does not,
> we left hardware at "bad" (i.e. bios did not like it) state before
> suspend, fix suspend code. (Turn off APIC etc). [This is where your
> assembly skills come handy.]

I put an endless loop into wakeup_start. Nothing changed. Same behaviour. I=
=20
also recompiled the kernel without APIC, but I'm not sure thats what you=20
meant.

Where do I find the suspend code?

> PS: When stuck, try asking your black cat :-).

She's sleeping. A lot.

;)

--Boundary-02=_k3quAOJ2PORJbJF
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAuq3k5DBE808V5icRAu+VAKCzRCDOj5zko1KGNKguG5XXqDnFQQCfR8BJ
XrGcEwNeTGQ85ryNj4wunAo=
=y2oR
-----END PGP SIGNATURE-----

--Boundary-02=_k3quAOJ2PORJbJF--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
